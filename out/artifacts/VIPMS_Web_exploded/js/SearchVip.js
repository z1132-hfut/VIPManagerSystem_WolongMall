// 搜索模态框相关操作
const searchModal = document.getElementById('searchModal');
const searchBtn = document.getElementById('searchBtn');
const closeBtn = document.querySelector('.search-modal-close');
const doSearchBtn = document.getElementById('doSearchBtn');
const resetSearchBtn = document.getElementById('resetSearchBtn');

// 打开搜索模态框
searchBtn.addEventListener('click', function() {
    searchModal.style.display = 'block';
    //清空上一次搜索
    const inputs = document.querySelectorAll('.search-form-input');
    inputs.forEach(input => {
        input.value = '';
        /*if (input.type === 'text') {
            input.value = '';
        } else if (input.tagName === 'SELECT') {
            input.value = '';
        }*/
    });
});

// 关闭搜索模态框
closeBtn.addEventListener('click', function() {
    searchModal.style.display = 'none';
});

// 点击模态框外部关闭
window.addEventListener('click', function(event) {
    if (event.target === searchModal) {
        searchModal.style.display = 'none';
    }
});

// 重置搜索条件
resetSearchBtn.addEventListener('click', function() {
    const inputs = document.querySelectorAll('.search-form-input');
    inputs.forEach(input => {
        input.value = '';
        /*if (input.type === 'text') {
            input.value = '';
        } else if (input.tagName === 'SELECT') {
            input.value = '';
        }*/
    });
});
// 执行搜索
doSearchBtn.addEventListener('click', function() {
    // 获取所有搜索条件
    const searchId = document.getElementById('searchId').value.toLowerCase();
    const searchName = document.getElementById('searchName').value.toLowerCase();
    const searchUserId = document.getElementById('searchUserId').value.toLowerCase();
    const searchMobilephone = document.getElementById('searchMobilephone').value.toLowerCase();
    const searchTelephone = document.getElementById('searchTelephone').value.toLowerCase();
    const searchEmail = document.getElementById('searchEmail').value.toLowerCase();
    const searchQqNumber = document.getElementById('searchQqNumber').value.toLowerCase();
    const searchZipCode = document.getElementById('searchZipCode').value.toLowerCase();
    const searchAddress = document.getElementById('searchAddress').value.toLowerCase();
    const searchOccupation = document.getElementById('searchOccupation').value.toLowerCase();
    const searchIncome = document.getElementById('searchIncome').value.toLowerCase();
    const searchRankMember = document.getElementById('searchRankMember').value.toLowerCase();
    const searchCurrentScore = document.getElementById('searchCurrentScore').value.toLowerCase();
    const searchBalance = document.getElementById('searchBalance').value.toLowerCase();
    const searchJoinDate = document.getElementById('searchJoinDate').value.toLowerCase();
    const searchStatus = document.getElementById('searchStatus').value;
    const searchRemark = document.getElementById('searchRemark').value.toLowerCase();

    const rows = document.querySelectorAll('tbody tr');

    rows.forEach(row => {
        if (row.querySelector('.no-data')) return;

        const cells = row.querySelectorAll('td');
        let found = true;

        // 检查每个搜索条件
        if (searchId && !cells[1].textContent.toLowerCase().includes(searchId)) {
            found = false;
        }
        if (searchName && !cells[3].textContent.toLowerCase().includes(searchName)) {
            found = false;
        }
        if (searchUserId && !cells[4].textContent.toLowerCase().includes(searchUserId)) {
            found = false;
        }
        if (searchMobilephone && !cells[5].textContent.toLowerCase().includes(searchMobilephone)) {
            found = false;
        }
        if (searchTelephone && !cells[6].textContent.toLowerCase().includes(searchTelephone)) {
            found = false;
        }
        if (searchEmail && !cells[7].textContent.toLowerCase().includes(searchEmail)) {
            found = false;
        }
        if (searchQqNumber && !cells[8].textContent.toLowerCase().includes(searchQqNumber)) {
            found = false;
        }
        if (searchZipCode && !cells[9].textContent.toLowerCase().includes(searchZipCode)) {
            found = false;
        }
        if (searchAddress && !cells[10].textContent.toLowerCase().includes(searchAddress)) {
            found = false;
        }
        if (searchOccupation && !cells[11].textContent.toLowerCase().includes(searchOccupation)) {
            found = false;
        }
        if (searchIncome && !cells[12].textContent.toLowerCase().includes(searchIncome)) {
            found = false;
        }
        if (searchRankMember && !cells[13].textContent.toLowerCase().includes(searchRankMember)) {
            found = false;
        }
        if (searchCurrentScore && !cells[14].textContent.toLowerCase().includes(searchCurrentScore)) {
            found = false;
        }
        if (searchBalance && !cells[15].textContent.toLowerCase().includes(searchBalance)) {
            found = false;
        }
        if (searchJoinDate && !cells[16].textContent.toLowerCase().includes(searchJoinDate)) {
            found = false;
        }
        if (searchStatus) {
            const statusText = cells[17].textContent.trim();
            if (searchStatus !== statusText) {
                found = false;
            }
        }
        if (searchRemark && !cells[18].textContent.toLowerCase().includes(searchRemark)) {
            found = false;
        }

        row.style.display = found ? '' : 'none';


    }
    );

    //添加日志：
    const searchDetails = {
        '会员名': searchId,
        '姓名': searchName,
        '身份证号': searchUserId,
        '手机号码': searchMobilephone,
        '固定电话': searchTelephone,
        '电子邮件': searchEmail,
        'QQ': searchQqNumber,
        '邮编': searchZipCode,
        '详细地址': searchAddress,
        '职业': searchOccupation,
        '收入水平': searchIncome,
        '会员级别': searchRankMember,
        '当前积分': searchCurrentScore,
        '账户余额': searchBalance,
        '加入日期': searchJoinDate,
        '状态': searchStatus,
        '备注': searchRemark
    };
    addLog('search', searchDetails);//searchDetails    //'条件查询'
    // 关闭模态框
    searchModal.style.display = 'none';
});

