package com.wht.pojo.AllUsers;

public class User {
    public String ID;  //MemberId
    public String password;
    public String name;

    public User() {
    }

    public User(String ID, String password, String name) {
        this.ID = ID;
        this.password = password;
        this.name = name;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
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
}
