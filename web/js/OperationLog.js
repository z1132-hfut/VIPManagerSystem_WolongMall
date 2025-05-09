/*
// 操作日志存储
let operationLogs = JSON.parse(localStorage.getItem('vipOperationLogs')) || [];

// 初始化日志按钮事件
document.getElementById('logBtn').addEventListener('click', function() {
    showLogModal();
});

// 显示日志模态框
function showLogModal() {
    const logModal = document.getElementById('logModal');
    logModal.style.display = 'block';
    renderLogList();

    // 关闭按钮事件
    document.getElementById('closeLogModal').addEventListener('click', function() {
        logModal.style.display = 'none';
    });

    // 清空日志按钮事件
    document.getElementById('clearLogsBtn').addEventListener('click', function() {
        if(confirm('确定要清空所有操作日志吗？')) {
            operationLogs = [];
            saveLogs();
            renderLogList();
        }
    });
}

// 渲染日志列表
function renderLogList() {
    const logList = document.getElementById('logList');
    logList.innerHTML = '';

    if(operationLogs.length === 0) {
        logList.innerHTML = '<div class="no-data">暂无操作日志</div>';
        return;
    }

    // 按时间倒序排列
    const sortedLogs = [...operationLogs].sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));

    sortedLogs.forEach(log => {
        const logItem = document.createElement('div');
        logItem.className = 'log-item';
        logItem.style.padding = '10px';
        logItem.style.borderBottom = '1px solid #e2e8f0';

        let actionText = '';
        let actionButton = '';

        switch(log.action) {
            case 'search':
                // 查询操作：显示所有查询条件
                const searchConditions = log.details.conditions.join(', ');
                actionText = `执行了搜索操作，条件: ${searchConditions}`;
                actionButton = `<button class="btn btn-search" onclick="showSearchResults('${log.id}')" style="margin-left: 10px;">显示结果</button>`;
                break;
            case 'delete':
                // 删除操作：显示所有删除的会员名
                const deletedMembers = log.details.vipNames.join(', ');
                actionText = `删除了会员: ${deletedMembers}`;
                actionButton = `<button class="btn btn-delete" onclick="undoDelete('${log.id}')" style="margin-left: 10px;">撤销删除</button>`;
                break;
        }

        logItem.innerHTML = `
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <strong>${formatDateTime(log.timestamp)}</strong> - ${actionText}
                </div>
                ${actionButton}
            </div>
        `;

        logList.appendChild(logItem);
    });
}

// 添加日志
function addLog(action, details) {
    const log = {
        id: generateId(),
        action,
        details: transformDetails(action, details),
        timestamp: new Date().toISOString()
    };

    operationLogs.push(log);
    saveLogs();
}

// 根据操作类型转换details格式
function transformDetails(action, details) {
    switch(action) {
        case 'search':
            // 查询操作：将所有查询条件转换为数组
            return {
                conditions: Object.entries(details)
                    .filter(([key, value]) => value !== null && value !== '')
                    .map(([key, value]) => `${key}: ${value}`)
            };
        case 'delete':
            // 删除操作：将vipName转换为数组（支持批量删除）
            return {
                vipId: details.vipId,
                vipNames: Array.isArray(details.vipName) ? details.vipName : [details.vipName]
            };
        default:
            return details;
    }
}

/!*!// 保存日志到本地存储
function saveLogs() {
    localStorage.setItem('vipOperationLogs', JSON.stringify(operationLogs));
}*!/

// 生成唯一ID
function generateId() {
    return Date.now().toString(36) + Math.random().toString(36).substr(2);
}

// 格式化日期时间
function formatDateTime(isoString) {
    const date = new Date(isoString);
    return date.toLocaleString();
}

// 显示搜索结果
function showSearchResults(logId) {
    const log = operationLogs.find(l => l.id === logId);
    if(!log) return;

    alert(`当时的搜索条件是:\n${log.details.conditions.join('\n')}`);
}

// 撤销删除
/!*
function undoDelete(logId) {
    const log = operationLogs.find(l => l.id === logId);
    if(!log || log.action !== 'delete') return;

    // 这里需要调用后端API恢复删除的数据
    // 实际项目中应该通过AJAX调用后端接口
    console.log(`撤销删除会员: ${log.details.vipId}`);

    // 模拟恢复操作
    if(confirm(`确定要恢复被删除的会员 ${log.details.vipNames.join(', ')} 吗？`)) {
        // 调用后端API
        fetch(`${pageContext.request.contextPath}/vip/undoDelete`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ vipId: log.details.vipId })
        })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('恢复成功');
                    // 从日志中移除这条记录
                    operationLogs = operationLogs.filter(l => l.id !== logId);
                    saveLogs();
                    renderLogList();
                    // 刷新页面数据
                    location.reload();
                } else {
                    alert('恢复失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('恢复操作出错');
            });
    }
}*!/

// 撤销删除
function undoDelete(logId) {
    const log = operationLogs.find(l => l.id === logId);
    if(!log || log.action !== 'delete') return;

    if(confirm(`确定要恢复被删除的会员 ${log.details.vipNames.join(', ')} 吗？`)) {
        // 调用后端API
        fetch(`${pageContext.request.contextPath}/AllVIPServlet`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `type=undoDelete&vipIds=${encodeURIComponent(log.details.vipId)}`
        })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('恢复成功');
                    // 从日志中移除这条记录
                    operationLogs = operationLogs.filter(l => l.id !== logId);
                    saveLogs();
                    renderLogList();
                    // 刷新页面数据
                    location.reload();
                } else {
                    alert('恢复失败: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('恢复操作出错');
            });
    }
}

*/

//操作日志存储
let operationLogs = JSON.parse(localStorage.getItem('vipOperationLogs')) || [];
//初始化日志按钮事件
document.getElementById('logBtn').addEventListener('click', function() {
    showLogModal();
});
//清空日志按钮事件
document.getElementById('clearLogsBtn').addEventListener('click', function() {
    if(confirm('确定要清空所有操作日志吗？')) {
        operationLogs = [];
        saveLogs();
        renderLogList();
    }
});
//显示日志模态框
function showLogModal() {
    const logModal = document.getElementById('logModal');
    logModal.style.display = 'block';
    renderLogList();

    // 只保留关闭按钮的事件绑定（如果需要）
    document.getElementById('closeLogModal').addEventListener('click', function() {
        logModal.style.display = 'none';
    });
}
//添加日志
function addLog(action, details) {
    const log = {
        id: generateId(),
        action,
        details: transformDetails(action, details),
        timestamp: new Date().toISOString()
    };

    operationLogs.push(log);
    saveLogs();
}
//保存日志到本地存储
function saveLogs() {
    localStorage.setItem('vipOperationLogs', JSON.stringify(operationLogs));
}
//生成唯一ID
function generateId() {
    return Date.now().toString(36) + Math.random().toString(36).substr(2);
}
//格式化日期时间
function formatDateTime(isoString) {
    const date = new Date(isoString);
    return date.toLocaleString();
}
/*// 辅助函数：添加表单字段
function addFormField(form, name, value) {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = name;
    input.value = value;
    form.appendChild(input);
}*/
//删除单条日志
function deleteLog(logId) {
    if(confirm('确定要删除这条操作日志吗？')) {
        // 从日志数组中移除指定日志
        operationLogs = operationLogs.filter(log => log.id !== logId);
        // 保存到本地存储
        saveLogs();
        // 重新渲染日志列表
        renderLogList();
    }
}


//渲染日志信息
function renderLogList() {
    const logList = document.getElementById('logList');
    logList.innerHTML = '';

    if(operationLogs.length === 0) {
        logList.innerHTML = '<div class="no-data">暂无操作日志</div>';
        return;
    }

    // 按时间倒序排列
    const sortedLogs = [...operationLogs].sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));

    sortedLogs.forEach(log => {
        const logItem = document.createElement('div');
        logItem.className = 'log-item';
        logItem.style.padding = '10px';
        logItem.style.borderBottom = '1px solid #e2e8f0';

        let actionText = '';
        let actionButton = '';

        switch(log.action) {
            case 'search':
                // 查询操作：显示所有查询条件
                const searchConditions = log.details.conditions.join(', ');
                actionText = `执行了搜索操作，条件: ${searchConditions}`;
                actionButton = `
                    <div style="display: flex; justify-content: flex-end; gap: 10px;">
                        <button class="btn btn-search" onclick="showSearchResults('${log.id}')" 
                            style="margin-left: 10px;">显示结果</button>
                        <button class="btn btn-delete" onclick="deleteLog('${log.id}')" 
                            style="margin-left: 10px;">删除日志</button>
                    </div>`;
                break;
            case 'delete':
                // 删除操作：显示所有删除的会员名
                const deletedMembers = log.details.vipNames.join(', ');
                actionText = `删除了会员: ${deletedMembers}`;
                actionButton = `
                    <div style="display: flex; justify-content: flex-end; gap: 10px;">
                        <button class="btn btn-search" onclick="undoDelete('${log.id}')" 
                            style="margin-left: 10px;">撤销删除</button>
                        <button class="btn btn-delete" onclick="deleteLog('${log.id}')" 
                            style="margin-left: 10px;">删除日志</button>
                    </div>`;
                break;
            case 'undoAddRemark':
                // 备注操作：显示会员名及其备注
                const addRemarkMember = log.details.vipId;
                actionText = `给会员${addRemarkMember}添加了备注${log.details.newRemark}。原备注：${log.details.historyRemark}`;
                actionButton = `
                    <div style="display: flex; justify-content: flex-end; gap: 10px;">
                        <button class="btn btn-search" onclick="undoAddRemark('${log.id}')" 
                            style="margin-left: 10px;">撤销修改</button>
                        <button class="btn btn-delete" onclick="deleteLog('${log.id}')" 
                            style="margin-left: 10px;">删除日志</button>
                    </div>`;
                break;
            case 'undoFreeze':
                // 冻结/解冻操作：显示会员名及其状态
                const member = log.details.vipId;
                actionText = `将会员: ${member}的状态修改为${log.details.newStatus}`;
                actionButton = `
                    <div style="display: flex; justify-content: flex-end; gap: 10px;">
                        <button class="btn btn-search" onclick="undoFreeze('${log.id}')" 
                            style="margin-left: 10px;">撤销操作</button>
                        <button class="btn btn-delete" onclick="deleteLog('${log.id}')" 
                            style="margin-left: 10px;">删除日志</button>
                    </div>`;
                break;
            default:
                // 其他操作类型
                actionText = `执行了${log.action}操作`;
                actionButton = `
                    <button class="btn btn-delete" onclick="deleteLog('${log.id}')" 
                        style="margin-left: 10px;">删除日志</button>
                `;
        }

        logItem.innerHTML = `
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <strong>${formatDateTime(log.timestamp)}</strong> - ${actionText}
                </div>
                ${actionButton}
            </div>
        `;

        logList.appendChild(logItem);
    });
}

//根据操作类型转换details格式
function transformDetails(action, details) {
    switch(action) {
        case 'search':
            // 查询操作：将所有查询条件转换为数组
            return {
                conditions: Object.entries(details)
                    .filter(([key, value]) => value !== null && value !== '')
                    .map(([key, value]) => `${key}: ${value}`)
            };
        case 'delete':
            // 删除操作：将vipName转换为数组（支持批量删除）
            return {
                vipId: details.vipId,
                vipNames: Array.isArray(details.vipName) ? details.vipName : [details.vipName]
            };
        case 'undoAddRemark':
            // 撤回添加备注操作：添加id和新旧备注
            return {
                vipId: details.id,
                historyRemark: details.historyremark,
                newRemark: details.newremark
            };
        case 'undoFreeze':
            // 撤回冻结/解冻：添加
            return {
                vipId: details.vipId,
                oldStatus: details.oldStatus,
                newStatus: details.newStatus,
            };
        default:
            return details;
    }
}


//显示搜索结果
function showSearchResults(logId) {
    const log = operationLogs.find(l => l.id === logId);
    if(!log) return;

    // 从日志中提取搜索条件
    const conditions = {};
    log.details.conditions.forEach(cond => {
        const [key, value] = cond.split(': ');
        conditions[key.trim()] = value.trim();
    });

    // 获取表格中的所有行
    const rows = document.querySelectorAll('tbody tr');

    rows.forEach(row => {
        if (row.querySelector('.no-data')) return;

        const cells = row.querySelectorAll('td');
        let found = true;

        // 检查每个搜索条件
        if (conditions['会员名'] && !cells[1].textContent.toLowerCase().includes(conditions['会员名'].toLowerCase())) {
            found = false;
        }
        if (conditions['姓名'] && !cells[3].textContent.toLowerCase().includes(conditions['姓名'].toLowerCase())) {
            found = false;
        }
        if (conditions['身份证号'] && !cells[4].textContent.toLowerCase().includes(conditions['身份证号'].toLowerCase())) {
            found = false;
        }
        if (conditions['手机号码'] && !cells[5].textContent.toLowerCase().includes(conditions['手机号码'].toLowerCase())) {
            found = false;
        }
        if (conditions['固定电话'] && !cells[6].textContent.toLowerCase().includes(conditions['固定电话'].toLowerCase())) {
            found = false;
        }
        if (conditions['电子邮件'] && !cells[7].textContent.toLowerCase().includes(conditions['电子邮件'].toLowerCase())) {
            found = false;
        }
        if (conditions['QQ'] && !cells[8].textContent.toLowerCase().includes(conditions['QQ'].toLowerCase())) {
            found = false;
        }
        if (conditions['邮编'] && !cells[9].textContent.toLowerCase().includes(conditions['邮编'].toLowerCase())) {
            found = false;
        }
        if (conditions['详细地址'] && !cells[10].textContent.toLowerCase().includes(conditions['详细地址'].toLowerCase())) {
            found = false;
        }
        if (conditions['职业'] && !cells[11].textContent.toLowerCase().includes(conditions['职业'].toLowerCase())) {
            found = false;
        }
        if (conditions['收入水平'] && !cells[12].textContent.toLowerCase().includes(conditions['收入水平'].toLowerCase())) {
            found = false;
        }
        if (conditions['会员级别'] && !cells[13].textContent.toLowerCase().includes(conditions['会员级别'].toLowerCase())) {
            found = false;
        }
        if (conditions['当前积分'] && !cells[14].textContent.toLowerCase().includes(conditions['当前积分'].toLowerCase())) {
            found = false;
        }
        if (conditions['账户余额'] && !cells[15].textContent.toLowerCase().includes(conditions['账户余额'].toLowerCase())) {
            found = false;
        }
        if (conditions['加入日期'] && !cells[16].textContent.toLowerCase().includes(conditions['加入日期'].toLowerCase())) {
            found = false;
        }
        if (conditions['状态']) {
            const statusText = cells[17].textContent.trim();
            if (conditions['状态'].toLowerCase() !== statusText.toLowerCase()) {
                found = false;
            }
        }
        if (conditions['备注'] && !cells[18].textContent.toLowerCase().includes(conditions['备注'].toLowerCase())) {
            found = false;
        }

        row.style.display = found ? '' : 'none';
    });

    // 关闭日志模态框
    document.getElementById('logModal').style.display = 'none';
}

// 撤销删除（传统的表单提交格式）
function undoDelete(logId) {
    const log = operationLogs.find(l => l.id === logId);
    if(!log || log.action !== 'delete') return;

    if(confirm(`确定要恢复被删除的会员 ${log.details.vipNames.join(', ')} 吗？`)) {
        // 创建form元素
        const form = document.createElement('form');
        form.method = 'POST';
        //form.action = fullPath;  // 使用计算得到的路径
        form.action = `/AllVIPServlet`;  //正确后端路径
        form.style.display = 'none';

        // 添加type参数
        const typeInput = document.createElement('input');
        typeInput.type = 'hidden';
        typeInput.name = 'type';
        typeInput.value = 'undoDelete';
        form.appendChild(typeInput);

        // 添加vipIds参数
        const idsInput = document.createElement('input');
        idsInput.type = 'hidden';
        idsInput.name = 'vipIds';
        idsInput.value = Array.isArray(log.details.vipId) ?
            log.details.vipId.join(',') :
            log.details.vipId;
        form.appendChild(idsInput);

        // 添加到DOM并提交
        document.body.appendChild(form);
        form.submit();

        // 从日志中移除这条记录
        operationLogs = operationLogs.filter(l => l.id !== logId);
        saveLogs();
    }
}

// 撤销添加备注（传统的表单提交格式）
function undoAddRemark(logId) {
    // if(!log) return;

    const log = operationLogs.find(l => l.id === logId);

    if(confirm(`确定撤销给会员 ${log.details.vipId} 添加备注吗？`)) {
        // 创建form元素
        const form = document.createElement('form');
        form.method = 'POST';
        //form.action = fullPath;  // 使用计算得到的路径
        form.action = `/AllVIPServlet`;  //正确后端路径
        form.style.display = 'none';

        // 添加type参数
        const typeInput = document.createElement('input');
        typeInput.type = 'hidden';
        typeInput.name = 'type';
        typeInput.value = 'undoAddRemark';
        form.appendChild(typeInput);

        // 添加id参数
        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'vipid';
        idInput.value = log.details.vipId;
        form.appendChild(idInput);

        // 添加原备注
        const remarkInput = document.createElement('input');
        remarkInput.type = 'hidden';
        remarkInput.name = 'remark';
        remarkInput.value = log.details.historyRemark;
        form.appendChild(remarkInput);

        // 添加到DOM并提交
        document.body.appendChild(form);
        form.submit();

        // 从日志中移除这条记录
        operationLogs = operationLogs.filter(l => l.id !== logId);
        saveLogs();
    }
}

// 撤销冻结/解冻（传统的表单提交格式）
function undoFreeze(logId) {
    const log = operationLogs.find(l => l.id === logId);
    // if(!log) return;

    if(confirm(`确定要撤销对会员 ${log.details.vipId} 的${log.details.newStatus}操作吗？`)) {
        // 创建form元素
        const form = document.createElement('form');
        form.method = 'POST';
        //form.action = fullPath;  // 使用计算得到的路径
        form.action = `/AllVIPServlet`;  //正确后端路径
        form.style.display = 'none';

        // 添加type参数
        const typeInput = document.createElement('input');
        typeInput.type = 'hidden';
        typeInput.name = 'type';
        typeInput.value = 'undoFreeze';
        form.appendChild(typeInput);

        // 添加vipId参数
        const idsInput = document.createElement('input');
        idsInput.type = 'hidden';
        idsInput.name = 'vipid';
        idsInput.value = log.details.vipId;
        form.appendChild(idsInput);

        // 添加状态参数
        const sInput = document.createElement('input');
        sInput.type = 'hidden';
        sInput.name = 'status';
        sInput.value = log.details.oldStatus;
        form.appendChild(sInput);

        // 添加到DOM并提交
        document.body.appendChild(form);
        form.submit();

        // 从日志中移除这条记录
        operationLogs = operationLogs.filter(l => l.id !== logId);
        saveLogs();
    }
}