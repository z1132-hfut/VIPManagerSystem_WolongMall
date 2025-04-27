<%@ page import="com.wht.pojo.AllUsers.VIP" %><%--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员中心</title>
    <style>
        /* 全局样式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        /* 顶部导航栏 */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(135deg, #ffc843, #ffdf68);
            padding: 15px 30px;
            color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header h2 {
            margin: 0;
            font-size: 24px;
        }

        .header .links {
            display: flex;
            gap: 20px;
        }

        .header .links a {
            color: white;
            text-decoration: none;
            font-size: 14px;
        }

        .header .links a:hover {
            text-decoration: underline;
        }

        /* 会员中心内容区域 */
        .vip-container {
            display: flex;
            padding: 30px;
            max-width: 900px;
            margin: 30px auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* 头像区域 */
        .avatar-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            border-right: 1px solid #eee;
        }

        .avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin-bottom: 20px;
            border: 3px solid #ffc843;
        }

        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-placeholder {
            font-size: 50px;
            color: #ccc;
        }

        .member-name {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .member-rank {
            font-size: 16px;
            color: #ff6b00;
            margin-bottom: 15px;
        }

        .avatar-upload {
            margin-top: 20px;
        }

        /* 信息表格区域 */
        .info-section {
            flex: 2;
            padding: 0 20px;
        }

        .vip-title {
            color: #ff6b00;
            margin-bottom: 20px;
            font-size: 24px;
            text-align: center;
        }

        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .info-table th, .info-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .info-table th {
            width: 30%;
            font-weight: bold;
            color: #666;
            background-color: #f9f9f9;
        }

        .info-table td {
            color: #333;
        }

        .highlight {
            color: #f67346;
            font-weight: bold;
        }

        .rank-copper {
            color: #cd7f32; /* 铜色 */
        }

        .rank-silver {
            color: #c0c0c0; /* 银色 */
        }

        .rank-gold {
            color: #ffd700; /* 金色 */
        }

        .rank-diamond {
            color: #b9f2ff; /* 钻石色 */
        }

        .rank-supreme {
            color: #ff00ff; /* 至尊色 */
        }

        /* 操作按钮区域 */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .btn {
            padding: 10px 25px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-edit {
            background-color: #5bc1ee;
            color: white;
        }

        .btn-edit:hover {
            background-color: #4aa8d5;
        }

        .btn-recharge {
            background-color: #f67346;
            color: white;
        }

        .btn-recharge:hover {
            background-color: #e56235;
        }

        /* 模态框样式 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 400px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .modal-title {
            font-size: 20px;
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #666;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .modal-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-cancel {
            background-color: #ccc;
            color: #333;
        }

        .btn-cancel:hover {
            background-color: #bbb;
        }

        .btn-submit {
            background-color: #5bc1ee;
            color: white;
        }

        .btn-submit:hover {
            background-color: #4aa8d5;
        }
    </style>
</head>
<body>

<!-- 顶部导航栏 -->
<div class="header">
    <h2>会员中心</h2>
    <div class="links">
        <a href="${pageContext.request.contextPath}/jsp/UserPages/VIP_Page.jsp">返回商城</a>
        <a href="${pageContext.request.contextPath}/jsp/UserPages/ToBeVIP.jsp">VIP升级</a>
        <a href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">重新登录</a>
    </div>
</div>

<!-- 会员中心内容区域 -->
<div class="vip-container">
    <!-- 头像区域 -->
    <div class="avatar-section">
        <div class="avatar">
            <div class="avatar-placeholder"></div>
            <img src="${pageContext.request.contextPath}/img/User.jpg" alt="会员头像">
        </div>
        <div class="member-name">${sessionScope.user.Name}</div>
        <div class="member-rank rank-${sessionScope.user.RankMember}">${sessionScope.user.RankMember}会员</div>

        &lt;%&ndash;<div class="avatar-upload">
            <input type="file" id="avatar-upload" style="display: none;">
            <button class="btn btn-edit" onclick="document.getElementById('avatar-upload').click()">更换头像</button>
        </div>&ndash;%&gt;
    </div>

    <!-- 信息表格区域 -->
    <div class="info-section">
        <h2 class="vip-title">会员详细信息</h2>

        <table class="info-table">
            <tr>
                <th>会员ID</th>
                <td>${sessionScope.user.MemberID}</td>
            </tr>
            <tr>
                <th>身份证号</th>
                <td>${sessionScope.user.UserID}</td>
            </tr>
            <tr>
                <th>手机号码</th>
                <td>${sessionScope.user.Mobilephone}</td>
            </tr>
            <tr>
                <th>固定电话</th>
                <td>${sessionScope.user.Telephone}</td>
            </tr>
            <tr>
                <th>电子邮箱</th>
                <td>${sessionScope.user.EMail}</td>
            </tr>
            <tr>
                <th>QQ号码</th>
                <td>${sessionScope.user.QQNumber}</td>
            </tr>
            <tr>
                <th>邮编</th>
                <td>${sessionScope.user.ZipCode}</td>
            </tr>
            <tr>
                <th>详细地址</th>
                <td>${sessionScope.user.Address}</td>
            </tr>
            <tr>
                <th>职业</th>
                <td>${sessionScope.user.Occupation}</td>
            </tr>
            <tr>
                <th>收入水平</th>
                <td>${sessionScope.user.Income}</td>
            </tr>
            <tr>
                <th>会员级别</th>
                <td class="rank-${sessionScope.user.RankMember}">${sessionScope.user.RankMember}</td>
            </tr>
            <tr>
                <th>当前积分</th>
                <td class="highlight">${sessionScope.user.CurrentScore}</td>
            </tr>
            <tr>
                <th>账户余额</th>
                <td class="highlight">￥${sessionScope.user.BalanceEAccount}</td>
            </tr>
            <tr>
                <th>加入日期</th>
                <td>${sessionScope.user.JoinDate}</td>
            </tr>
            <tr>
                <th>账户状态</th>
                <td>${sessionScope.user.IsFreezed ? '已冻结' : '正常'}</td>
            </tr>
        </table>

        <div class="action-buttons">
            <button class="btn btn-edit" onclick="openEditModal()">修改信息</button>
            <button class="btn btn-recharge" onclick="openRechargeModal()">充值余额</button>
        </div>
    </div>
</div>

<!-- 修改信息模态框 -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <h3 class="modal-title">修改个人信息</h3>
        <form id="editForm" action="${pageContext.request.contextPath}/UpdateUserInfoServlet" method="post">
            <div class="form-group">
                <label for="mobilephone">手机号码：</label>
                <input type="text" id="mobilephone" name="mobilephone" value="${sessionScope.user.Mobilephone}">
            </div>
            <div class="form-group">
                <label for="telephone">固定电话：</label>
                <input type="text" id="telephone" name="telephone" value="${sessionScope.user.Telephone}">
            </div>
            <div class="form-group">
                <label for="email">电子邮箱：</label>
                <input type="email" id="email" name="email" value="${sessionScope.user.EMail}">
            </div>
            <div class="form-group">
                <label for="qq">QQ号码：</label>
                <input type="text" id="qq" name="qq" value="${sessionScope.user.QQNumber}">
            </div>
            <div class="form-group">
                <label for="zipcode">邮编：</label>
                <input type="text" id="zipcode" name="zipcode" value="${sessionScope.user.ZipCode}">
            </div>
            <div class="form-group">
                <label for="address">详细地址：</label>
                <input type="text" id="address" name="address" value="${sessionScope.user.Address}">
            </div>
            <div class="form-group">
                <label for="occupation">职业：</label>
                <input type="text" id="occupation" name="occupation" value="${sessionScope.user.Occupation}">
            </div>
            <div class="modal-buttons">
                <button type="button" class="btn btn-cancel" onclick="closeEditModal()">取消</button>
                <button type="submit" class="btn btn-submit">保存</button>
            </div>
        </form>
    </div>
</div>

<!-- 充值余额模态框 -->
<div id="rechargeModal" class="modal">
    <div class="modal-content">
        <h3 class="modal-title">账户充值</h3>
        <form id="rechargeForm" action="${pageContext.request.contextPath}/RechargeServlet" method="post">
            <div class="form-group">
                <label for="amount">充值金额：</label>
                <input type="number" id="amount" name="amount" min="1" placeholder="请输入充值金额">
            </div>
            <div class="form-group">
                <label for="paymentMethod">支付方式：</label>
                <select id="paymentMethod" name="paymentMethod">
                    <option value="alipay">支付宝</option>
                    <option value="wechat">微信支付</option>
                    <option value="bank">银行卡</option>
                </select>
            </div>
            <div class="modal-buttons">
                <button type="button" class="btn btn-cancel" onclick="closeRechargeModal()">取消</button>
                <button type="submit" class="btn btn-submit">确认充值</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 根据会员等级添加对应的样式类
    function applyRankClass() {
        const rankElements = document.querySelectorAll('.rank-copper, .rank-silver, .rank-gold, .rank-diamond, .rank-supreme');
        rankElements.forEach(el => {
            const rank = el.textContent.trim();
            el.className = ''; // 清除所有类
            el.classList.add(`rank-${rank}`);
        });
    }

    // 打开修改信息模态框
    function openEditModal() {
        document.getElementById('editModal').style.display = 'block';
    }

    // 关闭修改信息模态框
    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }

    // 打开充值模态框
    function openRechargeModal() {
        document.getElementById('rechargeModal').style.display = 'block';
    }

    // 关闭充值模态框
    function closeRechargeModal() {
        document.getElementById('rechargeModal').style.display = 'none';
    }

    // 点击模态框外部关闭模态框
    window.onclick = function(event) {
        if (event.target.className === 'modal') {
            event.target.style.display = 'none';
        }
    }

    // 页面加载完成后执行
    document.addEventListener('DOMContentLoaded', function() {
        applyRankClass();
    });
</script>

</body>
</html>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员中心</title>
    <style>
        /* 全局样式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        /* 顶部导航栏 */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(135deg, #ffc843, #ffdf68);
            padding: 15px 30px;
            color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header h2 {
            margin: 0;
            font-size: 24px;
        }

        .header .links {
            display: flex;
            gap: 20px;
        }

        .header .links a {
            color: white;
            text-decoration: none;
            font-size: 14px;
        }

        .header .links a:hover {
            text-decoration: underline;
        }

        /* 会员中心内容区域 */
        .vip-container {
            padding: 30px;
            max-width: 900px;
            margin: 30px auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .avatar-placeholder {
            font-size: 50px;
            color: #ccc;
        }

        .member-name {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .member-rank {
            font-size: 16px;
            color: #ff6b00;
            margin-bottom: 15px;
        }

        /* 信息表格区域 */
        .info-section {
            width: 100%;
        }

        .vip-title {
            color: #ff6b00;
            margin-bottom: 20px;
            font-size: 24px;
            text-align: center;
        }

        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .info-table th, .info-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .info-table th {
            width: 30%;
            font-weight: bold;
            color: #666;
            background-color: #f9f9f9;
        }

        .info-table td {
            color: #333;
        }

        .highlight {
            color: #f67346;
            font-weight: bold;
        }

        .rank-铜冠 {
            color: #cd7f32; /* 铜色 */
        }

        .rank-银冠 {
            color: #c0c0c0; /* 银色 */
        }

        .rank-金冠 {
            color: #ffd700; /* 金色 */
        }

        .rank-钻石冠 {
            color: #b9f2ff; /* 钻石色 */
        }

        .rank-至尊冠 {
            color: #ff00ff; /* 至尊色 */
        }

        /* 操作按钮区域 */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .btn {
            padding: 10px 25px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-edit {
            background-color: #5bc1ee;
            color: white;
        }

        .btn-edit:hover {
            background-color: #4aa8d5;
        }

        .btn-recharge {
            background-color: #f67346;
            color: white;
        }

        .btn-recharge:hover {
            background-color: #e56235;
        }

        /* 模态框样式 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 400px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .modal-title {
            font-size: 20px;
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #666;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .modal-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-cancel {
            background-color: #ccc;
            color: #333;
        }

        .btn-cancel:hover {
            background-color: #bbb;
        }

        .btn-submit {
            background-color: #5bc1ee;
            color: white;
        }

        .btn-submit:hover {
            background-color: #4aa8d5;
        }
    </style>
</head>
<body>

<!-- 顶部导航栏 -->
<div class="header">
    <h2>会员中心</h2>
    <div class="links">
        <a href="${pageContext.request.contextPath}/jsp/UserPages/VIP_Page.jsp">返回商城</a>
        <a href="${pageContext.request.contextPath}/jsp/UserPages/ToBeVIP.jsp">VIP升级</a>
        <a href="${pageContext.request.contextPath}/jsp/Login_Register/login.jsp">重新登录</a>
    </div>
</div>

<!-- 会员中心内容区域 -->
<div class="vip-container">
    <%
        VIP v = (VIP)request.getSession().getAttribute("vip");
    %>
    <!-- 信息表格区域 -->
    <div class="info-section">
        <h2 class="vip-title">个人信息</h2>

        <table class="info-table">
            <tr>
                <th>用户名</th>
                <td><%=v.getID()%></td>
            </tr>
            <tr>
                <th>会员名</th>
                <td><%=v.getName()%></td>
            </tr>
            <tr>
                <th>身份证号</th>
                <td><%=v.getUserID()%></td>
            </tr>
            <tr>
                <th>手机号码</th>
                <td><%=v.getMobilephone()%></td>
            </tr>
            <tr>
                <th>固定电话</th>
                <td><%=v.getTelephone()%></td>
            </tr>
            <tr>
                <th>电子邮箱</th>
                <td><%=v.getEmail()%></td>
            </tr>
            <tr>
                <th>QQ号码</th>
                <td><%=v.getQqNumber()%></td>
            </tr>
            <tr>
                <th>邮编</th>
                <td><%=v.getZipCode()%></td>
            </tr>
            <tr>
                <th>详细地址</th>
                <td><%=v.getAddress()%></td>
            </tr>
            <tr>
                <th>职业</th>
                <td><%=v.getOccupation()%></td>
            </tr>
            <tr>
                <th>收入水平</th>
                <td><%=v.getIncome()%></td>
            </tr>
            <tr>
                <th>会员级别</th>
                <td class="rank-<%= v.getRankMember()%>"><%= v.getRankMember()%></td>
            </tr>
            <tr>
                <th>当前积分</th>
                <td class="highlight"><%=v.getCurrentScore()%></td>
            </tr>
            <tr>
                <th>账户余额</th>
                <td class="highlight">￥<%=String.format("%.2f", v.getBalanceEAccount())%></td>
            </tr>
            <tr>
                <th>加入日期</th>
                <td><%=v.getJoinDate()%></td>
            </tr>
            <tr>
                <th>账户状态</th>
                <td><%=v.isFreezed() ? "冻结" : "正常"%></td>
            </tr>
        </table>

        <div class="action-buttons">
            <button class="btn btn-edit" onclick="openEditModal()">修改信息</button>
            <button class="btn btn-recharge" onclick="openRechargeModal()">充值余额</button>
        </div>
    </div>
</div>

<!-- 修改信息模态框 -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <h3 class="modal-title">修改个人信息</h3>
        <form id="editForm" action="${pageContext.request.contextPath}/UserServlet" method="post">
            <input type="hidden" name="type" value="vipChange">
            <input type="hidden" id="oldmemberId" name="oldmemberId" value="<%=v.getID()%>">
            <input type="hidden" id="olduserId" name="olduserId" value="<%=v.getUserID()%>">

            <div class="form-group">
                <label for="memberId">用户名：</label>
                <input type="text" id="memberId" name="memberId" value="<%=v.getID()%>"
                       pattern="^[\u4e00-\u9fa5a-zA-Z0-9_]{1,10}$" title="只能使用汉字、数字、英文字母和_，不超过10位">
            </div>
            <div class="form-group">
                <label for="name">会员名：</label>
                <input type="text" id="name" name="name" value="<%=v.getName()%>"
                       pattern="^[\u4e00-\u9fa5a-zA-Z0-9_]{1,10}$" title="只能使用汉字、数字、英文字母和_，不超过10位">
            </div>
            <div class="form-group">
                <label for="userId">身份证号：</label>
                <input type="text" id="userId" name="userId" value="<%=v.getUserID()%>"
                       pattern="^(\d{15}|\d{17}[\dXx])$" title="请输入15位或18位身份证号，18位最后一位可以是X">
            </div>
            <div class="form-group">
                <label for="mobilephone">手机号码：</label>
                <input type="text" id="mobilephone" name="mobilephone" value="<%=v.getMobilephone()%>"
                       pattern="^1[3-9]\d{9}$" title="请输入正确的手机号码">
            </div>
            <div class="form-group">
                <label for="telephone">固定电话：</label>
                <input type="text" id="telephone" name="telephone" value="<%=v.getTelephone()%>"
                       pattern="^(\d{3,4}-)?\d{7,8}$" title="格式如：025-87654321 或 87654321">
            </div>
            <div class="form-group">
                <label for="email">电子邮箱：</label>
                <input type="email" id="email" name="email" value="<%=v.getEmail()%>"
                       pattern="^[^\s@]+@[^\s@]+\.[^\s@]+$" title="请输入有效的邮箱地址">
            </div>
            <div class="form-group">
                <label for="qq">QQ号码：</label>
                <input type="text" id="qq" name="qq" value="<%=v.getQqNumber()%>"
                       pattern="^\d{5,12}$" title="请输入5-12位QQ号">
            </div>
            <div class="form-group">
                <label for="zipcode">邮编：</label>
                <input type="text" id="zipcode" name="zipcode" value="<%=v.getZipCode()%>"
                       pattern="^\d{6}$" title="请输入6位邮编">
            </div>
            <div class="form-group">
                <label for="address">详细地址：</label>
                <input type="text" id="address" name="address" value="<%=v.getAddress()%>">
            </div>
            <div class="form-group">
                <label for="occupation">职业：</label>
                <input type="text" id="occupation" name="occupation" value="<%=v.getOccupation()%>">
            </div>
            <div class="form-group">
                <label for="income">收入水平：</label>
                <select id="income" name="income" required>
                    <option value="3000以下" <%= "3000以下".equals(v.getIncome()) ? "selected" : "" %>>3000以下</option>
                    <option value="3000-5000" <%= "3000-5000".equals(v.getIncome()) ? "selected" : "" %>>3000-5000</option>
                    <option value="5000-8000" <%= "5000-8000".equals(v.getIncome()) ? "selected" : "" %>>5000-8000</option>
                    <option value="8000-12000" <%= "8000-12000".equals(v.getIncome()) ? "selected" : "" %>>8000-12000</option>
                    <option value="12000以上" <%= "12000以上".equals(v.getIncome()) ? "selected" : "" %>>12000以上</option>
                </select>
            </div>
            <div class="modal-buttons">
                <button type="submit" class="btn btn-submit" onclick="closeEditModal()">保存</button>
                <button type="button" class="btn btn-cancel" onclick="closeEditModal()">取消</button>
            </div>
        </form>
    </div>
</div>


<!-- 充值余额模态框 -->
<div id="rechargeModal" class="modal">
    <div class="modal-content">
        <h3 class="modal-title">账户充值</h3>
        <form id="rechargeForm" action="${pageContext.request.contextPath}/UserServlet" method="post">
            <input type="hidden" name="type" value="recharge">
            <input type="hidden" id="mid" name="mid" value="<%=v.getID()%>">
            <div class="form-group">
                <label for="amount">充值金额：</label>
                <input type="number" id="amount" name="amount" min="1" placeholder="请输入充值金额">
            </div>
            <div class="form-group">
                <label for="paymentMethod">支付方式：</label>
                <select id="paymentMethod" name="paymentMethod">
                    <option value="alipay">支付宝</option>
                    <option value="wechat">微信支付</option>
                    <option value="bank">银行卡</option>
                </select>
            </div>
            <div class="modal-buttons">
                <button type="submit" class="btn btn-submit" onclick="closeRechargeModal()">确认充值</button>
                <button type="button" class="btn btn-cancel" onclick="closeRechargeModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/VipChangeInfo.js"></script>

</body>
</html>
