<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center; /* 居中显示 */
            align-items: center;
            background-image: url('../../img/Login_back.jpg');
            background-size: cover;
            background-position: center;
        }

        #register-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 320px;
            text-align: center;
        }

        #register-container h2 {
            margin-bottom: 25px;
            color: #333;
        }

        #register-form label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            text-align: left;
            font-size: 14px;
        }

        #register-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        #registerButton {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        #registerButton:hover {
            background-color: #218838;
        }

        #loginLink {
            display: block;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
        }

        #loginLink:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div id="register-container">
    <h2>用户注册</h2>
    <form id="register-form" method="post" action="${pageContext.request.contextPath}/UserServlet"
          autocomplete="off">
        <input type="hidden" name="type" value="userregister">    <!-- 隐藏字段传递type -->

        <label for="MemberID">用户名:</label>
        <input type="text" id="MemberID" name="MemberID" required placeholder="请输入您的姓名">

        <label for="Mobilephone">手机号码:</label>
        <input type="tel" id="Mobilephone" name="Mobilephone" required placeholder="请输入11位手机号码">

        <label for="Password">密码:</label>
        <input type="password" id="Password" name="Password" required placeholder="请输入6-20位密码">

        <label for="confirmPassword">确认密码:</label>
        <input type="password" id="confirmPassword" name="cpw" required placeholder="请再次输入密码">

        <button type="submit" id="registerButton">注册</button>
        <a href="login.jsp" id="loginLink">已有账号？立即登录</a>
    </form>
</div>

<script src="${pageContext.request.contextPath}/js/register.js"></script>
</body>
</html>
