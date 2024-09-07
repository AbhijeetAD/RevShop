package com.rev.service;

import java.util.List;

import com.rev.data.OrderData;
import com.rev.data.OrderDetails;
import com.rev.data.TransactionData;


public interface OrderService {

	public String paymentSuccess(String userName, double paidAmount);

	public boolean addOrder(OrderData order);

	public boolean addTransaction(TransactionData transaction);

	public int countSoldItem(String prodId);

	public List<OrderData> getAllOrders();

	public List<OrderData> getOrdersByUserId(String emailId);

	public List<OrderDetails> getAllOrderDetails(String userEmailId);

	public String shipNow(String orderId, String prodId);
}
