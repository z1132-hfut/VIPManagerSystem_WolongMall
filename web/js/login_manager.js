document.getElementById("login-manager-form").addEventListener("submit", function(e) {
    e.preventDefault(); // 阻止默认提交
    // 获取输入的用户名和密码
    const username = document.getElementById('manager-username').value;
    const password = document.getElementById('manager-password').value;

    // 用户名正则：只能使用汉字、数字和英文字母和_，不超过10位
    const usernameRegex = /^[\u4e00-\u9fa5a-zA-Z0-9_]{1,10}$/;

    // 密码正则：6-20位，只能使用大小写英文字符，阿拉伯数字，_和@
    const passwordRegex = /^[a-zA-Z0-9_@]{6,20}$/;

    // 验证用户名格式
    if (!usernameRegex.test(username)) {
        if(username.length > 10) {
            alert("用户名不能超过10个字符！");
        } else {
            alert("用户名只能包含汉字、数字和英文字母！");
        }
        document.getElementById('managername').focus();
        return;
    }

    // 验证密码格式
    if (!passwordRegex.test(password)) {
        if(password.length < 6) {
            alert("密码不能少于6个字符！");
        } else if(password.length > 20) {
            alert("密码不能超过20个字符！");
        } else {
            alert("密码只能包含数字、英文字母和以下特殊字符：\\|@%&#");
        }
        document.getElementById('mpassword').focus();
        return;
    }

    // 格式验证通过后提交表单
    this.submit();
});