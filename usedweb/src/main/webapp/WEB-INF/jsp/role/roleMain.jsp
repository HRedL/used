<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="GB18030">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/tools/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/tools/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/tools/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/tools/ztree/zTreeStyle.css">
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

<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">分配许可</h4>
            </div>
            <div class="modal-body">
                <ul id="permissionTree" class="ztree"></ul>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="assign_modal_yes_btn">确认</button>
            </div>
        </div>
    </div>
</div>


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
                                <input class="form-control has-success" id="query_role_input" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" id="query_role_btn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='form.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody id="roleData">

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
<script src="${APP_PATH}/tools/ztree/jquery.ztree.all-3.5.min.js"></script>
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
        pageQuery(1);

        $("#query_role_btn").click(function () {
            var queryText=$("#query_role_input").val();
            if(queryText==""){
                likeflag=false;
            }else {
                likeflag=true;
            }
            pageQuery(1);
        });
    });


    function pageQuery(pageNumber) {
        var loadingIndex=null;

        var jsonData={
            "pageNumber":pageNumber,
            "pageSize":2
        };
        if(likeflag==true){
            jsonData.queryText=$("#query_role_input").val();
        }

        $.ajax({
            type:"post",
            url:"${APP_PATH}/role/pageQuery",
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
                    var rolePage=result.data;
                    var roles=rolePage.datas;
                    $.each(roles,function(i,role) {
                        tbodyInf+='<tr>';
                        tbodyInf+='<td>'+(i+1)+'</td>';
                        tbodyInf+='<td><input type="checkbox" name="roleid" value="'+role.id+'"/></td>';
                        tbodyInf+='<td>'+role.name+'</td>';
                        tbodyInf+='<td>';
                        tbodyInf+='<button type="button" onclick="assign('+role.id+')" class="btn btn-success btn-xs add_role_btn"><i class=" glyphicon glyphicon-check"></i></button>';
                        tbodyInf+='<button type="button" idClass= "'+role.id+'" pageNumber="'+pageNumber+'" class="btn btn-primary btn-xs update_btn"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tbodyInf+='<button type="button" class="btn btn-danger btn-xs delete_btn"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tbodyInf+='</td>';
                        tbodyInf+='</tr>';
                    });
                    if(pageNumber>1){
                        pageInf+='<li><a href="#" onclick="pageQuery('+(pageNumber-1)+')">上一页</a></li>';
                    }

                    $.each(rolePage.showNumber,function (index,item) {
                        if(item==pageNumber){
                            pageInf+='<li class="active"><a href="#">'+item+'</a></li>';
                        }else {
                            pageInf+='<li><a href="#" onclick="pageQuery('+ item +')">'+item+'</a></li>';
                        }
                    });



                    var number=Number(pageNumber)+1;
                    if(pageNumber<rolePage.totalNumber){
                        pageInf+='<li><a href="#" onclick="pageQuery('+(number)+')">下一页</a></li>';
                    }
                    $("#roleData").html(tbodyInf);
                    $("#pageInf").html(pageInf);

                }else{
                    layer.msg('分页查询失败',{time:3000,icon:5,shift:6},function () {});
                }
            }
        });


    }

    function assign(id) {
        $("#assignModal").modal('show');
        $("#assign_modal_yes_btn").attr("idClass",id);
    }

    $(document).ready(function(){
        var setting = {
            check:{
                enable:true
            },
            view: {
                //是否开启多选
                selectedMulti: false,
                //这是增加diy的，，，什么玩意，就是加图标的
                addDiyDom: function(treeId, treeNode){
                    //这是获取当前子节点
                    var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                    //这是判断如果图标存在，那么久移除默认样式，加上对应的图标
                    if ( treeNode.icon ) {
                        icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
                    }
                }
            },
            async: {
                enable: true,
                url:"${APP_PATH}/permission/loadData",
                autoParam:["id", "name=n", "level=lv"]
            }
        };

        $.fn.zTree.init($("#permissionTree"), setting);
    });

    $("#assign_modal_yes_btn").click(function () {
       var treeObj=$.fn.zTree.getZTreeObj("permissionTree");
       var nodes=treeObj.getCheckedNodes(true);
       if(nodes.length==0){
           layer.msg("请选择许可",{time:3000,icon:5,shift:6},function(){});
       }else{
           var roleId=$("#assign_modal_yes_btn").attr("idClass");
           var d="roleId="+roleId;
           $.each(nodes,function (i,node) {
               d+="&permissionIds="+node.id;
           })

           $.ajax({
               url:"${APP_PATH}/role/doAssign",
               type:"post",
               data:d,
               success:function (result) {
                   if(result.success){
                       $("#assignModal").modal('hide');
                   }else{
                       layer.msg("分配许可信息失败",{time:3000,icon:5,shift:6},function(){});
                   }
               }
           });
       }
    });

</script>
</body>
</html>

