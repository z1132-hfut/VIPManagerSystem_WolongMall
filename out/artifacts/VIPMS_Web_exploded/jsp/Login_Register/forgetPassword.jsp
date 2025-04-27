<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>忘记密码</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      height: 100vh;
      display: flex;
      justify-content: center;
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

    #changePassword-form label {
      display: block;
      margin-bottom: 8px;
      color: #555;
      text-align: left;
    }

    #changePassword-form input {
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

    #ChangePasswordButton {
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

    #ChangePasswordButton:hover {
      background-color: #0056b3;
    }

    #ExitButton {
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

    #ExitButton:hover {
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
  <h2>修改密码</h2>
  <form id="changePassword-form" method="post" action="${pageContext.request.contextPath}/UserServlet"
        autocomplete="off">
    <input type="hidden" name="type" value="changePassword">

    <label for="MemberID">用户名:</label>
    <input type="text" id="MemberID" name="MemberID" required >

    <label for="Phone">手机号:</label>
    <input type="tel" id="Phone" name="Phone" required >

    <label for="newpassword">新密码:</label>
    <input type="password" id="newpassword" name="npw" required>

    <label for="confirmnewpassword">确认新密码:</label>
    <input type="password" id="confirmnewpassword" name="cnpw" required>

    <div class="button-container">
      <button type="submit" id="ChangePasswordButton">确认</button>
      <button type="button" id="ExitButton"
              onclick="window.location.href='login.jsp'">返回</button>
    </div>
    <br>
  </form>

</div>

<script src="${pageContext.request.contextPath}/js/changePassword.js"></script>

</body>
</html>



