package com.wht.servlet;

import com.wht.pojo.AllUsers.User;
import com.wht.pojo.AllUsers.VIP;
import com.wht.service.VIPService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 此类用于实现管理员相关功能：管理员登录（会员查看）、会员删除/冻结

@WebServlet("/AllVIPServlet")
public class AllVIPServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 添加请求编码设置
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //catalina.bat开头添加：set "JAVA_OPTS=%JAVA_OPTS% -Dfile.encoding=UTF-8"

        response.setContentType("text/html");
        String type = request.getParameter("type");

        VIPService vs = new VIPService();
        //存储全部会员信息
        ArrayList<VIP> vipList = new ArrayList<>();

        //管理员登录（会员查看）
        if(type.equals("allvip")){
            String Mname = request.getParameter("managername");
            String Mpassword = request.getParameter("mpassword");
            if(vs.existManager(Mname,Mpassword)){
                vipList = vs.GetAllVIPs();
                request.getSession().setAttribute("AllVIP", vipList);
                request.getSession().setAttribute("ison", type);
                response.sendRedirect(request.getContextPath() + "/jsp/ManagerPages/showAllVIP.jsp");
            }else{
                showAlert(response,"管理员昵称或密码错误");
            }
        //删除会员：
        }else if(type.equals("delete")){
            String[] vipId = request.getParameter("vipIds").split(",");
            vs.delVip(vipId);
            //刷新页面，实时展示
            //获取更新后的全部会员数据
            vipList = vs.GetAllVIPs();
            //更新页面数据，刷新
            request.getSession().setAttribute("AllVIP", vipList);
            request.getSession().setAttribute("ison", type);
            response.getWriter().println("<script type='text/javascript'> alert('删除成功');" +
                    "window.location.href='" + request.getContextPath() + "/jsp/ManagerPages/showAllVIP.jsp';"+
                    "</script>");

        //冻结/解冻
        }else if(type.equals("freeze")){
            String vipId = request.getParameter("vipid");
            System.out.println(vipId);
            vs.freezeVIP(vipId);
            //获取更新后的全部会员数据
            vipList = vs.GetAllVIPs();
            //更新页面数据，刷新
            request.getSession().setAttribute("AllVIP", vipList);
            request.getSession().setAttribute("ison", type);
            response.getWriter().println("<script type='text/javascript'> alert('操作成功');" +
                    "window.location.href='" + request.getContextPath() + "/jsp/ManagerPages/showAllVIP.jsp';"+
                    "</script>");
        //添加备注
        } else if (type.equals("addRemark")) {
            String vipId = request.getParameter("vipid");
            String remark = request.getParameter("remark");
            System.out.println(vipId+" "+remark);
            vs.addRemark(vipId, remark);
            //获取更新后的全部会员数据
            vipList = vs.GetAllVIPs();
            //更新页面数据，刷新
            request.getSession().setAttribute("AllVIP", vipList);
            request.getSession().setAttribute("ison", type);
            response.getWriter().println("<script type='text/javascript'> alert('添加备注成功');" +
                    "window.location.href='" + request.getContextPath() + "/jsp/ManagerPages/showAllVIP.jsp';"+
                    "</script>");
        //撤回删除操作：
        }else if(type.equals("undoDelete")){
            String[] vipId = request.getParameter("vipIds").split(",");
            ArrayList<String> res = vs.undoDeleteVIP(vipId);
            if(!res.isEmpty()){
                StringBuilder vips= new StringBuilder();
                for (int i = 0; i < res.size()-1; i++) {
                    vips.append(res.get(i)).append(",");
                }
                vips.append(res.get(res.size()-1));
                /*//刷新页面，实时展示
                //获取更新后的全部会员数据
                vipList = vs.GetAllVIPs();
                //更新页面数据，刷新
                request.getSession().setAttribute("AllVIP", vipList);
                request.getSession().setAttribute("ison", type);*/
                //showAlert(response,"用户 "+ vips +" 已重新成为vip，撤回失败。其他用户撤回成功");
                response.getWriter().println("<script type='text/javascript'> alert('用户 \"+ vips +\" 已重新成为vip，" +
                        "撤回失败。其他用户撤回成功');" +
                        "window.location.href='" + request.getContextPath() + "/jsp/ManagerPages/showAllVIP.jsp';"+
                        "</script>");
            }else{ //全部成功撤回
                /*//刷新页面，实时展示
                //获取更新后的全部会员数据
                vipList = vs.GetAllVIPs();
                //更新页面数据，刷新
                request.getSession().setAttribute("AllVIP", vipList);
                request.getSession().setAttribute("ison", type);*/
                response.getWriter().println("<script type='text/javascript'> alert('撤回删除成功');" +
                        "window.location.href='" + request.getContextPath() + "/jsp/ManagerPages/showAllVIP.jsp';"+
                        "</script>");
            }
            //刷新页面，实时展示
            //获取更新后的全部会员数据
            vipList = vs.GetAllVIPs();
            //更新页面数据，刷新
            request.getSession().setAttribute("AllVIP", vipList);
            request.getSession().setAttribute("ison", type);

        }

    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doGet(request, response);
    }

    private void showAlert(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<script type='text/javascript'>alert('" + message + "'); history.back();</script>");
    }
}
