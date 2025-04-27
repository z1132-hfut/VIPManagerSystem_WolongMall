<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员登录</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center; /*居中*/
            align-items: center;
            background-image: url('../../img/Manager_Login_back.jpg'); /* 背景图片路径 */
            background-size: cover; /* 背景图片覆盖整个页面 */
            background-position: center; /* 背景图片居中 */
        }

        #login-container {
            background-color: rgba(255, 255, 255, 0.9); /* 半透明白色背景 */
            padding: 20px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        #login-container h2 {
            margin-bottom: 20px;
            color: #333;
        }

        #login-manager-form label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            text-align: left;
        }

        #manager-username {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        #manager-password {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        #loginButton {
            width: 50%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        #loginButton:hover {
            background-color: #0056b3;
        }

        #login-manager-form h5 {
            margin-top: 10px;
            color: #777;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div id="login-container">
    <h2>管理员登录</h2>
    <form id="login-manager-form" method="post" action="${pageContext.request.contextPath}/AllVIPServlet"
          autocomplete="off">
        <input type="hidden" name="type" value="allvip">    <!-- 隐藏字段传递type -->

        <label for="manager-username">管理员昵称:</label>
        <input type="text" id="manager-username" name="managername" required><br><br>

        <label for="manager-password">密码:</label>
        <input type="password" id="manager-password" name="mpassword" required><br><br>

        <button type="submit" id="LoginButton">登录</button>
    </form>
</div>

<script src="${pageContext.request.contextPath}/js/login_manager.js"></script>
</body>
</html>
