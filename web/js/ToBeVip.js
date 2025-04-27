function buyVIP(level) {
    // VIP等级名称映射
    const vipNames = {
        1: "铜冠",
        2: "银冠",
        3: "金冠",
        4: "钻石冠",
        5: "至尊冠"
    };
    const vipName = vipNames[level] || `VIP${level}`;

    // 确认是否充值
    const isConfirm = confirm(`确定要充值${vipName}会员吗？`);
    if (!isConfirm) return;

    // 创建表单弹窗
    const formHtml = `
        <div id="vipFormModal" style="position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);display:flex;justify-content:center;align-items:center;z-index:1000;">
            <div style="background:white;padding:20px;border-radius:8px;width:400px;max-height:80vh;overflow-y:auto;">
                <h2 style="text-align:center;margin-bottom:20px;">${vipName}会员充值</h2>
                <form id="vipForm" method="post" action="/UserServlet">
                    <input type="hidden" name="type" value="beVip">
                    
                    <input type="hidden" name="vipLevel" value="${vipName}">
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">用户名：<span style="color:red;">*</span></label>
                        <input type="text" name="memberId" required 
                               pattern="^[\u4e00-\u9fa5a-zA-Z0-9_]{1,10}$"
                               title="只能使用汉字、数字、英文字母和_，不超过10位"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">姓名：<span style="color:red;">*</span></label>
                        <input type="text" name="name" required 
                               pattern="^[\u4e00-\u9fa5a-zA-Z0-9_]{1,10}$"
                               title="只能使用汉字、数字、英文字母和_，不超过10位"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">身份证号：<span style="color:red;">*</span></label>
                        <input type="text" name="userID" required 
                               pattern="^(\\d{15}|\\d{17}[\\dXx])$"
                               title="请输入15位或18位身份证号，18位最后一位可以是X"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                  
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">固定电话：</label>
                        <input type="tel" name="telephone"
                               pattern="^(\\d{3,4}-)?\\d{7,8}$"
                               title="格式如：025-87654321 或 87654321"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">邮箱：</label>
                        <input type="email" name="email"
                               pattern="^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"
                               title="请输入有效的邮箱地址"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">QQ号：</label>
                        <input type="text" name="qqNumber"
                               pattern="^\\d{5,12}$"
                               title="请输入5-12位QQ号"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">邮编：</label>
                        <input type="text" name="zipCode"
                               pattern="^\\d{6}$"
                               title="请输入6位邮编"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">地址：</label>
                        <input type="text" name="address"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">职务：</label>
                        <input type="text" name="occupation"
                               style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                    </div>
                    
                    <div style="margin-bottom:15px;">
                        <label style="display:block;margin-bottom:5px;font-weight:bold;">收入：<span style="color:red;">*</span></label>
                        <select name="income" required
                                style="width:100%;padding:8px;box-sizing:border-box;border:1px solid #ddd;border-radius:4px;">
                            <option value="">-- 请选择收入范围 --</option>
                            <option value="3000以下">3000以下</option>
                            <option value="3000-5000">3000-5000</option>
                            <option value="5000-8000">5000-8000</option>
                            <option value="8000-12000">8000-12000</option>
                            <option value="12000以上">12000以上</option>
                        </select>
                    </div>
                    
                    <div style="display:flex;justify-content:space-between;margin-top:20px;">
                        <button type="button" onclick="document.getElementById('vipFormModal').remove()" 
                                style="padding:10px 20px;background:#f0f0f0;border:1px solid #ddd;border-radius:4px;cursor:pointer;transition:all 0.3s;">取消</button>
                        <button type="submit" 
                                style="padding:10px 20px;background:#5bc1ee;color:white;border:none;border-radius:4px;cursor:pointer;transition:all 0.3s;font-weight:bold;">立即充值</button>
                    </div>
                </form>
            </div>
        </div>
    `;

    // 添加表单到页面
    document.body.insertAdjacentHTML('beforeend', formHtml);

    // 表单提交处理 - 保留浏览器原生验证和提交
    document.getElementById('vipForm').addEventListener('submit', function(e) {
        // 验证所有必填字段
        const requiredFields = this.querySelectorAll('[required]');
        let isValid = true;

        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                field.style.borderColor = 'red';
                isValid = false;
            } else {
                field.style.borderColor = '#ddd';
            }
        });

        if (!isValid) {
            alert('请填写所有必填字段');
            e.preventDefault();
            return;
        }

        // 验证格式
        const patternFields = this.querySelectorAll('[pattern]');
        for (const field of patternFields) {
            const regex = new RegExp(field.pattern);
            if (field.value && !regex.test(field.value)) {
                alert(field.title || '格式不正确');
                field.focus();
                e.preventDefault();
                return;
            }
        }
    });

    // 添加输入验证的实时反馈
    const inputs = document.querySelectorAll('#vipForm input, #vipForm select');
    inputs.forEach(input => {
        input.addEventListener('input', function() {
            if (this.hasAttribute('pattern')) {
                const regex = new RegExp(this.pattern);
                if (this.value && !regex.test(this.value)) {
                    this.style.borderColor = 'red';
                } else {
                    this.style.borderColor = '#ddd';
                }
            }
        });
    });
}