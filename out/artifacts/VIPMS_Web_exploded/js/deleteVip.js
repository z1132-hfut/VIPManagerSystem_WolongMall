/*$(document).ready(function() {
    // 绑定删除按钮点击事件
    $('#batchDeleteBtn').click(function() {
        // 获取所有选中的会员ID
        var selectedIds = [];
        $('tr').each(function() {
            var checkbox = $(this).find('input[name="batchSelect"]');
            if (checkbox.is(':checked')) {
                var vipId = $(this).find('td:eq(1)').text(); // 获取会员ID（第二列）
                selectedIds.push(vipId);
            }
        });

        if (selectedIds.length === 0) {
            alert('请至少选择一条记录进行删除');
            return false; // 阻止表单提交
        }

        if (confirm('确定要删除选中的 ' + selectedIds.length + ' 条记录吗？')) {

            // 设置要删除的会员ID
            $('#batchDeleteVipIds').val(selectedIds.join(','));
            // 提交表单
            $('#batchDeleteForm').submit();
        }
        return false; // 阻止默认行为
    });
});*/

$(document).ready(function() {
    // 绑定删除按钮点击事件
    $('#batchDeleteBtn').click(function() {
        // 获取所有选中的会员ID和会员名
        var selectedIds = [];
        var selectedNames = [];
        $('tr').each(function() {
            var checkbox = $(this).find('input[name="batchSelect"]');
            if (checkbox.is(':checked')) {
                var vipId = $(this).find('td:eq(1)').text(); // 获取会员ID（第二列）
                var vipName = $(this).find('td:eq(3)').text(); // 获取会员名（第四列）
                selectedIds.push(vipId);
                selectedNames.push(vipName);
            }
        });

        if (selectedIds.length === 0) {
            alert('请至少选择一条记录进行删除');
            return false; // 阻止表单提交
        }

        if (confirm('确定要删除选中的 ' + selectedIds.length + ' 条记录吗？')) {
            // 添加删除日志
            addLog('delete', {
                vipId: selectedIds.join(','),
                vipName: selectedNames.length > 1 ? selectedNames : selectedNames[0]
            });

            // 设置要删除的会员ID
            $('#batchDeleteVipIds').val(selectedIds.join(','));
            // 提交表单
            $('#batchDeleteForm').submit();
        }
        return false; // 阻止默认行为
    });
});
