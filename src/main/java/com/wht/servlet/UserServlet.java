package com.wht.servlet;


// 此类用于实现用户相关功能：用户登录、用户注册、修改密码，成为会员，会员等级获取

import com.wht.pojo.AllUsers.VIP;
import com.wht.service.UserService;
import com.wht.util.BCryptTool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/UserServlet")
public class UserServlet  extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 添加请求编码设置
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //catalina.bat开头添加：set "JAVA_OPTS=%JAVA_OPTS% -Dfile.encoding=UTF-8"

        String type = request.getParameter("type");
        UserService us = new UserService();
        //用于获取登录的会员信息
        VIP vip = new VIP();

        //登录：
        if(type.equals("userlogin")){
            String memberId = request.getParameter("id"); // 获取用户名
            String password = request.getParameter("pw");    // 获取密码
            int res=us.ULogin(memberId,password);
            if(res==3){
                vip=us.getVIP(memberId);
                request.getSession().setAttribute("vip", vip);
                request.getSession().setAttribute("ison", type);
                response.sendRedirect(request.getContextPath() + "/jsp/UserPages/VIP_Page.jsp");
            }else if(res==2){
                response.sendRedirect(request.getContextPath() + "/jsp/UserPages/NoVIP_Page.jsp");
            }else if(res==1){
                showAlert(response, "密码错误");
            }else{
                showAlert(response, "用户名错误或用户不存在");
            }
        //注册：
        }else if(type.equals("userregister")){
            String username = request.getParameter("MemberID"); // 获取用户名
            String phone = request.getParameter("Mobilephone");    // 获取手机号
            String pw = request.getParameter("Password");    // 获取密码
            String password = BCryptTool.hashPassword(pw);   //加密密码
            int res=us.URegister(username,password,phone);
            if(res==1){
                showAlert(response, "该用户名已存在");
            }else if(res==2){
                showAlert(response, "该手机号已存在");
            }else{
                response.getWriter().println("<script type='text/javascript'> alert('注册成功，将自动登录');" +
                        "window.location.href='" + request.getContextPath() + "/jsp/UserPages/NoVIP_Page.jsp';"+
                        "</script>");
            }
        //修改密码：
        }else if(type.equals("changePassword")){
            String username = request.getParameter("MemberID"); // 获取用户名
            String phone = request.getParameter("Phone");    // 获取手机号
            String npw = request.getParameter("npw");    // 获取密码
            String password = BCryptTool.hashPassword(npw);   //加密密码
            int res=us.setPassword(username,phone,password);
            if(res==1){
                showAlert(response,"该用户名不存在");
            }else if(res==2){
                showAlert(response,"手机号与用户名不匹配");
            }else{
                response.getWriter().println("<script type='text/javascript'> alert('密码修改成功，请重新登录');" +
                        "window.location.href='" + request.getContextPath() + "/jsp/Login_Register/login.jsp';"+
                        "</script>");
            }
        //成为会员:
        }else if(type.equals("beVip")){  //会员级别，积分，账户余额，加入日期，是否冻结，备注
            String memberId = request.getParameter("memberId");
            String name = request.getParameter("name");
            String userId = request.getParameter("userID");
            String telphone = request.getParameter("telephone");
            String email = request.getParameter("email");
            String qq = request.getParameter("qqNumber");
            String zcode = request.getParameter("zipCode");
            String address = request.getParameter("address");
            String occupation = request.getParameter("occupation");
            String income = request.getParameter("income");
            String vipLevel = request.getParameter("vipLevel");
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = sdf.format(date);
            int res=us.addVip(memberId,name,userId,telphone,email,qq,zcode,address,occupation,income,vipLevel,
                    0,0.0,formattedDate,false,"");
            if(res==1){
                showAlert(response,"该用户名不存在");
            }else if(res==2){
                showAlert(response,"当前已是同级或更高级别会员。您当前的等级："
                        +us.getVIP(memberId).getRankMember());
            }else if(res==3){
                showAlert(response,"身份证号重复，请重新输入");
            }else if(res==4){
                showAlert(response,"身份证号错误，请重新输入");
            }else{
                vip=us.getVIP(memberId);
                request.getSession().setAttribute("vip", vip);
                request.getSession().setAttribute("ison", type);
                response.getWriter().println("<script type='text/javascript'> alert('会员购买成功');" +
                        "window.location.href='" + request.getContextPath() + "/jsp/UserPages/ToBeVIP.jsp';"+
                        "</script>");
            }
        //会员信息修改
        }else if(type.equals("vipChange")){
            String oldmemberId = request.getParameter("oldmemberId");
            String olduserId = request.getParameter("olduserId");
            String memberId = request.getParameter("memberId");
            String name = request.getParameter("name");
            String userId = request.getParameter("userId");
            String mobilephone = request.getParameter("mobilephone");
            String telphone = request.getParameter("telephone");
            String email = request.getParameter("email");
            String qq = request.getParameter("qq");
            String zcode = request.getParameter("zipcode");
            String address = request.getParameter("address");
            String occupation = request.getParameter("occupation");
            String income = request.getParameter("income");

            int res=us.changeInfo(oldmemberId,olduserId,memberId,name,userId,mobilephone,telphone,email,qq,zcode,
                    address,occupation, income);

            if(res==1){
                showAlert(response,"该用户名已存在");
            }else if(res==2){
                showAlert(response,"该身份证号已存在");
            }else{
                //获取更新后的完整用户数据
                VIP newVIP=us.getVIP(memberId);
                //更新页面数据
                request.getSession().setAttribute("vip", newVIP);
                //刷新
                response.getWriter().println("<script type='text/javascript'> alert('信息修改成功');" +
                        "window.location.href='" + request.getContextPath() + "/jsp/UserPages/VipCenter.jsp';"+
                        "</script>");
            }
        //余额充值
        }else if(type.equals("recharge")){
            String mid = request.getParameter("mid");
            String amountStr = request.getParameter("amount");
            double amount = Double.parseDouble(amountStr);
            double res=us.recharge(mid,amount);

            if(res==0){
                VIP newVIP=us.getVIP(mid);
                request.getSession().setAttribute("vip", newVIP);
                response.getWriter().println("<script type='text/javascript'> alert('充值成功');" +
                        "window.location.href='" + request.getContextPath() + "/jsp/UserPages/VipCenter.jsp';"+
                        "</script>");

            }else{
                System.out.println(res);
                showAlert(response,"余额已达上限，充值失败。可充值余额:"+res);

            }
        }else{

        }




    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doGet(request, response);
    }

    //只弹出弹窗
    private void showAlert(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<script type='text/javascript'>alert('" + message + "'); history.back();</script>");
    }

}
