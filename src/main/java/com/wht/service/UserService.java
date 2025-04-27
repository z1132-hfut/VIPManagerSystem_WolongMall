package com.wht.service;


// 此类用于实现用户相关功能：用户登录、用户注册、会员等级获取、成为会员

import com.wht.dao.SqlHelper;
import com.wht.pojo.AllUsers.VIP;
import com.wht.util.BCryptTool;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class UserService {

    //用户登录    //0：用户不存在，1：密码错误，2：普通用户登入，3：会员用户登入
    public int ULogin(String memberId, String password) {
        //根据MemberID判断用户是否存在
        String sql  = "select Password,RankMember from AllUser where MemberID=?";
        ResultSet rs = null;
        String pw;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{memberId});
            // 处理结果集
            if (rs != null && rs.next()) {
                //判断密码是否正确
                pw = rs.getString("Password");
                String rm=rs.getString("RankMember");
                if (BCryptTool.checkPassword(password, pw)) {
                    //rankMember等于"暂无"：普通用户；rankMember不等于"暂无"：会员用户
                    return rm.equals("暂无")?2:3;
                } else {
                    //密码错误
                    return 1;
                }
            }
            //用户不存在
            return 0;
        } catch (Exception e) {
            throw new RuntimeException("获取密码失败: " + e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }

    }

    //用户注册：
    public int URegister(String username, String password, String phone) {
        //判断name是否已存在
        String checkNameSql = "SELECT 1 FROM alluser WHERE MemberID = ?";
        String countUserSql = "SELECT COUNT(*) FROM alluser"; // 查询当前用户总数
        String insertSql = "INSERT INTO alluser (UserID, Password, MemberID, Mobilephone) VALUES (?, ?, ?, ?)";

        try {
            //检查用户名是否已存在
            try (ResultSet rs = SqlHelper.executeQuery(checkNameSql, new String[]{username})) {
                if (rs.next()) {
                    return 1; // name重复
                }
            }

            //获取当前用户总数并生成新用户ID
            int userCount = 0;
            try (ResultSet rs = SqlHelper.executeQuery(countUserSql, null)) {
                if (rs.next()) {
                    userCount = rs.getInt(1);
                }
            }
            String userId = "U"+(userCount + 1);

            //插入新用户（传入的是加密后的密码）
            String[] params = {userId, password, username, phone};
            SqlHelper.executeUpdate(insertSql, params);

            return 0; // 注册成功
        } catch (SQLException e) {
            throw new RuntimeException("注册失败: " + e.getMessage());
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
    }

    //重新设置密码：
    public int setPassword(String username, String phone,String password) {
        //1：用户名不存在，2：手机号与用户名不匹配，0：设置成功
        //根据name判断用户是否存在
        String sql  = "select Mobilephone from AllUser where MemberID=?";
        ResultSet rs = null;
        String ph;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{username});
            // 处理结果集
            if (rs != null && rs.next()) {
                //判断手机号是否匹配
                ph = rs.getString("Mobilephone");
                if (ph.equals(phone)) {
                    //修改密码
                    String updateSql = "UPDATE AllUser SET Password=? WHERE MemberID=?";
                    SqlHelper.executeUpdate(updateSql, new String[]{password, username});
                    String updateSql2 = "UPDATE vip SET Password=? WHERE MemberID=?";
                    SqlHelper.executeUpdate(updateSql2, new String[]{password, username});
                    return 0;
                } else {
                    //手机号错误
                    return 2;
                }
            }
            //用户不存在
            return 1;
        } catch (Exception e) {
            throw new RuntimeException("获取密码失败: " + e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }

    }

    //购买VIP：
    public int addVip(String memberId, String name, String userId, String telphone, String email, String qq,
                      String zcode, String address, String occupation, String income, String vipLevel,
                      int currentScore, double balanceEAccount, String formattedDate, boolean isFreezed, String remark) {
        //1：用户名memberId不存在，2：用户名对应的vipLevel级别更高，3：身份证号重复，4：身份证号错误，5：会员购买成功
        String sql = "select Password,Mobilephone,RankMember,UserID,JoinDate from alluser where MemberID=?";
        String uidSql_vip = "SELECT 1 FROM vip WHERE UserID = ?";
        //String uidSql_delVip = "SELECT * FROM deletevip WHERE UserID = ?";
        //String uidSql2 = "SELECT * FROM alluser WHERE UserID = ?";

        ResultSet rs = null;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{memberId});
            // 处理结果集
            if (rs != null && rs.next()) {
                String pw = rs.getString("Password");
                String ph = rs.getString("Mobilephone");
                String uid = rs.getString("UserID");
                Date olddate = rs.getDate("JoinDate");
                //判断当前会员等级
                String nowVipLevel = rs.getString("RankMember");
                HashMap<String, Integer> VIPLevel = new HashMap<>();
                VIPLevel.put("暂无", 0);
                VIPLevel.put("铜冠", 1);
                VIPLevel.put("银冠", 2);
                VIPLevel.put("金冠", 3);
                VIPLevel.put("钻石冠", 4);
                VIPLevel.put("至尊冠", 5);

                if (nowVipLevel.equals("暂无")) {  //非会员用户
                    //判断身份证号是否已存在：
                    try (ResultSet rs2 = SqlHelper.executeQuery(uidSql_vip, new String[]{userId})) {
                        if (rs2.next()) {
                            return 3;  //和已存在会员的身份证号重复
                        }
                    }
                    /*try (ResultSet rs3 = SqlHelper.executeQuery(uidSql_delVip, new String[]{userId})) {
                        if (rs3.next() && !rs3.getString("MemberID").equals(memberId)) {
                            return 3;  //
                        }
                    }*/
                    //在vip表中插入新记录
                    String insertSql = "INSERT INTO vip (MemberID, Password, Name, UserID, Mobilephone,Telephone, " +
                            "EMail, QQNumber, ZipCode, Address, Occupation, Income, RankMember, CurrentScore, " +
                            "BalanceEAccount, JoinDate, IsFreezed, Remark) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    String[] params1 = {
                            memberId, pw, name, userId, ph, telphone, email, qq, zcode, address,
                            occupation, income, vipLevel, String.valueOf(currentScore),
                            String.valueOf(balanceEAccount), formattedDate,
                            isFreezed ? "1" : "0", remark
                    };
                    SqlHelper.executeUpdate(insertSql, params1);

                    //更新alluser表中的记录
                    String updateSql = "UPDATE alluser SET Name=?, UserID=?, Telephone=?, EMail=?, " +
                            "QQNumber=?, ZipCode=?, Address=?, Occupation=?, Income=?, " +
                            "RankMember=?, CurrentScore=?, BalanceEAccount=?, JoinDate=?, " +
                            "IsFreezed=?, Remark=? WHERE MemberID=?";
                    String[] params2 = {
                            name, userId, telphone, email, qq, zcode, address, occupation,
                            income, vipLevel, String.valueOf(currentScore),
                            String.valueOf(balanceEAccount), formattedDate,
                            isFreezed ? "1" : "0", remark, memberId
                    };
                    SqlHelper.executeUpdate(updateSql, params2);

                    return 5;
                } else if (VIPLevel.get(nowVipLevel) >= VIPLevel.get(vipLevel)) {  //更高级别会员
                    return 2;
                } else if(!uid.equals(userId)){  //新输入的身份证号不等于原有的身份证号
                    return 4;
                }else{ //会员购买成功
                    //更新vip表中的记录
                    String updateSql = "UPDATE vip SET Name=?, UserID=?, Telephone=?, EMail=?, " +
                            "QQNumber=?, ZipCode=?, Address=?, Occupation=?, Income=?, " +
                            "RankMember=?, CurrentScore=?, BalanceEAccount=?, JoinDate=?, " +
                            "IsFreezed=?, Remark=? WHERE MemberID=?";
                    String[] params = {
                            name, userId, telphone, email, qq, zcode, address, occupation,
                            income, vipLevel, String.valueOf(currentScore),
                            String.valueOf(balanceEAccount), String.valueOf(olddate),
                            isFreezed ? "1" : "0", remark, memberId
                    };
                    SqlHelper.executeUpdate(updateSql, params);

                    //更新alluser表中的记录
                    String updateSqlalluser = "UPDATE alluser SET Name=?, UserID=?, Telephone=?, EMail=?, " +
                            "QQNumber=?, ZipCode=?, Address=?, Occupation=?, Income=?, " +
                            "RankMember=?, CurrentScore=?, BalanceEAccount=?, JoinDate=?, " +
                            "IsFreezed=?, Remark=? WHERE MemberID=?";
                    String[] paramsalluser = {
                            name, userId, telphone, email, qq, zcode, address, occupation,
                            income, vipLevel, String.valueOf(currentScore),
                            String.valueOf(balanceEAccount), String.valueOf(olddate),
                            isFreezed ? "1" : "0", remark, memberId
                    };
                    SqlHelper.executeUpdate(updateSqlalluser, paramsalluser);

                    return 5;
                }
            }
            //用户不存在
            return 1;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }
    }

    //vip-获取会员信息
    public VIP getVIP(String memberId) {
        VIP vip = new VIP();
        String sql = "SELECT Password, Name, UserID, Mobilephone,Telephone,EMail, QQNumber, ZipCode, Address, " +
                "Occupation, Income, RankMember, CurrentScore, BalanceEAccount, JoinDate, IsFreezed " +
                "FROM vip where MemberID=?";
        ResultSet rs = null;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{memberId});
            // 处理结果集
            if (rs != null && rs.next()) {
                vip.setID(memberId);
                vip.setPassword(rs.getString("Password"));
                vip.setName(rs.getString("Name"));
                vip.setUserID(rs.getString("UserID"));
                vip.setMobilephone(rs.getString("Mobilephone"));
                vip.setTelephone(rs.getString("Telephone"));
                vip.setEmail(rs.getString("EMail"));
                vip.setQqNumber(rs.getString("QQNumber"));
                vip.setZipCode(rs.getString("ZipCode"));
                vip.setAddress(rs.getString("Address"));
                vip.setOccupation(rs.getString("Occupation"));
                vip.setIncome(rs.getString("Income"));
                vip.setRankMember(rs.getString("RankMember"));
                vip.setCurrentScore(rs.getInt("CurrentScore"));
                vip.setBalanceEAccount(rs.getDouble("BalanceEAccount"));
                vip.setJoinDate(rs.getDate("JoinDate"));
                vip.setFreezed(rs.getBoolean("IsFreezed"));
            }
        } catch (Exception e) {
            throw new RuntimeException("获取用户信息失败: " + e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }

        return vip;
    }

    //vip-修改个人信息
    public int changeInfo(String oldmemberId,String olduserId,String memberId, String name, String userId,
                          String mobilephone,String telphone, String email, String qq, String zcode, String address,
                          String occupation,String income){
        //0：修改成功，1：用户名重复，2：身份证号重复
        String checkNameSql = "SELECT * FROM alluser where MemberID = ?";
        String checkUserIDSql = "SELECT * FROM alluser where UserID = ?";

        try {
            if(!oldmemberId.equals(memberId)){
                //检查新用户名是否已存在
                try (ResultSet rs = SqlHelper.executeQuery(checkNameSql, new String[]{memberId})) {
                    if (rs.next()) {
                        return 1; // memberId重复
                    }
                }
            }

            if(!olduserId.equals(userId)){
                //检查新身份证号是否已存在
                try (ResultSet rs = SqlHelper.executeQuery(checkUserIDSql, new String[]{userId})) {
                    if (rs.next()) {
                        return 2; // userId重复
                    }
                }
            }

            //更新vip表中的记录
            String updateSql = "UPDATE vip SET MemberID=?, Name=?, UserID=?, Mobilephone=?, Telephone=?, EMail=?, "+
                    "QQNumber=?, ZipCode=?, Address=?, Occupation=?, Income=? WHERE MemberID=?";
            String[] params = {
                    memberId, name, userId, mobilephone, telphone, email, qq, zcode, address, occupation, income,
                    oldmemberId
            };
            SqlHelper.executeUpdate(updateSql, params);

            //更新alluser表中的记录
            String updateSqlalluser = "UPDATE alluser SET MemberID=?, Name=?, UserID=?, Mobilephone=?, Telephone=?, EMail=?, "+
                    "QQNumber=?, ZipCode=?, Address=?, Occupation=?, Income=? WHERE MemberID=?";
            String[] paramsalluser = {
                    memberId, name, userId, mobilephone, telphone, email, qq, zcode, address, occupation, income,
                    oldmemberId
            };
            SqlHelper.executeUpdate(updateSqlalluser, paramsalluser);


            return 0; // 修改成功
        } catch (SQLException e) {
            throw new RuntimeException("注册失败: " + e.getMessage());
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }


    }

    //vip-电子账号余额充值
    public double recharge(String memberId,double amount){
        //0：充值成功，x：充值金额过大，可充值余额x
        String sql = "SELECT BalanceEAccount FROM alluser where MemberID = ?";
        String updateSql1 = "UPDATE AllUser SET BalanceEAccount=? WHERE MemberID=?";
        String updateSql2 = "UPDATE vip SET BalanceEAccount=? WHERE MemberID=?";
        ResultSet rs = null;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{memberId});
            // 处理结果集
            if (rs != null && rs.next()) {
                double money = rs.getDouble("BalanceEAccount");
                if(money+amount>999.99){
                    return 999.99-money;
                }else{
                    SqlHelper.executeUpdateDouble(updateSql1, money+amount,memberId);
                    SqlHelper.executeUpdateDouble(updateSql2, money+amount,memberId);
                    return 0;
                }
            }
            //用户不存在
            return 0;
        } catch (Exception e) {
            throw new RuntimeException("获取密码失败: " + e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }
    }

    //vip-排行榜





























}
