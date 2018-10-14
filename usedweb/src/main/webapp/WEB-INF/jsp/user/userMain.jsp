<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/tools/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/tools/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/tools/css/main.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<%--给用户添加角色信息按钮的模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="add_role_modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">UPDATE</h4>
            </div>
            <div class="modal-body">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form id="add_role_form" role="form" class="form-inline">
                                <input type="hidden" id="add_role_id" name="id"/>

                                <div class="form-group">
                                    <label>未分配角色列表</label><br>
                                    <select id="left_select" name="unassignRoleIds" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">

                                    </select>
                                </div>
                                <div class="form-group">
                                    <ul>
                                        <li id="left2right_btn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                        <br>
                                        <li id="right2left_btn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                                    </ul>
                                </div>
                                <div class="form-group" style="margin-left:40px;">
                                    <label>已分配角色列表</label><br>
                                    <select id="right_select" name="assignRoleIds" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">

                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="add_role_modal_close_btn">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%--修改按钮的模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="update_modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">UPDATE</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="update_modal_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">UserName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_modal_username_input" placeholder="UserName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Account</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_modal_account_input" placeholder="Account">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_modal_email_input" placeholder="Email">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="update_modal_reset_btn">重置</button>
                <button type="button" class="btn btn-primary" id="update_modal_update_btn">修改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%--新增按钮的模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="add_modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Modal title</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add_modal_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">UserName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_modal_username_input" placeholder="UserName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Account</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_modal_account_input" placeholder="Account">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_modal_email_input" placeholder="Email">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="add_modal_reset_btn">重置</button>
                <button type="button" class="btn btn-primary" id="add_modal_add_btn">新增</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%@include file="/WEB-INF/jsp/common/title.jsp"%>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <%@ include file="/WEB-INF/jsp/common/menu.jsp"%>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" type="text" id="query_user_input" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" id="query_user_btn"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" id="delete_users_btn"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" id="add_user_btn"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <form id="user_form">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" id="check_all_user"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>

                            <tbody id="userData">
                            </tbody>

                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul id="pageInf" class="pagination">

                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/tools/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/tools/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/tools/script/docs.min.js"></script>
<script src="${APP_PATH}/tools/layer/layer.js"></script>
<script type="text/javascript">
    var likeflag=false;
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });

        //在文档加载完成之后，进入第一页
        pageQuery(1);
        $("#query_user_btn").click(function () {
            var queryText=$("#query_user_input").val();
            if(queryText==""){
                likeflag=false;
            }else {
                likeflag=true;
            }
            pageQuery(1);
        });

        //当新增按钮被点击时，弹出模态框
        $("#add_user_btn").click(function () {
            $("#add_modal").modal('show');
        });
    });
    $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    });

    //为模态框里面的新增按钮添加点击事件
    $("#add_modal_add_btn").click(function(){
        //准备好数据
        var userName=$("#add_modal_username_input").val();
        var userAccount=$("#add_modal_account_input").val();
        var userEmail=$("#add_modal_email_input").val();
        //当新增按钮被点击时，验证用户信息是否输入正确
        $.ajax({
            type:"post",
            url:"${APP_PATH}/user/usernameValidate",
            data:{
                username:userName,
                account:userAccount
            },
            success:function (result) {
                if(result.success==true){
                    $.ajax({
                        url:"${APP_PATH}/user/addUser",
                        type:"post",
                        data:{
                            username:userName,
                            account:userAccount,
                            email:userEmail
                        },
                        beforeSend:function () {
                            loadingIndex=layer.msg('处理中',{icon:16});
                        },
                        success:function () {
                            //只要请求发送成功，就取消加载的效果
                            layer.close(loadingIndex);
                            //关闭模态框,坑啊，关闭竟然是hide，不是close，好吧，，确实应该是hide
                            $("#add_modal").modal('hide');
                            pageQuery(1);
                        }
                    });
                }else{
                    layer.msg('用户名或者用户账号重复，请重新输入',{time:3000,icon:5,shift:6},function () {});
                }
            }
        });
    });

    //为新增模态框里面的重置按钮添加点击事件
    $("#add_modal_reset_btn").click(function () {
        $("#add_modal_form")[0].reset();
    });


    <%--function changePageNumber(pageNumber){--%>
        <%--window.location.href="${APP_PATH}/user/userMain?pageNumber="+pageNumber;--%>
    <%--}--%>


    //翻页
    function pageQuery(pageNumber) {
        var loadingIndex=null;

        var jsonData={
            "pageNumber":pageNumber,
            "pageSize":2
        };
        if(likeflag==true){
            jsonData.queryText=$("#query_user_input").val();
        }

        $.ajax({
            type:"post",
            url:"${APP_PATH}/user/pageQuery",
            data:jsonData,
            beforeSend: function () {
                loadingIndex=layer.msg('处理中',{icon:16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    //局部刷新页面数据（即将页面信息补充完整）
                    var tbodyInf="";
                    var pageInf="";
                    var userPage=result.data;
                    var users=userPage.datas;
                    $.each(users,function (i,user) {
                       tbodyInf+='<tr>';
                       tbodyInf+='<td>'+(i+1)+'</td>';
                        tbodyInf+='<td><input type="checkbox" name="userid" value="'+user.id+'"/></td>';
                       tbodyInf+='<td>'+user.account+'</td>';
                       tbodyInf+='<td>'+user.username+'</td>';
                       tbodyInf+='<td>'+user.email+'</td>';
                       tbodyInf+='<td>';
                       tbodyInf+='<button type="button" idClass="'+user.id+'" class="btn btn-success btn-xs add_role_btn"><i class=" glyphicon glyphicon-check"></i></button>';
                       tbodyInf+='<button type="button" idClass= "'+user.id+'" pageNumber="'+pageNumber+'" class="btn btn-primary btn-xs update_btn"><i class=" glyphicon glyphicon-pencil"></i></button>';
                       tbodyInf+='<button type="button" class="btn btn-danger btn-xs delete_btn"><i class=" glyphicon glyphicon-remove"></i></button>';
                       tbodyInf+='</td>';
                       tbodyInf+='</tr>';
                    });
                    if(pageNumber>1){
                        pageInf+='<li><a href="#" onclick="pageQuery('+(pageNumber-1)+')">上一页</a></li>';
                    }

                    $.each(userPage.showNumber,function (index,item) {
                        if(item==pageNumber){
                            pageInf+='<li class="active"><a href="#">'+item+'</a></li>';
                        }else {
                            pageInf+='<li><a href="#" onclick="pageQuery('+ item +')">'+item+'</a></li>';
                        }
                    });



                    var number=Number(pageNumber)+1;
                    if(pageNumber<userPage.totalNumber){
                        pageInf+='<li><a href="#" onclick="pageQuery('+(number)+')">下一页</a></li>';
                    }
                    $("#userData").html(tbodyInf);
                    $("#pageInf").html(pageInf);

                }else{
                    layer.msg('分页查询失败',{time:3000,icon:5,shift:6},function () {});
                }
            }

        });

    }

    //给页面上的更新按钮的点击事件
    $(document).on("click",".update_btn",function (){
       $("#update_modal").modal('show');
        var userId= $(this).attr("idClass");
        var pageNumber=$(this).attr("pageNumber");
        var userAccount=$(this).parents("tr").find("td:eq(2)").text();
        var userName=$(this).parents("tr").find("td:eq(3)").text();
        var userEmail=$(this).parents("tr").find("td:eq(4)").text();
        $("#update_modal_account_input").val(userAccount);
        $("#update_modal_username_input").val(userName);
        $("#update_modal_email_input").val(userEmail);
        $("#update_modal_update_btn").attr("idClass",userId);
        $("#update_modal_update_btn").attr("pageNumber",pageNumber);

    });
    
    //给修改模态框的新增按钮按钮添加点击事件
    $("#update_modal_update_btn").click(function () {
        var userId=$("#update_modal_update_btn").attr("idClass");
        var userAccount=$("#update_modal_account_input").val();
        var userName=$("#update_modal_username_input").val();
        var userEmail=$("#update_modal_email_input").val();
        var pageNumber=$("#update_modal_update_btn").attr("pageNumber");
        $.ajax({
            type:"post",
            url:"${APP_PATH}/user/usernameValidate",
            data:{
                username:userName,
                account:userAccount
            },
            success:function (result) {
                if(result.success==true){
                    $.ajax({
                        url:"${APP_PATH}/user/updateUser",
                        type:"post",
                        data:{
                            id:userId,
                            username:userName,
                            account:userAccount,
                            email:userEmail
                        },
                        beforeSend:function () {
                            loadingIndex=layer.msg('处理中',{icon:16});
                        },
                        success:function () {
                            //只要请求发送成功，就取消加载的效果
                            layer.close(loadingIndex);
                            //关闭模态框,坑啊，关闭竟然是hide，不是close，好吧，，确实应该是hide
                            $("#update_modal").modal('hide');
                            pageQuery(pageNumber);
                        }
                    });
                }else{
                    layer.msg('用户名或者用户账号重复，请重新输入',{time:3000,icon:5,shift:6},function () {});
                }
            }
        });
    });

    //给修改模态框里面的重置按钮添加点击事件
    $("#update_modal_reset_btn").click(function () {
        $("#update_modal_form")[0].reset();
    });

    //给页面上的删除按钮添加点击事件
    $(document).on("click",".delete_btn",function () {
        var userId= $(this).parent("td").find("button:eq(1)").attr("idClass");
        var pageNumber=$(this).parent("td").find("button:eq(1)").attr("pageNumber");
        var userName=$(this).parents("tr").find("td:eq(3)").text();
        layer.confirm("删除用户【"+userName+"】信息,是否继续",{icon:3,title:"提示"},function (cindex) {
            $.ajax({
               url:"${APP_PATH}/user/deleteUser",
               type:"post",
               data:{
                 id:userId
               },
                success:function (result) {
                   if(result.success){
                       layer.close(cindex);
                       pageQuery(pageNumber);
                   }else{
                       layer.msg('用户信息删除失败',{time:3000,icon:5,shift:6},function () {});
                   }
                }
            });
        }),function (cindex) {
            layer.close(cindex);
        }
    });

    //给页面上的添加角色的按钮添加点击事件
    $(document).on("click",".add_role_btn",function () {
        var userId=$(this).attr("idClass");
        $("#add_role_id").val(userId);
        $.ajax({
            url:"${APP_PATH}/user/query4AssignRole",
            type:"post",
            data:{
                userId:userId
            },
            success:function (result) {
                if(result.success){
                    var leftSelect="";
                    var rightSelect="";
                    var unassignedRole=result.data.unassignedRole;
                    var assignedRole=result.data.assignedRole;
                    $.each(unassignedRole,function (index,item) {
                        leftSelect+='<option value="'+item.id+'">'+item.name+'</option>';
                    });
                    $.each(assignedRole,function (index,item) {
                        rightSelect+='<option value="'+item.id+'">'+item.name+'</option>';
                    });

                    $("#left_select").html(leftSelect);
                    $("#right_select").html(rightSelect);
                    $("#add_role_modal").modal('show');
                }else{
                    layer.msg('角色查询失败',{time:3000,icon:5,shift:6},function () {});
                }
            }
        });
    });

    $("#left2right_btn").click(function () {
        var opts=$("#left_select :selected");
        if(opts.length==0){
            layer.msg('请选择角色信息',{time:3000,icon:5,shift:6},function () {});
        }else{
            $.ajax({
                url:"${APP_PATH}/user/doAssign",
                type:"post",
                data:$("#add_role_form").serialize(),
                success:function (result) {
                    if(result.success){
                        $("#right_select").append(opts);
                    }else{
                        layer.msg('角色分配失败',{time:3000,icon:5,shift:6},function () {});
                    }
                }
            });
        }
    });

    $("#right2left_btn").click(function () {
        var opts=$("#right_select :selected");
        if(opts.length==0){
            layer.msg('请选择角色信息',{time:3000,icon:5,shift:6},function () {});
        }else{
            $.ajax({
                url:"${APP_PATH}/user/doUnassign",
                type:"post",
                data:$("#add_role_form").serialize(),
                success:function (result) {
                    if(result.success){
                        $("#left_select").append(opts);
                    }else{
                        layer.msg('角色取消分配失败',{time:3000,icon:5,shift:6},function () {});
                    }
                }
            });
        }
    });

    $("#add_role_modal_close_btn").click(function () {
        $("#add_role_modal").modal('hide');
    })

    //给全选多选框添加点击事件
    $("#check_all_user").click(function(){
        var flag=this.checked;
        $("#userData :checkbox").each(function () {
            this.checked=flag;
        });
    });

    //给页面的删除多个用户的按钮添加点击事件
    $("#delete_users_btn").click(function () {
        var checkboxs=$("#userData :checkbox");
        if(checkboxs==0){
            layer.msg('请选择删除的用户',{time:3000,icon:5,shift:6},function () {});
        }else{
            layer.confirm("删除已选择的用户信息,是否继续",{icon:3,title:"提示"},function (cindex) {
                $.ajax({
                    url:"${APP_PATH}/user/deleteUsers",
                    type:"post",
                    data:$("#user_form").serialize(),
                    success:function (result) {
                        if(result.success){
                            layer.close(cindex);
                            pageQuery(1);
                        }else{
                            layer.msg('用户信息删除失败',{time:3000,icon:5,shift:6},function () {});
                        }
                    }
                });
            }),function (cindex) {
                layer.close(cindex);
            }
        }
    });


</script>
</body>
</html>

