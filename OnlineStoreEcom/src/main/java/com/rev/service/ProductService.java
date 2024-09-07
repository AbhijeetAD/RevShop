package com.rev.service;

import java.io.InputStream;
import java.util.List;

import com.rev.data.ProductData;



public interface ProductService {

	public String addProduct(String prodName, String prodType, String prodInfo, double prodPrice, int prodQuantity,
			InputStream prodImage);

	public String addProduct(ProductData product);

	public String removeProduct(String prodId);

	public String updateProduct(ProductData prevProduct, ProductData updatedProduct);

	public String updateProductPrice(String prodId, double updatedPrice);

	public List<ProductData> getAllProducts();

	public List<ProductData> getAllProductsByType(String type);

	public List<ProductData> searchAllProducts(String search);

	public byte[] getImage(String prodId);

	public ProductData getProductDetails(String prodId);

	public String updateProductWithoutImage(String prevProductId, ProductData updatedProduct);

	public double getProductPrice(String prodId);

	public boolean sellNProduct(String prodId, int n);

	public int getProductQuantity(String prodId);
}
