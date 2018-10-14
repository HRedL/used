package com.hua.controller;

import com.hua.entity.AJAXResult;
import com.hua.entity.Page;
import com.hua.entity.Role;
import com.hua.entity.User;
import com.hua.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("role")
public class RoleController {

    @Autowired
    RoleService roleService;

    @ResponseBody
    @RequestMapping("doAssign")
    public AJAXResult doAssign(Integer roleId,Integer[] permissionIds){
        AJAXResult result=new AJAXResult();
        try{
            Map<String,Object> map=new HashMap<String, Object>();
            map.put("roleId",roleId);
            map.put("permissionIds",permissionIds);
            roleService.insertRolePermission(map);

            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("roleMain")
    public String userMain(){

        return "role/roleMain";
    }

    @RequestMapping("assign")
    public String assign(Integer id){


        return "role/Assign";
    }


    @ResponseBody
    @RequestMapping("pageQuery")
    public AJAXResult pageQuery(Integer pageNumber, Integer pageSize, String queryText){

        AJAXResult result=new AJAXResult();

        try{

            Map<String ,Object> map=new HashMap();
            map.put("start",(pageNumber-1)*pageSize);
            map.put("pageSize",pageSize);
            map.put("queryText",queryText);

            List<Role> users= roleService.pageQueryRole(map);
            //当前的数据条数
            int totalSize=roleService.pageQueryCount(map);
            //当前总页码
            int totalNumber=0;
            //如果正好整除，总页码=总记录/每页记录数,不正好，那么，总页码=总记录/每页记录数+1
            if(totalSize%pageSize==0){
                totalNumber=totalSize/pageSize;
            }else {
                totalNumber=totalSize/pageSize+1;
            }
            //分页对象
            Page<Role> userPage=new Page<Role>();
            userPage.setDatas(users);
            userPage.setTotalNumber(totalNumber);
            userPage.setTotalSize(totalSize);
            userPage.setPageNumber(pageNumber);

            if(totalNumber==1){
                userPage.setShowNumber(Arrays.asList(1));
            }else if(totalNumber==2){
                userPage.setShowNumber(Arrays.asList(1,2));
            }else if(totalNumber==3){
                userPage.setShowNumber(Arrays.asList(1,2,3));
            }else if(totalNumber==4){
                userPage.setShowNumber(Arrays.asList(1,2,3,4));
            }else if(pageNumber<=3){
                userPage.setShowNumber(Arrays.asList(1,2,3,4,5));
            }else if(pageNumber+3>totalNumber){
                List<Integer> list=new ArrayList<Integer>();
                list.add(totalNumber-4);
                list.add(totalNumber-3);
                list.add(totalNumber-2);
                list.add(totalNumber-1);
                list.add(totalNumber);
                userPage.setShowNumber(list);
            }else{
                List<Integer> list=new ArrayList<Integer>();
                list.add(pageNumber-2);
                list.add(pageNumber-1);
                list.add(pageNumber);
                list.add(pageNumber+1);
                list.add(pageNumber+2);
                userPage.setShowNumber(list);
            }
            result.setData(userPage);
            result.setSuccess(true);


        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }
}
