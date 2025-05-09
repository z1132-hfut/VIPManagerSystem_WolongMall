package com.wht.service;

import com.wht.pojo.AllUsers.VIP;
import com.wht.dao.SqlHelper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// 此类用于实现管理员相关功能：管理员登录、会员查看、会员删除/冻结

public class VIPService {

    //判断管理员是否存在：
    public boolean existManager(String Mname, String Mpassword) {
        String sql = "SELECT 1 FROM manager WHERE name = ? AND password = ?";
        String[] parameters = {Mname, Mpassword};
        try (ResultSet rs = SqlHelper.executeQuery(sql, parameters)) {
            return rs.next(); // 如果有结果返回true，否则false
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }
    }

    //查看所有VIP
    public ArrayList<VIP> GetAllVIPs()
    {
        ArrayList<VIP> vl=new ArrayList<VIP>();
        String sql="select * from vip";
        String[] parameters ={};
        ResultSet rs=SqlHelper.executeQuery(sql, parameters);
        try {
            while(rs.next())
            {
                VIP vip=new VIP();
                vip.setID(rs.getString(1));
                vip.setPassword(rs.getString(2));
                vip.setName(rs.getString(3));
                vip.setUserID(rs.getString(4));
                vip.setMobilephone(rs.getString(5));
                vip.setTelephone(rs.getString(6));
                vip.setEmail(rs.getString(7));
                vip.setQqNumber(rs.getString(8));
                vip.setZipCode(rs.getString(9));
                vip.setAddress(rs.getString(10));
                vip.setOccupation(rs.getString(11));
                vip.setIncome(rs.getString(12));
                vip.setRankMember(rs.getString(13));
                vip.setCurrentScore(rs.getInt(14));
                vip.setBalanceEAccount(rs.getDouble(15));
                vip.setJoinDate(rs.getDate(16));
                vip.setFreezed(rs.getBoolean(17));
                vip.setRemark(rs.getString(18));
                vl.add(vip);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{

            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
        }

        return vl;
    }

    //删除vip
    public void delVip(String[] memberIds){
        //将数据转移到deletevip表中
        for(String memberId:memberIds){
            String sqlFind="select * from vip where MemberID=?";
            ResultSet rs=SqlHelper.executeQuery(sqlFind, new String[]{memberId});
            try {
                while(rs.next())
                {
                    VIP vip=new VIP();
                    vip.setID(rs.getString(1));
                    vip.setPassword(rs.getString(2));
                    vip.setName(rs.getString(3));
                    vip.setUserID(rs.getString(4));
                    vip.setMobilephone(rs.getString(5));
                    vip.setTelephone(rs.getString(6));
                    vip.setEmail(rs.getString(7));
                    vip.setQqNumber(rs.getString(8));
                    vip.setZipCode(rs.getString(9));
                    vip.setAddress(rs.getString(10));
                    vip.setOccupation(rs.getString(11));
                    vip.setIncome(rs.getString(12));
                    vip.setRankMember(rs.getString(13));
                    vip.setCurrentScore(rs.getInt(14));
                    vip.setBalanceEAccount(rs.getDouble(15));
                    vip.setJoinDate(rs.getDate(16));
                    vip.setFreezed(rs.getBoolean(17));
                    vip.setRemark(rs.getString(18));

                    //在deletevip表中添加数据
                    String sqlAdd = "INSERT INTO deleteVip (MemberID, Password, Name, UserID, Mobilephone,Telephone, "+
                            "EMail, QQNumber, ZipCode, Address, Occupation, Income, RankMember, CurrentScore, " +
                            "BalanceEAccount, JoinDate, IsFreezed, Remark) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    String[] params1 = {
                            memberId, vip.getPassword(), vip.getName(), vip.getUserID(), vip.getMobilephone(),
                            vip.getTelephone(), vip.getEmail(), vip.getQqNumber(), vip.getZipCode(), vip.getAddress(),
                            vip.getOccupation(), vip.getIncome(), vip.getRankMember(),
                            String.valueOf(vip.getCurrentScore()), String.valueOf(vip.getBalanceEAccount()),
                            String.valueOf(vip.getJoinDate()),
                            vip.isFreezed() ? "1" : "0", vip.getRemark()
                    };
                    SqlHelper.executeUpdate(sqlAdd, params1);

                    //删除原数据
                    String sqlDel1 = "DELETE FROM vip WHERE MemberID = ?";
                    SqlHelper.executeDelUpdate(sqlDel1, memberId);

                    //更新alluser表中的记录（会员被撤销）.UserID是主键，不能多个为空
                    String updateSql = "UPDATE alluser SET MemberID=?, Password=?, Name=?, UserID=?, " +
                            "Mobilephone=?, Telephone=?, EMail=?, " +
                            "QQNumber=?, ZipCode=?, Address=?, Occupation=?, Income=?, " +
                            "RankMember=?, CurrentScore=?, BalanceEAccount=?, JoinDate=?, " +
                            "IsFreezed=?, Remark=? WHERE MemberID=?";
                    String[] params2 = {
                            memberId, vip.getPassword(), "", vip.getUserID(), vip.getMobilephone(),
                            "", "", "", "", "",
                            "", "暂无", "暂无",
                            "0", "0.00",
                            String.valueOf(vip.getJoinDate()),
                            "0", "",memberId
                    };
                    SqlHelper.executeUpdate(updateSql, params2);

                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }finally{
                SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), SqlHelper.getRs());
            }
        }

    }

    //冻结/解冻vip
    public void freezeVIP(String memberId){
        String sql = "SELECT IsFreezed FROM vip where MemberID = ?";
        String updateSql1 = "UPDATE AllUser SET IsFreezed=? WHERE MemberID=?";
        String updateSql2 = "UPDATE vip SET IsFreezed=? WHERE MemberID=?";
        ResultSet rs = null;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{memberId});
            // 处理结果集
            if (rs != null && rs.next()) {
                boolean value = !rs.getBoolean("IsFreezed");
                SqlHelper.executeUpdateBoolean(updateSql1, value, memberId);
                SqlHelper.executeUpdateBoolean(updateSql2, value, memberId);
            }
        } catch (Exception e) {
            throw new RuntimeException("获取冻结信息失败: " + e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }

    }

    //给vip添加备注
    public void addRemark(String memberId,String remark){
        String sql = "SELECT Remark FROM vip where MemberID = ?";
        String updateSql1 = "UPDATE AllUser SET Remark=? WHERE MemberID=?";
        String updateSql2 = "UPDATE vip SET Remark=? WHERE MemberID=?";
        ResultSet rs = null;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{memberId});
            // 处理结果集
            if (rs != null && rs.next()) {
                String value = rs.getString("Remark");
                SqlHelper.executeUpdateRemark(updateSql1, remark, memberId);
                SqlHelper.executeUpdateRemark(updateSql2, remark, memberId);
            }
        } catch (Exception e) {
            throw new RuntimeException("获取冻结信息失败: " + e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }

    }

    //撤回删除操作（）
    public ArrayList<String> undoDeleteVIP(String[] memberIds) {
        //列表为空：全部撤回成功。不为空：有用户已重新成为vip，撤回失败，原数据删除，其他用户撤回成功。
        ArrayList<String> res = new ArrayList<>();
        try {
            for (String memberId : memberIds) {
                //检查该会员是否已经是VIP：
                String checkSql = "SELECT MemberID FROM vip WHERE MemberID = ?";
                ResultSet checkRs = SqlHelper.executeQuery(checkSql, new String[]{memberId});
                if (checkRs != null && checkRs.next()) {
                    //向列表中添加已成为vip的用户的用户名
                    res.add(checkRs.getString("MemberID"));
                }else{
                    //执行数据转移操作
                    //从deletevip表获取被删除的VIP信息：
                    String selectSql = "SELECT * FROM deletevip WHERE MemberID = ?";
                    ResultSet rs = SqlHelper.executeQuery(selectSql, new String[]{memberId});

                    if (rs != null && rs.next()) {
                        //存储数据
                        /*VIP vip=new VIP();
                        vip.setID(rs.getString(1));
                        vip.setPassword(rs.getString(2));
                        vip.setName(rs.getString(3));
                        vip.setUserID(rs.getString(4));
                        vip.setMobilephone(rs.getString(5));
                        vip.setTelephone(rs.getString(6));
                        vip.setEmail(rs.getString(7));
                        vip.setQqNumber(rs.getString(8));
                        vip.setZipCode(rs.getString(9));
                        vip.setAddress(rs.getString(10));
                        vip.setOccupation(rs.getString(11));
                        vip.setIncome(rs.getString(12));
                        vip.setRankMember(rs.getString(13));
                        vip.setCurrentScore(rs.getInt(14));
                        vip.setBalanceEAccount(rs.getDouble(15));
                        vip.setJoinDate(rs.getDate(16));
                        vip.setFreezed(rs.getBoolean(17));
                        vip.setRemark(rs.getString(18));
                        String[] vipParams={vip.getID(),vip.getPassword(), vip.getName(), vip.getUserID(),
                                vip.getMobilephone(),vip.getTelephone(), vip.getEmail(), vip.getQqNumber(),
                                vip.getZipCode(), vip.getAddress(),vip.getOccupation(), vip.getIncome(),
                                vip.getRankMember(),String.valueOf(vip.getCurrentScore()),
                                String.valueOf(vip.getBalanceEAccount()),
                                String.valueOf(vip.getJoinDate()),
                                vip.isFreezed() ? "1" : "0", vip.getRemark()};*/
                        String[] vipParams = new String[]{
                                rs.getString("MemberID"),
                                rs.getString("Password"),
                                rs.getString("Name"),
                                rs.getString("UserID"),
                                rs.getString("Mobilephone"),
                                rs.getString("Telephone"),
                                rs.getString("EMail"),
                                rs.getString("QQNumber"),
                                rs.getString("ZipCode"),
                                rs.getString("Address"),
                                rs.getString("Occupation"),
                                rs.getString("Income"),
                                rs.getString("RankMember"),
                                String.valueOf(rs.getInt("CurrentScore")),
                                String.valueOf(rs.getDouble("BalanceEAccount")),
                                rs.getDate("JoinDate").toString(),
                                rs.getBoolean("IsFreezed") ? "1" : "0",
                                rs.getString("Remark")
                        };

                        //将数据重新插入到vip表
                        String insertSql = "INSERT INTO vip (MemberID, Password, Name, UserID, Mobilephone, " +
                                "Telephone, EMail, QQNumber, ZipCode, Address, Occupation, Income, " +
                                "RankMember, CurrentScore, BalanceEAccount, JoinDate, IsFreezed, Remark) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        SqlHelper.executeUpdate(insertSql, vipParams);

                        //更新alluser表中的信息
                        String updateSql = "UPDATE alluser SET Password = ?, Name = ?, UserID = ?, " +
                                "Mobilephone = ?, Telephone = ?, EMail = ?, QQNumber = ?, ZipCode = ?, " +
                                "Address = ?, Occupation = ?, Income = ?, RankMember = ?, CurrentScore = ?, " +
                                "BalanceEAccount = ?, JoinDate = ?, IsFreezed = ?, Remark = ? " +
                                "WHERE MemberID = ?";
                        String[] updateParams = new String[vipParams.length];
                        System.arraycopy(vipParams, 1, updateParams, 0, vipParams.length - 1);
                        updateParams[updateParams.length - 1] = memberId;
                        SqlHelper.executeUpdate(updateSql, updateParams);
                    }
                }
                //删除deletevip表中对应的数据
                String delSql = "DELETE FROM deletevip WHERE MemberID = ?";
                SqlHelper.executeDelUpdate(delSql, memberId);

            }

            return res;

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("撤回删除操作失败: " + e.getMessage());
        }
    }

    //撤回添加备注
    public void undoAddRemark(String memberId,String remark){  //传递的是原备注
        String sql = "SELECT Remark FROM vip where MemberID = ?";
        String updateSql1 = "UPDATE AllUser SET Remark=? WHERE MemberID=?";
        String updateSql2 = "UPDATE vip SET Remark=? WHERE MemberID=?";
        ResultSet rs = null;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{memberId});
            // 处理结果集
            if (rs != null && rs.next()) {
                String value = rs.getString("Remark");
                SqlHelper.executeUpdateRemark(updateSql1, remark, memberId);
                SqlHelper.executeUpdateRemark(updateSql2, remark, memberId);
            }
        } catch (Exception e) {
            throw new RuntimeException("获取冻结信息失败: " + e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }

    }

    //撤回冻结/解冻vip
    public int undoFreezeVIP(String memberId,boolean ns){
        //0：成功。1：失败
        String sql = "SELECT IsFreezed FROM vip where MemberID = ?";
        String updateSql1 = "UPDATE AllUser SET IsFreezed=? WHERE MemberID=?";
        String updateSql2 = "UPDATE vip SET IsFreezed=? WHERE MemberID=?";
        ResultSet rs = null;
        try {
            // 执行查询
            rs = SqlHelper.executeQuery(sql, new String[]{memberId});
            // 处理结果集
            if (rs != null && rs.next()) {
                boolean value = !rs.getBoolean("IsFreezed");
                if(value!=ns){
                    SqlHelper.executeUpdateBoolean(updateSql1, value, memberId);
                    SqlHelper.executeUpdateBoolean(updateSql2, value, memberId);
                    return 0;
                }
                return 1;
            }
        } catch (Exception e) {
            throw new RuntimeException("获取冻结信息失败: " + e.getMessage());
        } finally {
            // 关闭资源
            SqlHelper.close(SqlHelper.getCt(), SqlHelper.getPs(), rs);
        }
        return 1;
    }
}
