package com.wht.pojo.AllUsers;

import java.util.Date;

public class VIP extends User{
//    private String ID;  //MemberID
//    private String password;
//    private String name;

    private String avatar; // 头像图片的路径
    private String userID;
    private String mobilephone;
    private String telephone;
    private String email;
    private String qqNumber;
    private String zipCode;
    private String address;
    private String occupation;
    private String income;
    private String rankMember;
    private int currentScore;
    private double balanceEAccount;
    private Date joinDate;
    private boolean isFreezed;
    private String remark;

    public VIP() {
        super();
    }

    public VIP(String ID, String password, String name, String userID, String mobilephone,
               String telephone, String email, String qqNumber, String zipCode, String address,
               String occupation, String income, String rankMember, int currentScore, double balanceEAccount,
               Date joinDate, boolean isFreezed, String remark, String avatar) {
        super(ID, password, name);
        this.ID = ID;
        this.password = password;
        this.name = name;
        this.userID = userID;
        this.mobilephone = mobilephone;
        this.telephone = telephone;
        this.email = email;
        this.qqNumber = qqNumber;
        this.zipCode = zipCode;
        this.address = address;
        this.occupation = occupation;
        this.income = income;
        this.rankMember = rankMember;
        this.currentScore = currentScore;
        this.balanceEAccount = balanceEAccount;
        this.joinDate = joinDate;
        this.isFreezed = isFreezed;
        this.remark = remark;
        this.avatar = avatar;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getMobilephone() {
        return mobilephone;
    }

    public void setMobilephone(String mobilephone) {
        this.mobilephone = mobilephone;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getQqNumber() {
        return qqNumber;
    }

    public void setQqNumber(String qqNumber) {
        this.qqNumber = qqNumber;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getIncome() {
        return income;
    }

    public void setIncome(String income) {
        this.income = income;
    }

    public String getRankMember() {
        return rankMember;
    }

    public void setRankMember(String rankMember) {
        this.rankMember = rankMember;
    }

    public int getCurrentScore() {
        return currentScore;
    }

    public void setCurrentScore(int currentScore) {
        this.currentScore = currentScore;
    }

    public double getBalanceEAccount() {
        return balanceEAccount;
    }

    public void setBalanceEAccount(double balanceEAccount) {
        this.balanceEAccount = balanceEAccount;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public boolean isFreezed() {
        return isFreezed;
    }

    public void setFreezed(boolean freezed) {
        isFreezed = freezed;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}