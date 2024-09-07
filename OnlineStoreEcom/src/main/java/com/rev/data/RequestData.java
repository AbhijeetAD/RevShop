package com.rev.data;

import java.io.Serializable;

@SuppressWarnings("serial")
public class RequestData implements Serializable {

	private String userName;
	private String prodId;
	private int demandQty;

	public RequestData() {
		super();
	}

	public RequestData(String userName, String prodId, int demandQty) {
		super();
		this.userName = userName;
		this.prodId = prodId;
		this.demandQty = demandQty;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public int getDemandQty() {
		return demandQty;
	}

	public void setDemandQty(int demandQty) {
		this.demandQty = demandQty;
	}

}

