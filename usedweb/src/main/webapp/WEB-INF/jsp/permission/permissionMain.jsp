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
                        <label class="col-sm-2 control-label">PermissionName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_modal_permissionname_input" placeholder="PermissionName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Url</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_modal_url_input" placeholder="Url">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="update_modal_close_btn">关闭</button>
                <button type="button" class="btn btn-primary" id="update_modal_yes_btn">确认</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" tabindex="-1" role="dialog" id="add_modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">UPDATE</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add_modal_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">PermissionName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_modal_permissionname_input" placeholder="PermissionName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Url</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_modal_url_input" placeholder="Url">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="add_modal_close_btn">关闭</button>
                <button type="button" class="btn btn-primary" id="add_modal_yes_btn">确认</button>
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
                    <ul id="permissionTree" class="ztree"></ul>
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



    });

    $(document).ready(function(){
        var setting = {
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

                },
                addHoverDom: function(treeId, treeNode){
                    //   <a><span></span></a>
                    var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                    aObj.removeAttr("href");
                    if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                    var s = '<span id="btnGroup'+treeNode.tId+'">';
                    if ( treeNode.level == 0 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="addNode('+treeNode.id+')" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if ( treeNode.level == 1 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="updateNode('+treeNode.id+')"  style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        if (treeNode.children.length == 0) {
                            s += '<a class="btn btn-info dropdown-toggle btn-xs " onclick="deleteNode('+treeNode.id+')" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                        }
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="addNode('+treeNode.id+')" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if ( treeNode.level == 2 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="updateNode('+treeNode.id+')" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="deleteNode('+treeNode.id+')" style="margin-left:10px;padding-top:0px;" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }

                    s += '</span>';
                    aObj.after(s);
                },
                removeHoverDom: function(treeId, treeNode){
                    $("#btnGroup"+treeNode.tId).remove();
                }
            },
            async: {
                enable: true,
                url:"${APP_PATH}/permission/loadData",
                autoParam:["id", "name=n", "level=lv"]
            },
            callback: {
                onClick : function(event, treeId, json) {

                }
            }
        };

        $.fn.zTree.init($("#permissionTree"), setting);
    });

    function addNode(id) {
       $("#add_modal").modal('show');
       $("#add_modal_yes_btn").attr("idClass",id);
    }

    $("#add_modal_close_btn").click(function () {
        $("#add_modal").modal('hide');
    });

    $("#add_modal_yes_btn").click(function () {
        var id=$("#add_modal_yes_btn").attr("idClass");
        var permissionname=$("#add_modal_permissionname_input").val();
        var permissionurl=$("#add_modal_url_input").val();
        $.ajax({
            url:"${APP_PATH}/permission/addNode",
            type:"post",
            data:{
                name:permissionname,
                url:permissionurl,
                pid:id
            },
            success:function (result) {
                if(result){
                    $("#add_modal").modal('hide');
                    var treeObj=$.fn.zTree.getZTreeObj("permissionTree");
                    treeObj.reAsyncChildNodes(null,"refresh");
                }else{
                    layer.msg('许可信息保存失败',{time:3000,icon:5,shift:6},function () {});
                }
            }
        });
    });

    function updateNode(id) {
        $.ajax({
           url:"${APP_PATH}/permission/queryPermission",
           type:"post",
            data:{
               id:id
            },
            success:function(result){
               if(result.success){
                   $("#update_modal_url_input").val(result.data.url);
                   $("#update_modal_permissionname_input").val(result.data.name);
                   $("#update_modal_yes_btn").attr("idClass",id);
                   $("#update_modal").modal('show');
               }else{
                   layer.msg("许可查询失败",{time:3000,icon:5,shift:6},function(){});
               }
            }

        });
    }

    $("#update_modal_close_btn").click(function () {
        $("#update_modal_form").modal('hide');
    });

    $("#update_modal_yes_btn").click(function () {
        var id=$("#update_modal_yes_btn").attr("idClass");
        var name=$("#update_modal_permissionname_input").val();
        var url=$("#update_modal_url_input").val();
        $.ajax({
            url:"${APP_PATH}/permission/updatePermission",
            type:"post",
            data:{
                id:id,
                name:name,
                url:url
            },
            success:function (result) {
                if(result.success){
                    $("#update_modal").modal('hide');
                    var treeObj=$.fn.zTree.getZTreeObj("permissionTree");
                    treeObj.reAsyncChildNodes(null,"refresh");
                }else{
                    layer.msg("许可修改失败",{time:3000,icon:5,shift:6},function(){});
                }
            }
        })
    });




    function deleteNode(id) {
        layer.confirm("删除许可信息,是否继续",{icon:3,title:"提示"},function (cindex) {
            $.ajax({
                url:"${APP_PATH}/permission/deletePermission",
                type:"post",
                data:{
                    id:id
                },
                success:function (result) {
                    if(result.success){
                        layer.close(cindex);
                        //重新加载整个树
                        var treeObj=$.fn.zTree.getZTreeObj("permissionTree");
                        treeObj.reAsyncChildNodes(null,"refresh");

                    }else{
                        layer.msg('许可信息删除失败',{time:3000,icon:5,shift:6},function () {});
                    }
                }
            });
        }),function (cindex) {
            layer.close(cindex);
        }
    }
</script>
</body>
</html>

