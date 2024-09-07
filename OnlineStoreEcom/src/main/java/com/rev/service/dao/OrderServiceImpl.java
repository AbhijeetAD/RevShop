package com.rev.service.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.rev.data.CartData;
import com.rev.data.OrderData;
import com.rev.data.OrderDetails;
import com.rev.data.TransactionData;
import com.rev.utilities.DBUtil;
import com.rev.utilities.MailMessage;

public class OrderServiceImpl implements com.rev.service.OrderService {

    @Override
    public String paymentSuccess(String userName, double paidAmount) {
        String status = "Order Placement Failed!";

        List<CartData> cartItems = new CartServiceImpl().getAllCartItems(userName);

        if (cartItems.isEmpty())
            return status;

        TransactionData transaction = new TransactionData(userName, paidAmount);
        boolean ordered = false;

        String transactionId = transaction.getTransactionId();

        for (CartData item : cartItems) {
            double amount = new ProductServiceImpl().getProductPrice(item.getProdId()) * item.getQuantity();

            OrderData order = new OrderData(transactionId, item.getProdId(), item.getQuantity(), amount);

            ordered = addOrder(order);
            if (!ordered)
                break;
            else {
                ordered = new CartServiceImpl().removeAProduct(item.getUserId(), item.getProdId());
            }

            if (!ordered)
                break;
            else
                ordered = new ProductServiceImpl().sellNProduct(item.getProdId(), item.getQuantity());

            if (!ordered)
                break;
        }

        if (ordered) {
            ordered = addTransaction(transaction);
            if (ordered) {
                MailMessage.transactionSuccess(userName, new UserServiceImpl().getFName(userName),
                        transaction.getTransactionId(), transaction.getTransAmount());
                status = "Order Placed Successfully!";
            }
        }

        return status;
    }

    @Override
    public boolean addOrder(OrderData order) {
        boolean flag = false;
        try (Connection con = DBUtil.provideConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO orders VALUES (?, ?, ?, ?, ?)")) {

            ps.setString(1, order.getTransactionId());
            ps.setString(2, order.getProductId());
            ps.setInt(3, order.getQuantity());
            ps.setDouble(4, order.getAmount());
            ps.setInt(5, 0);

            flag = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public boolean addTransaction(TransactionData transaction) {
        boolean flag = false;
        try (Connection con = DBUtil.provideConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO transactions VALUES (?, ?, ?, ?)")) {

            ps.setString(1, transaction.getTransactionId());
            ps.setString(2, transaction.getUserName());
            ps.setTimestamp(3, transaction.getTransDateTime());
            ps.setDouble(4, transaction.getTransAmount());

            flag = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public int countSoldItem(String prodId) {
        int count = 0;
        try (Connection con = DBUtil.provideConnection();
             PreparedStatement ps = con.prepareStatement("SELECT SUM(quantity) FROM orders WHERE prodid = ?")) {

            ps.setString(1, prodId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public List<OrderData> getAllOrders() {
        List<OrderData> orderList = new ArrayList<>();
        try (Connection con = DBUtil.provideConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM orders");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OrderData order = new OrderData(rs.getString("orderid"), rs.getString("prodid"),
                        rs.getInt("quantity"), rs.getDouble("amount"), rs.getInt("shipped"));
                orderList.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    @Override
    public List<OrderData> getOrdersByUserId(String emailId) {
        List<OrderData> orderList = new ArrayList<>();
        try (Connection con = DBUtil.provideConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT * FROM orders o INNER JOIN transactions t ON o.orderid = t.transid WHERE t.username = ?")) {

            ps.setString(1, emailId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderData order = new OrderData(rs.getString("t.transid"), rs.getString("t.prodid"),
                            rs.getInt("quantity"), rs.getDouble("t.amount"), rs.getInt("shipped"));
                    orderList.add(order);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    @Override
    public List<OrderDetails> getAllOrderDetails(String userEmailId) {
        List<OrderDetails> orderList = new ArrayList<>();
        try (Connection con = DBUtil.provideConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT p.pid AS prodid, o.orderid AS orderid, o.shipped AS shipped, p.image AS image, " +
                             "p.pname AS pname, o.quantity AS qty, o.amount AS amount, t.time AS time " +
                             "FROM orders o, product p, transactions t " +
                             "WHERE o.orderid = t.transid AND p.pid = o.prodid AND t.username = ?")) {

            ps.setString(1, userEmailId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetails order = new OrderDetails();
                    order.setOrderId(rs.getString("orderid"));
                    order.setProdImage(rs.getAsciiStream("image"));
                    order.setProdName(rs.getString("pname"));
                    order.setQty(rs.getString("qty"));
                    order.setAmount(rs.getString("amount"));
                    order.setTime(rs.getTimestamp("time"));
                    order.setProductId(rs.getString("prodid"));
                    order.setShipped(rs.getInt("shipped"));
                    orderList.add(order);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    @Override
    public String shipNow(String orderId, String prodId) {
        String status = "FAILURE";
        try (Connection con = DBUtil.provideConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE orders SET shipped = 1 WHERE orderid = ? AND prodid = ? AND shipped = 0")) {

            ps.setString(1, orderId);
            ps.setString(2, prodId);
            int k = ps.executeUpdate();
            if (k > 0) {
                status = "Order Has been shipped successfully!!";
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }
}
