// 根据会员等级添加对应的样式类
function applyRankClass() {
    const rankElements = document.querySelectorAll('[class^="rank-"]');
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

// 表单验证
function validateForm(formId) {
    const form = document.getElementById(formId);
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;

    requiredFields.forEach(field => {
        if (!field.value.trim()) {
            field.style.borderColor = 'red';
            isValid = false;
        } else {
            field.style.borderColor = '#ddd';
        }
    });

    // 验证格式
    const patternFields = form.querySelectorAll('[pattern]');
    for (const field of patternFields) {
        const regex = new RegExp(field.pattern);
        if (field.value && !regex.test(field.value)) {
            alert(field.title || '格式不正确');
            field.focus();
            return false;
        }
    }

    return isValid;
}

// 添加表单提交事件监听
document.addEventListener('DOMContentLoaded', function() {
    applyRankClass();

    // 编辑表单验证
    const editForm = document.getElementById('editForm');
    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            if (!validateForm('editForm')) {
                e.preventDefault();
            }
        });
    }

    // 充值表单验证
    const rechargeForm = document.getElementById('rechargeForm');
    if (rechargeForm) {
        rechargeForm.addEventListener('submit', function(e) {
            const amountInput = document.getElementById('amount');
            if (!amountInput.value || parseFloat(amountInput.value) <= 0) {
                alert('请输入有效的充值金额');
                amountInput.focus();
                e.preventDefault();

            }
        });
    }

    // 实时输入验证反馈
    const inputs = document.querySelectorAll('input[pattern]');
    inputs.forEach(input => {
        input.addEventListener('input', function() {
            const regex = new RegExp(this.pattern);
            if (this.value && !regex.test(this.value)) {
                this.style.borderColor = 'red';
            } else {
                this.style.borderColor = '#ddd';
            }
        });
    });
});
