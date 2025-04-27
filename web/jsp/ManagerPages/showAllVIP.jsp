<%--
功能正常，无日志版本
<%@ page import="com.wht.pojo.AllUsers.VIP" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员信息管理系统</title>
    <style>
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', -apple-system, BlinkMacSystemFont, sans-serif;
            margin: 0;
            padding: 15px;
            background-color: #f8fafc;
            color: #334155;
            font-size: 13px;
            line-height: 1.5;
        }
        .container {
            max-width: 100%;
            margin: 0 auto;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        h1 {
            text-align: center;
            color: #1e293b;
            margin: 10px 0 18px;
            padding-bottom: 8px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 18px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 12px 0;
        }
        th, td {
            padding: 8px 12px;
            text-align: center;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
        }
        th {
            background-color: #3676e0;
            color: white;
            font-weight: 600;
            font-size: 12px;
            padding: 7px 10px;
            letter-spacing: 0.3px;
            text-transform: uppercase;
            border-color: #93c5fd;
        }
        tr:nth-child(even) {
            background-color: #f8fafc;
        }
        tr:hover {
            background-color: #e0f2fe;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }
        .avatar {
            border-radius: 50%;
            width: 38px;
            height: 38px;
            object-fit: cover;
            border: 2px solid #e2e8f0;
        }
        .no-data {
            text-align: center;
            padding: 16px;
            color: #64748b;
            font-style: italic;
            font-size: 13px;
            font-weight: 500;
        }
        /* 按钮美化样式 */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 12px;
            margin: 0 5px;
            border: none;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            font-weight: 600;
            letter-spacing: 0.3px;
            height: 32px;
            min-width: 80px;
        }

        .btn-delete {
            background-color: #ef4444;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-delete:hover {
            background-color: #dc2626;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-freeze {
            background-color: #3b82f6;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-freeze:hover {
            background-color: #2563eb;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-unfreeze {
            background-color: #10b981;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-unfreeze:hover {
            background-color: #059669;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-batch {
            background-color: #8b5cf6;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-batch:hover {
            background-color: #7c3aed;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-search {
            background-color: #06b6d4;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-search:hover {
            background-color: #0891b2;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 5px;
        }

        /* 表格头部区域样式 */
        .table-header {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 15px;
            gap: 10px;
        }

        /* 批量选择复选框 */
        .batch-checkbox {
            margin-right: 8px;
            cursor: pointer;
        }

        /* 状态标签 */
        .status-active {
            color: #10b981;
            font-weight: 600;
        }

        .status-frozen {
            color: #ef4444;
            font-weight: 600;
        }

        /* 搜索模态框样式 */
        .search-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            overflow-y: auto;
        }

        .search-modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border-radius: 8px;
            width: 80%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .search-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e2e8f0;
            position: sticky;
            top: 0;
            background-color: #fff;
            z-index: 1;
        }

        .search-modal-title {
            font-size: 16px;
            font-weight: 600;
            color: #1e293b;
        }

        .search-modal-close {
            font-size: 20px;
            font-weight: bold;
            color: #64748b;
            cursor: pointer;
        }

        .search-modal-close:hover {
            color: #334155;
        }

        .search-form-group {
            margin-bottom: 15px;
        }

        .search-form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #475569;
        }

        .search-form-input {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 13px;
            transition: all 0.2s ease;
        }

        .search-form-input:focus {
            outline: none;
            border-color: #93c5fd;
            box-shadow: 0 0 0 3px rgba(147, 197, 253, 0.3);
        }

        .search-modal-footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            position: sticky;
            bottom: 0;
            background-color: #fff;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }

        /* 搜索条件网格布局 */
        .search-form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .btn-log {
            background-color: #64748b;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-log:hover {
            background-color: #475569;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* 备注单元格样式 */
        .remark-cell {
            cursor: pointer;
        }

        .remark-input {
            width: 100%;
            padding: 5px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 13px;
        }

        .remark-input:focus {
            outline: none;
            border-color: #93c5fd;
            box-shadow: 0 0 0 2px rgba(147, 197, 253, 0.3);
        }

        /*响应式调整。根据设备的屏幕宽度来调整网页的样式，主要用于移动端*/
        @media (max-width: 768px) {
            body {
                padding: 12px;
                font-size: 12px;
            }
            .container {
                padding: 12px;
            }
            th, td {
                padding: 7px;
                font-size: 11px;
            }
            .btn-group {
                flex-direction: column;
                align-items: center;
            }
            .btn {
                margin: 3px 0;
                width: 80%;
                padding: 4px 8px;
            }
            .search-modal-content {
                width: 90%;
                margin: 10% auto;
            }
            .search-form-grid {
                grid-template-columns: 1fr;
            }
            .table-header {
                flex-wrap: wrap;
                justify-content: center;
            }
        }

        /*.btn-freeze, .btn-unfreeze {
            padding: 4px 8px;
            min-width: 60px;
            height: 28px;
            font-size: 11px;
        }

        !* 备注表单样式 *!
        .remark-form {
            display: none;
        }*/

    </style>
</head>
<body>
<div class="container">
    <h1>会员信息管理系统</h1>

    <div class="table-header">
        <!-- 管理日志按钮 -->
        <button class="btn btn-log" id="logBtn">管理日志</button>

        <!-- 条件搜索按钮 -->
        <button class="btn btn-search" id="searchBtn">条件搜索</button>

        <!-- 批量操作按钮 -->
        &lt;%&ndash;<button class="btn btn-batch" id="batchOperationBtn">批量操作</button>&ndash;%&gt;

        <!-- 删除按钮 -->
        <button class="btn btn-delete" id="batchDeleteBtn">删除</button>

        <!-- 添加批量删除表单 -->
        <form id="batchDeleteForm" action="${pageContext.request.contextPath}/AllVIPServlet" method="post">
            <input type="hidden" name="type" value="delete">
            <input type="hidden" name="vipIds" id="batchDeleteVipIds">
        </form>

        <!-- 添加备注表单 -->
        <form id="remarkForm" action="${pageContext.request.contextPath}/AllVIPServlet" method="post">
            <input type="hidden" name="type" value="addRemark">
            <input type="hidden" name="vipid" id="remarkVipId">
            <input type="hidden" name="remark" id="remarkContent">
        </form>

    </div>

    <table>
        <thead>
        <tr>
            <th><input type="checkbox" id="selectAll" class="batch-checkbox"></th>
            <th>会员名</th>
            <th>头像</th>
            <th>姓名</th>
            <th>身份证号</th>
            <th>手机号码</th>
            <th>固定电话</th>
            <th>电子邮件</th>
            <th>QQ号码</th>
            <th>邮编</th>
            <th>详细地址</th>
            <th>职业</th>
            <th>收入水平</th>
            <th>会员级别</th>
            <th>当前积分</th>
            <th>账户余额</th>
            <th>加入日期</th>
            <th>状态</th>
            <th>备注</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            ArrayList<VIP> av = (ArrayList<VIP>)request.getSession().getAttribute("AllVIP");
            if(av != null && !av.isEmpty()) {
                for(VIP v : av) {
        %>
        <tr>
            <td><input type="checkbox" id="select" name="batchSelect" class="batch-checkbox"></td>
            <td><%=v.getID()%></td>
            <td><img src="../../img/User.jpg" alt="头像" class="avatar"></td>
            <td><%=v.getName()%></td>
            <td><%=v.getUserID()%></td>
            <td><%=v.getMobilephone()%></td>
            <td><%=v.getTelephone()%></td>
            <td><%=v.getEmail()%></td>
            <td><%=v.getQqNumber()%></td>
            <td><%=v.getZipCode()%></td>
            <td><%=v.getAddress()%></td>
            <td><%=v.getOccupation()%></td>
            <td><%=v.getIncome()%></td>
            <td><%= v.getRankMember()%></td>
            <td><%=v.getCurrentScore()%></td>
            <td>¥<%=String.format("%.2f", v.getBalanceEAccount())%></td>
            <td><%=v.getJoinDate()%></td>
            <td class="<%=v.isFreezed() ? "status-frozen" : "status-active"%>">
                <%=v.isFreezed() ? "冻结" : "正常"%>
            </td>
            <td class="remark-cell" data-vipid="<%=v.getID()%>">
                <span class="remark-text"><%=v.getRemark() != null ? v.getRemark() : ""%></span>
                <input type="text" class="remark-input" value="<%=v.getRemark() != null ? v.getRemark() : ""%>"style="display: none;">
            </td>
            <td>
                <div class="btn-group">
                    <a class="btn <%=v.isFreezed() ? "btn-unfreeze" : "btn-freeze"%>"
                       href="${pageContext.request.contextPath}/AllVIPServlet?type=freeze&vipid=<%=v.getID()%>">
                        <%=v.isFreezed() ? "解冻" : "冻结"%>
                    </a>
                </div>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="20" class="no-data">暂无会员数据</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- 搜索模态框 -->
<div id="searchModal" class="search-modal">
    <div class="search-modal-content">
        <div class="search-modal-header">
            <div class="search-modal-title">高级搜索</div>
            <span class="search-modal-close">&times;</span>
        </div>
        <div class="search-modal-body">
            <div class="search-form-grid">
                <div class="search-form-group">
                    <label class="search-form-label">会员名</label>
                    <input type="text" class="search-form-input" id="searchId">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">姓名</label>
                    <input type="text" class="search-form-input" id="searchName">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">身份证号</label>
                    <input type="text" class="search-form-input" id="searchUserId">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">手机号码</label>
                    <input type="text" class="search-form-input" id="searchMobilephone">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">固定电话</label>
                    <input type="text" class="search-form-input" id="searchTelephone">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">电子邮件</label>
                    <input type="text" class="search-form-input" id="searchEmail">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">QQ号码</label>
                    <input type="text" class="search-form-input" id="searchQqNumber">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">邮编</label>
                    <input type="text" class="search-form-input" id="searchZipCode">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">详细地址</label>
                    <input type="text" class="search-form-input" id="searchAddress">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">职业</label>
                    <input type="text" class="search-form-input" id="searchOccupation">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">收入水平</label>
                    <input type="text" class="search-form-input" id="searchIncome">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">会员级别</label>
                    <input type="text" class="search-form-input" id="searchRankMember">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">当前积分</label>
                    <input type="text" class="search-form-input" id="searchCurrentScore">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">账户余额</label>
                    <input type="text" class="search-form-input" id="searchBalance">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">加入日期</label>
                    <input type="text" class="search-form-input" id="searchJoinDate" placeholder="格式: YYYY-MM-DD">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">状态</label>
                    <select class="search-form-input" id="searchStatus">
                        <option value="">全部</option>
                        <option value="正常">正常</option>
                        <option value="冻结">冻结</option>
                    </select>
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">备注</label>
                    <input type="text" class="search-form-input" id="searchRemark">
                </div>
            </div>
        </div>
        <div class="search-modal-footer">
            <button class="btn" id="resetSearchBtn" style="background-color: #e2e8f0;">重置</button>
            <button class="btn btn-search" id="doSearchBtn" style="margin-left: 10px;">搜索</button>
        </div>
    </div>
</div>

<!-- 日志模态框 -->
<div id="logModal" class="search-modal">
    <div class="search-modal-content">
        <div class="search-modal-header">
            <div class="search-modal-title">操作日志</div>
            <span class="search-modal-close" id="closeLogModal">&times;</span>
        </div>
        <div class="search-modal-body">
            <div id="logList">
                <!-- 日志列表将通过JS动态生成 -->
                <!-- 展示：查找（结果回看），删除（撤回），冻结/解冻，备注 -->
            </div>
        </div>
        <div class="search-modal-footer">
            <button class="btn" id="clearLogsBtn" style="background-color: #e2e8f0;">清空日志</button>
        </div>
    </div>
</div>

<!-- 全选，删除功能相关 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 备注单元格点击事件 -->
<script>
    $('.remark-cell').click(function() {
        var cell = $(this);
        var textSpan = cell.find('.remark-text');
        var inputField = cell.find('.remark-input');
        var vipId = cell.data('vipid');
        var originalRemark = textSpan.text().trim();

        // 显示输入框，隐藏文本
        textSpan.hide();
        inputField.show().focus().val(originalRemark);

        // 输入框失去焦点时保存
        inputField.blur(function() {
            var newRemark = $(this).val().trim();

            if (newRemark !== originalRemark) {
                // 设置表单数据并提交
                $('#remarkVipId').val(vipId);
                $('#remarkContent').val(newRemark);
                $('#remarkForm').submit();
            }

            // 隐藏输入框，显示文本
            inputField.hide();
            textSpan.show();
        });

        // 按Enter键保存
        inputField.keypress(function(e) {
            if (e.which === 13) { // Enter键
                $(this).blur();
            }
        });
    });
</script>

<!--全选复选框事件-->
<script>
    $('#selectAll').change(function() {
        $('input[name="batchSelect"]').prop('checked', $(this).is(':checked'));
    });

    $('#batchOperationBtn').click(function() {
        // 切换复选框的显示状态
        $('.batch-checkbox').toggle();
        // 切换删除按钮的显示状态
        $('#batchDeleteBtn').toggle();

        // 如果复选框显示，则选中全选复选框
        if ($('.batch-checkbox').is(':visible')) {
            $('#selectAll').prop('checked', true);
            $('input[name="batchSelect"]').prop('checked', true);
        } else {
            $('#selectAll').prop('checked', false);
            $('input[name="batchSelect"]').prop('checked', false);
        }
    });
</script>

<script src="${pageContext.request.contextPath}/js/OperationLog.js"></script>
<script src="${pageContext.request.contextPath}/js/SearchVip.js"></script>
<script src="${pageContext.request.contextPath}/js/deleteVip.js"></script>

</body>
</html>
--%>

<%@ page import="com.wht.pojo.AllUsers.VIP" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员信息管理系统</title>
    <style>
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', -apple-system, BlinkMacSystemFont, sans-serif;
            margin: 0;
            padding: 15px;
            background-color: #f8fafc;
            color: #334155;
            font-size: 13px;
            line-height: 1.5;
        }
        .container {
            max-width: 100%;
            margin: 0 auto;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
        h1 {
            text-align: center;
            color: #1e293b;
            margin: 10px 0 18px;
            padding-bottom: 8px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 18px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 12px 0;
        }
        th, td {
            padding: 8px 12px;
            text-align: center;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
        }
        th {
            background-color: #3676e0;
            color: white;
            font-weight: 600;
            font-size: 12px;
            padding: 7px 10px;
            letter-spacing: 0.3px;
            text-transform: uppercase;
            border-color: #93c5fd;
        }
        tr:nth-child(even) {
            background-color: #f8fafc;
        }
        tr:hover {
            background-color: #e0f2fe;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }
        .avatar {
            border-radius: 50%;
            width: 38px;
            height: 38px;
            object-fit: cover;
            border: 2px solid #e2e8f0;
        }
        .no-data {
            text-align: center;
            padding: 16px;
            color: #64748b;
            font-style: italic;
            font-size: 13px;
            font-weight: 500;
        }
        /* 按钮美化样式 */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 12px;
            margin: 0 5px;
            border: none;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            font-weight: 600;
            letter-spacing: 0.3px;
            height: 32px;
            min-width: 80px;
        }

        .btn-delete {
            background-color: #ef4444;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-delete:hover {
            background-color: #dc2626;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-freeze {
            background-color: #3b82f6;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-freeze:hover {
            background-color: #2563eb;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-unfreeze {
            background-color: #10b981;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-unfreeze:hover {
            background-color: #059669;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-batch {
            background-color: #8b5cf6;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-batch:hover {
            background-color: #7c3aed;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-search {
            background-color: #06b6d4;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-search:hover {
            background-color: #0891b2;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 5px;
        }

        /* 表格头部区域样式 */
        .table-header {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 15px;
            gap: 10px;
        }

        /* 批量选择复选框 */
        .batch-checkbox {
            margin-right: 8px;
            cursor: pointer;
        }

        /* 状态标签 */
        .status-active {
            color: #10b981;
            font-weight: 600;
        }

        .status-frozen {
            color: #ef4444;
            font-weight: 600;
        }

        /* 搜索模态框样式 */
        .search-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            overflow-y: auto;
        }

        .search-modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border-radius: 8px;
            width: 80%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .search-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e2e8f0;
            position: sticky;
            top: 0;
            background-color: #fff;
            z-index: 1;
        }

        .search-modal-title {
            font-size: 16px;
            font-weight: 600;
            color: #1e293b;
        }

        .search-modal-close {
            font-size: 20px;
            font-weight: bold;
            color: #64748b;
            cursor: pointer;
        }

        .search-modal-close:hover {
            color: #334155;
        }

        .search-form-group {
            margin-bottom: 15px;
        }

        .search-form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #475569;
        }

        .search-form-input {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 13px;
            transition: all 0.2s ease;
        }

        .search-form-input:focus {
            outline: none;
            border-color: #93c5fd;
            box-shadow: 0 0 0 3px rgba(147, 197, 253, 0.3);
        }

        .search-modal-footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            position: sticky;
            bottom: 0;
            background-color: #fff;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }

        /* 搜索条件网格布局 */
        .search-form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .btn-log {
            background-color: #64748b;
            color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-log:hover {
            background-color: #475569;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* 备注单元格样式 */
        .remark-cell {
            cursor: pointer;
        }

        .remark-input {
            width: 100%;
            padding: 5px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 13px;
        }

        .remark-input:focus {
            outline: none;
            border-color: #93c5fd;
            box-shadow: 0 0 0 2px rgba(147, 197, 253, 0.3);
        }

        /*响应式调整。根据设备的屏幕宽度来调整网页的样式，主要用于移动端*/
        @media (max-width: 768px) {
            body {
                padding: 12px;
                font-size: 12px;
            }
            .container {
                padding: 12px;
            }
            th, td {
                padding: 7px;
                font-size: 11px;
            }
            .btn-group {
                flex-direction: column;
                align-items: center;
            }
            .btn {
                margin: 3px 0;
                width: 80%;
                padding: 4px 8px;
            }
            .search-modal-content {
                width: 90%;
                margin: 10% auto;
            }
            .search-form-grid {
                grid-template-columns: 1fr;
            }
            .table-header {
                flex-wrap: wrap;
                justify-content: center;
            }
        }

        /*.btn-freeze, .btn-unfreeze {
            padding: 4px 8px;
            min-width: 60px;
            height: 28px;
            font-size: 11px;
        }

        !* 备注表单样式 *!
        .remark-form {
            display: none;
        }*/

    </style>
</head>
<body>
<div class="container">
    <h1>会员信息管理系统</h1>

    <div class="table-header">
        <!-- 管理日志按钮 -->
        <button class="btn btn-log" id="logBtn">管理日志</button>

        <!-- 条件搜索按钮 -->
        <button class="btn btn-search" id="searchBtn">条件搜索</button>

        <!-- 删除按钮 -->
        <button class="btn btn-delete" id="batchDeleteBtn">删除</button>

        <!-- 添加批量删除表单 -->
        <form id="batchDeleteForm" action="${pageContext.request.contextPath}/AllVIPServlet" method="post">
            <input type="hidden" name="type" value="delete">
            <input type="hidden" name="vipIds" id="batchDeleteVipIds">
        </form>

        <!-- 添加备注表单 -->
        <form id="remarkForm" action="${pageContext.request.contextPath}/AllVIPServlet" method="post">
            <input type="hidden" name="type" value="addRemark">
            <input type="hidden" name="vipid" id="remarkVipId">
            <input type="hidden" name="remark" id="remarkContent">
        </form>

    </div>

    <table>
        <thead>
        <tr>
            <th><input type="checkbox" id="selectAll" class="batch-checkbox"></th>
            <th>会员名</th>
            <th>头像</th>
            <th>姓名</th>
            <th>身份证号</th>
            <th>手机号码</th>
            <th>固定电话</th>
            <th>电子邮件</th>
            <th>QQ号码</th>
            <th>邮编</th>
            <th>详细地址</th>
            <th>职业</th>
            <th>收入水平</th>
            <th>会员级别</th>
            <th>当前积分</th>
            <th>账户余额</th>
            <th>加入日期</th>
            <th>状态</th>
            <th>备注</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            ArrayList<VIP> av = (ArrayList<VIP>)request.getSession().getAttribute("AllVIP");
            if(av != null && !av.isEmpty()) {
                for(VIP v : av) {
        %>
        <tr>
            <td><input type="checkbox" id="select" name="batchSelect" class="batch-checkbox"></td>
            <td><%=v.getID()%></td>
            <td><img src="../../img/User.jpg" alt="头像" class="avatar"></td>
            <td><%=v.getName()%></td>
            <td><%=v.getUserID()%></td>
            <td><%=v.getMobilephone()%></td>
            <td><%=v.getTelephone()%></td>
            <td><%=v.getEmail()%></td>
            <td><%=v.getQqNumber()%></td>
            <td><%=v.getZipCode()%></td>
            <td><%=v.getAddress()%></td>
            <td><%=v.getOccupation()%></td>
            <td><%=v.getIncome()%></td>
            <td><%= v.getRankMember()%></td>
            <td><%=v.getCurrentScore()%></td>
            <td>¥<%=String.format("%.2f", v.getBalanceEAccount())%></td>
            <td><%=v.getJoinDate()%></td>
            <td class="<%=v.isFreezed() ? "status-frozen" : "status-active"%>">
                <%=v.isFreezed() ? "冻结" : "正常"%>
            </td>
            <td class="remark-cell" data-vipid="<%=v.getID()%>">
                <span class="remark-text"><%=v.getRemark() != null ? v.getRemark() : ""%></span>
                <input type="text" class="remark-input" value="<%=v.getRemark() != null ? v.getRemark() : ""%>"style="display: none;">
            </td>
            <td>
                <div class="btn-group">
                    <a class="btn <%=v.isFreezed() ? "btn-unfreeze" : "btn-freeze"%>"
                       href="${pageContext.request.contextPath}/AllVIPServlet?type=freeze&vipid=<%=v.getID()%>">
                        <%=v.isFreezed() ? "解冻" : "冻结"%>
                    </a>
                </div>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="20" class="no-data">暂无会员数据</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- 搜索模态框 -->
<div id="searchModal" class="search-modal">
    <div class="search-modal-content">
        <div class="search-modal-header">
            <div class="search-modal-title">高级搜索</div>
            <span class="search-modal-close">&times;</span>
        </div>
        <div class="search-modal-body">
            <div class="search-form-grid">
                <div class="search-form-group">
                    <label class="search-form-label">会员名</label>
                    <input type="text" class="search-form-input" id="searchId">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">姓名</label>
                    <input type="text" class="search-form-input" id="searchName">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">身份证号</label>
                    <input type="text" class="search-form-input" id="searchUserId">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">手机号码</label>
                    <input type="text" class="search-form-input" id="searchMobilephone">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">固定电话</label>
                    <input type="text" class="search-form-input" id="searchTelephone">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">电子邮件</label>
                    <input type="text" class="search-form-input" id="searchEmail">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">QQ号码</label>
                    <input type="text" class="search-form-input" id="searchQqNumber">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">邮编</label>
                    <input type="text" class="search-form-input" id="searchZipCode">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">详细地址</label>
                    <input type="text" class="search-form-input" id="searchAddress">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">职业</label>
                    <input type="text" class="search-form-input" id="searchOccupation">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">收入水平</label>
                    <input type="text" class="search-form-input" id="searchIncome">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">会员级别</label>
                    <input type="text" class="search-form-input" id="searchRankMember">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">当前积分</label>
                    <input type="text" class="search-form-input" id="searchCurrentScore">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">账户余额</label>
                    <input type="text" class="search-form-input" id="searchBalance">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">加入日期</label>
                    <input type="text" class="search-form-input" id="searchJoinDate" placeholder="格式: YYYY-MM-DD">
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">状态</label>
                    <select class="search-form-input" id="searchStatus">
                        <option value="">全部</option>
                        <option value="正常">正常</option>
                        <option value="冻结">冻结</option>
                    </select>
                </div>
                <div class="search-form-group">
                    <label class="search-form-label">备注</label>
                    <input type="text" class="search-form-input" id="searchRemark">
                </div>
            </div>
        </div>
        <div class="search-modal-footer">
            <button class="btn" id="resetSearchBtn" style="background-color: #e2e8f0;">重置</button>
            <button class="btn btn-search" id="doSearchBtn" style="margin-left: 10px;">搜索</button>
        </div>
    </div>
</div>

<!-- 日志模态框 -->
<div id="logModal" class="search-modal">
    <div class="search-modal-content">
        <div class="search-modal-header">
            <div class="search-modal-title">操作日志</div>
            <span class="search-modal-close" id="closeLogModal">&times;</span>
        </div>
        <div class="search-modal-body">
            <div id="logList">
                <!-- 日志列表将通过JS动态生成 -->
                <!-- 展示：查找（结果回看），删除（撤回），冻结/解冻，备注 -->
            </div>
        </div>
        <div class="search-modal-footer">
            <button class="btn" id="clearLogsBtn" style="background-color: #e2e8f0;">清空日志</button>
        </div>
    </div>
</div>

<!-- 全选，删除功能相关 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 备注单元格点击事件 -->
<script>
    $('.remark-cell').click(function() {
        var cell = $(this);
        var textSpan = cell.find('.remark-text');
        var inputField = cell.find('.remark-input');
        var vipId = cell.data('vipid');
        var originalRemark = textSpan.text().trim();

        // 显示输入框，隐藏文本
        textSpan.hide();
        inputField.show().focus().val(originalRemark);

        // 输入框失去焦点时保存
        inputField.blur(function() {
            var newRemark = $(this).val().trim();

            if (newRemark !== originalRemark) {
                // 设置表单数据并提交
                $('#remarkVipId').val(vipId);
                $('#remarkContent').val(newRemark);
                $('#remarkForm').submit();
            }

            // 隐藏输入框，显示文本
            inputField.hide();
            textSpan.show();
        });

        // 按Enter键保存
        inputField.keypress(function(e) {
            if (e.which === 13) { // Enter键
                $(this).blur();
            }
        });
    });
</script>

<!--全选复选框事件-->
<script>
    $('#selectAll').change(function() {
        $('input[name="batchSelect"]').prop('checked', $(this).is(':checked'));
    });

    $('#batchOperationBtn').click(function() {
        /*// 切换复选框的显示状态
        $('.batch-checkbox').toggle();*/
        /*// 切换删除按钮的显示状态
        $('#batchDeleteBtn').toggle();*/

        // 如果复选框显示，则选中全选复选框
        if ($('.batch-checkbox').is(':visible')) {
            $('#selectAll').prop('checked', true);
            $('input[name="batchSelect"]').prop('checked', true);
        } else {
            $('#selectAll').prop('checked', false);
            $('input[name="batchSelect"]').prop('checked', false);
        }
    });
</script>

<script src="${pageContext.request.contextPath}/js/OperationLog.js"></script>
<script src="${pageContext.request.contextPath}/js/SearchVip.js"></script>
<script src="${pageContext.request.contextPath}/js/deleteVip.js"></script>

</body>
</html>