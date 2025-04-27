<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center; /*居中*/
            align-items: center;
            background-image: url('${pageContext.request.contextPath}/img/Login_back.jpg'); /* 背景图片路径 */
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

        #login-form label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            text-align: left;
        }

        #login-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .button-container {
            display: flex;
            gap: 10px; /* 按钮之间的间距 */
            margin-top: 10px;
        }

        #LoginButton {
            flex: 1; /* 平分剩余空间 */
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #RegisterButton {
            flex: 1; /* 平分剩余空间 */
            padding: 10px;
            background-color: #28a745; /* 绿色区别于登录按钮 */
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #LoginButton:hover {
            background-color: #0056b3;
        }

        #RegisterButton:hover {
            background-color: #218838;
        }

        #login-form h5 {
            margin-top: 10px;
            color: #777;
            font-size: 14px;
        }

        #forgetPassword {
            display: block;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
        }

    </style>

</head>
<body>
<div id="login-container">
    <h2>登录</h2>
    <form id="login-form" method="post" action="${pageContext.request.contextPath}/UserServlet"
          autocomplete="off"> <%-- autocomplete="off"：防止浏览器保存密码--%>
        <input type="hidden" name="type" value="userlogin">    <!-- 关键修改2：隐藏字段传递type -->

        <label for="memberId">用户名:</label>
        <input type="text" id="memberId" name="id" required >  <!-- 关键修改3：name改为uname -->

        <label for="password">密码:</label>
        <input type="password" id="password" name="pw" required>  <!-- 关键修改4：name改为pw -->

        <div class="button-container">
            <button type="submit" id="LoginButton">登录</button>  <!-- 直接提交表单 -->
            <button type="button" id="RegisterButton"
                    onclick="window.location.href='register.jsp'">注册</button>
        </div>
        <br>
        <a href="forgetPassword.jsp" id="forgetPassword">忘记密码</a>
    </form>

</div>

<script src="${pageContext.request.contextPath}/js/login.js"></script>


</body>
</html>


