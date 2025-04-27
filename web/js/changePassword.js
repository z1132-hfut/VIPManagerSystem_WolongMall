document.getElementById('changePassword-form').addEventListener('submit', function (event) {
    event.preventDefault(); // 阻止表单默认提交行为
    // 获取输入的信息
    const username = document.getElementById('MemberID').value;
    const phone = document.getElementById('Phone').value;
    const password = document.getElementById('newpassword').value;
    const confirmPassword = document.getElementById('confirmnewpassword').value;
    // 验证用户名：只能使用汉字、数字、英文字母和_，不超过10位
    const nameRegex = /^[\u4e00-\u9fa5a-zA-Z0-9_]{1,10}$/;
    if (!nameRegex.test(username)) {
        if(username.length > 10) {
            alert("用户名不能超过10个字符！");
        } else {
            alert('用户名只能包含汉字、数字、英文字母和下划线(_)');
        }
        return false; // 阻止表单提交
    }
    // 验证手机号：11位数，只能由数字组成
    const phoneRegex = /^\d{11}$/;
    if (!phoneRegex.test(phone)) {
        alert('手机号必须是11位数字');
        return false;
    }
    // 验证密码：6-20位，只能使用大小写英文字符，阿拉伯数字，_和@
    const passwordRegex = /^[a-zA-Z0-9_@]{6,20}$/;
    if (!passwordRegex.test(password)) {
        alert('密码必须是6-20位，只能包含字母、数字、下划线(_)和@符号');
        return false;
    }
    // 验证确认密码：和密码相同
    if (password !== confirmPassword) {
        alert('两次输入的密码不一致');
        return false;
    }
    // 所有验证通过，可以提交表单
    this.submit();
});
