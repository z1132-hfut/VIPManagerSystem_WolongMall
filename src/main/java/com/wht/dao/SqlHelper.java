package com.wht.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class SqlHelper {
    private static Connection ct=null;
    private static PreparedStatement ps=null;
    private static ResultSet rs=null;

    private static String driver="";
    private static String url="";
    private static String username="";
    private static String password="";

    private static Properties pp=null;
    private static InputStream fis=null;

    public static Connection getCt() {
        return ct;
    }
    public static PreparedStatement getPs() {
        return ps;
    }
    public static ResultSet getRs() {
        return rs;
    }

    //加载驱动，只需一次，所以放在静态块中。
    static{
        try {
            //javaweb项目读取文件要用类加载器
            pp=new Properties();
            fis=SqlHelper.class.getClassLoader().getResourceAsStream("dbinfo.properties");
            pp.load(fis);
            driver=pp.getProperty("driver");
            url=pp.getProperty("url");
            username=pp.getProperty("username");
            password=pp.getProperty("password");
            Class.forName(driver);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }finally
        {
            if(fis!=null)
            {
                try {
                    fis.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }

            fis=null;
        }
    }
    //得到链接
    public static Connection getConnection()
    {
        try {
            ct= DriverManager.getConnection(url,username,password);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return ct;
    }
    //关闭资源函数
    public static void close(Connection ct,PreparedStatement ps,ResultSet rs)
    {
        try {
            //为了程序健壮、
            if(rs!=null)
            {
                rs.close();
            }
            rs=null;
            if(ps!=null)
            {
                ps.close();
            }
            ps=null;
            if(ct!=null)
            {
                ct.close();
            }
            ct=null;

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    //Update函数(单条update/insert语句)
    public static void executeUpdate(String sql,String[] parameters)
    {

        try {
            ct=getConnection();
            ps=ct.prepareStatement(sql);
            if(parameters!=null)
            {
                for(int i=0;i<parameters.length;i++)
                {
                    ps.setObject(i+1, parameters[i]);//.setString(i+1, parameters[i]);
                }
            }
            //执行
            ps.executeUpdate();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally{
            close(ct,ps,rs);
        }
    }

    //Update函数(余额修改)
    public static void executeUpdateDouble(String sql,double money, String memberId)
    {
        try {
            ct = getConnection();
            ps = ct.prepareStatement(sql);
            ps.setDouble(1, money);      // 设置金额参数
            ps.setString(2, memberId);   // 设置会员ID参数
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("数据库更新失败: " + e.getMessage());
        } finally {
            close(ct, ps, rs);
        }
    }

    //Update函数(冻结/解冻)
    public static void executeUpdateBoolean(String sql,boolean value, String memberId)
    {
        try {
            ct = getConnection();
            ps = ct.prepareStatement(sql);
            ps.setBoolean(1, value);
            ps.setString(2, memberId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("数据库更新失败: " + e.getMessage());
        } finally {
            close(ct, ps, rs);
        }
    }

    //Update函数(备注)
    public static void executeUpdateRemark(String sql,String value, String memberId)
    {
        try {
            ct = getConnection();
            ps = ct.prepareStatement(sql);
            ps.setString(1, value);
            ps.setString(2, memberId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("数据库更新失败: " + e.getMessage());
        } finally {
            close(ct, ps, rs);
        }
    }

    //Update函数(多条delete/update/insert语句)事务处理（回滚）
    /*public static void executeUpdate2(String []sql,String [][]parameters)
    {
        try {
            ct=getConnection();
            ct.setAutoCommit(false);
            if(sql!=null)
            {
                for(int i=0;i<sql.length;i++)
                {
                    ps=ct.prepareStatement(sql[i]);
                    if(parameters[i]!=null)
                    {
                        for(int j=0;j<parameters[i].length;j++)
                        {
                            ps.setObject(j+1, parameters[i][j]);
                        }
                        ps.executeUpdate();
                    }
                }
            }
            ct.commit();
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            //回滚
            try {
                ct.rollback();
            } catch (SQLException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            throw new RuntimeException(e.getMessage());
        }finally{

            close(ct,ps,rs);
        }
    }*/

    //用于查询
    public static ResultSet executeQuery(String sql, String[] parameters) {
        try {
            ct = getConnection();
            ps = ct.prepareStatement(sql);
            if (parameters != null && !parameters.equals("")) {
                for (int i = 0; i < parameters.length; i++) {
                    ps.setObject(i + 1, parameters[i]);
                }
            }
            rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            // 不要在这里关闭资源，由调用方负责关闭
        }
    }

    //删除单条记录：
    public static void executeDelUpdate(String sql, String parameter) {
        try {
            ct = getConnection();
            ps = ct.prepareStatement(sql);
            if (parameter != null) {
                ps.setString(1, parameter);
                ps.addBatch();
                ps.executeBatch();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            close(ct, ps, rs);
        }
    }


    // 批量更新方法（用于批量删除）
    /*public static void executeBatchUpdate(String sql, String[] parameters) {
        try {
            ct = getConnection();
            ps = ct.prepareStatement(sql);
            if (parameters != null) {
                for (String parameter : parameters) {
                    ps.setString(1, parameter);
                    ps.addBatch();
                }
                ps.executeBatch();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            close(ct, ps, rs);
        }
    }*/

    // 设置布尔值的方法（用于冻结/解冻）
    /*public static void executeUpdateBoolean(String sql, boolean value, String memberId) {
        try {
            ct = getConnection();
            ps = ct.prepareStatement(sql);
            ps.setBoolean(1, value);
            ps.setString(2, memberId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("数据库更新失败: " + e.getMessage());
        } finally {
            close(ct, ps, rs);
        }
    }*/


    //用于编号
    public static int selectWhere(String sql) {
        Connection ct = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // 1. 获取数据库连接
            ct = getConnection();
            // 2. 创建 PreparedStatement 对象
            ps = ct.prepareStatement(sql);
            // 3. 执行查询
            rs = ps.executeQuery();
            // 4. 获取 COUNT(*) 的结果
            if (rs.next()) {
                return rs.getInt(1)+1; // 返回第一列的值（COUNT(*) 的结果）
            } else {
                throw new RuntimeException("No result returned from the query.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to execute query: " + e.getMessage());
        } finally {
            // 5. 关闭资源
            closeResources(ct, ps, rs);
        }
    }

    // 辅助方法：关闭资源
    private static void closeResources(Connection ct, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (ct != null) ct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
