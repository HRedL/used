package com.hua.controller;


import com.hua.entity.AJAXResult;
import com.hua.entity.Permission;
import com.hua.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("permission")
public class PermissionController {

    @Autowired
    PermissionService permissionService;

    @ResponseBody
    @RequestMapping("deletePermission")
    public AJAXResult deletePermission(Integer id){
        AJAXResult result=new AJAXResult();

        try{
            permissionService.deletePermission(id);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    @ResponseBody
    @RequestMapping("updatePermission")
    public AJAXResult updatePermission(Permission permission){
        AJAXResult result=new AJAXResult();
        try{
            permissionService.updatePermission(permission);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("queryPermission")
    public AJAXResult queryPermission(Integer id){
        AJAXResult result=new AJAXResult();

        try{
            Permission permission= permissionService.queryAPermission(id);


            result.setData(permission);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();

            result.setSuccess(false);
        }

        return result;


    }

    @ResponseBody
    @RequestMapping("addNode")
    public AJAXResult addNode(Permission permission){
        AJAXResult result=new AJAXResult();
        try{
            permissionService.addNode(permission);
            result.setSuccess(true);
        }catch (Exception e){

            e.printStackTrace();
            result.setSuccess(false);
        }



        return result;
    }

    @RequestMapping("permissionMain")
    public String permissionMain(){

        return "permission/permissionMain";
    }

    @ResponseBody
    @RequestMapping("loadData")
    public Object loadData() {
        /*
        这个东西是调用下面的递归方法来实现的
        Permission permission=new Permission();
        permission.setId(0);
        addPermission(permission);
        return permission.getChildren();
        */
        Permission permission=new Permission();
        List<Permission> permissions=permissionService.queryAllPermission();
        Map<Integer,Permission> map=new HashMap<Integer, Permission>();
        for(Permission p:permissions){
            map.put(p.getId(),p);
        }
        for (Permission child:permissions){
            if(child.getPid()==0){
                permission.getChildren().add(child);
            }else{
                Permission parent=map.get(child.getPid());
                parent.getChildren().add(child);
            }
        }
        return permission.getChildren();
    }

    /**
     * 递归方法生成一个List
     * 这种方式逻辑清晰，但是，，，它多次调用数据库，所以说不怎么好
     */
    public void addPermission(Permission parent){
        List<Permission> children=permissionService.queryPermission(parent.getId());
        for(Permission child:children){
            addPermission(child);
        }
        parent.setChildren(children);
    }
}


