package com.wht.pojo.AllUsers;

import java.util.Date;

public class Manager {
    private String memberID;
    private String avatar; // 头像图片的路径
    private String password;
    private String name;
    private String mobilephone;
    private String telephone;
    private String email;
    private String qqNumber;
    private String address;
    private Date joinDate;
    private String remark;

    public Manager() {
    }

    public Manager(String memberID, String avatar, String password, String name, String mobilephone, String telephone, String email, String qqNumber, String address, Date joinDate, String remark) {
        this.memberID = memberID;
        this.avatar = avatar;
        this.password = password;
        this.name = name;
        this.mobilephone = mobilephone;
        this.telephone = telephone;
        this.email = email;
        this.qqNumber = qqNumber;
        this.address = address;
        this.joinDate = joinDate;
        this.remark = remark;
    }

    public String getMemberID() {
        return memberID;
    }

    public void setMemberID(String memberID) {
        this.memberID = memberID;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
