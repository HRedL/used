package com.hua.controller;


import com.github.pagehelper.PageHelper;
import com.hua.entity.AJAXResult;
import com.hua.entity.Page;
import com.hua.entity.Role;
import com.hua.entity.User;
import com.hua.service.RoleService;
import com.hua.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.xml.transform.Result;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @ResponseBody
    @RequestMapping("doAssign")
    public AJAXResult doAssign(Integer id,Integer[] unassignRoleIds){
        AJAXResult result=new AJAXResult();


        try{
            Map<String,Object> map=new HashMap<String, Object>();
            map.put("userId",id);
            map.put("roleIds",unassignRoleIds);
            userService.insertUserRoles(map);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }


    @ResponseBody
    @RequestMapping("doUnassign")
    public AJAXResult doUnassign(Integer id,Integer[] assignRoleIds){
        AJAXResult result=new AJAXResult();

        try{

            Map<String,Object> map=new HashMap<String, Object>();
            map.put("userId",id);
            map.put("roleIds",assignRoleIds);
            userService.deleteUserRoles(map);

            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }


    @ResponseBody
    @RequestMapping("query4AssignRole")
    public AJAXResult query4AssignRole(Integer userId){
        AJAXResult result=new AJAXResult();
        try{
            List<Role> roles =roleService.queryAllRole();
            List<Role> unassignedRole=new ArrayList<Role>();
            List<Role> assignedRole=new ArrayList<Role>();
            List<Integer> roleIds= roleService.queryAssignedRoleId(userId);

            for(Role role:roles){
                if(roleIds.contains(role.getId())){
                    assignedRole.add(role);
                }else{
                    unassignedRole.add(role);
                }
            }
            Map<String,Object> map=new HashMap<String, Object>();
            map.put("unassignedRole",unassignedRole);
            map.put("assignedRole",assignedRole);
            result.setData(map);
            result.setSuccess(true);
        }catch(Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    @ResponseBody
    @RequestMapping("deleteUsers")
    public AJAXResult deleteUsers(Integer[] userid){
        AJAXResult result=new AJAXResult();
        try{
            Map<String,Object> map=new HashMap<String, Object>();
            map.put("userIds",userid);
            userService.deleteUsers(map);

            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }



    @ResponseBody
    @RequestMapping("deleteUser")
    public AJAXResult deleteUser(Integer id){
        AJAXResult result=new AJAXResult();
        try{
            userService.deleteUser(id);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    @ResponseBody
    @RequestMapping("updateUser")
    public AJAXResult updateUser(User user){
        AJAXResult result=new AJAXResult();

        userService.updateUser(user);

        result.setSuccess(true);
        return result;
    }


    @ResponseBody
    @RequestMapping("usernameValidate")
    public AJAXResult usernameValidate(User user){
        AJAXResult result=new AJAXResult();
        Boolean flag=userService.query4Validate(user);
        if(flag==true){
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }


    @ResponseBody
    @RequestMapping("addUser")
    public AJAXResult addUser(User user){
        AJAXResult ajaxResult=new AJAXResult();
        //因为此处是管理员新增的一个新用户，所以说不用管理员给他设置密码，密码统一为账户名称
        user.setPassword(user.getAccount());
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd:HH:mm:ss");
        String date=simpleDateFormat.format(new Date());
        user.setCreateTime(date);
        userService.addUser(user);

        ajaxResult.setSuccess(true);
        return ajaxResult;
    }

    @RequestMapping("userMain")
    public String userMain(){

        return "user/userMain";
    }

    @ResponseBody
    @RequestMapping("pageQuery")
    public AJAXResult pageQuery(Integer pageNumber,Integer pageSize,String queryText){

        AJAXResult result=new AJAXResult();

        try{

            Map<String ,Object> map=new HashMap();
            map.put("start",(pageNumber-1)*pageSize);
            map.put("pageSize",pageSize);
            map.put("queryText",queryText);

            List<User> users= userService.pageQueryUser(map);
            //当前的数据条数
            int totalSize=userService.pageQueryCount(map);
            //当前总页码
            int totalNumber=0;
            //如果正好整除，总页码=总记录/每页记录数,不正好，那么，总页码=总记录/每页记录数+1
            if(totalSize%pageSize==0){
                totalNumber=totalSize/pageSize;
            }else {
                totalNumber=totalSize/pageSize+1;
            }



            //分页对象
            Page<User> userPage=new Page<User>();
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

    /*这是一开始的想法，因为这个在跳转页面的时候会先处理查询语句，如果中间卡了，页面不先出来，所以说应该使得页面的加载和代码的执行
    分隔开，也就是直接进行跳转页面，然后发送ajax请求来跳转到每一页
    @RequestMapping("userMain")
    public String userMain(@RequestParam(required = false,defaultValue = "1") Integer pageNumber,@RequestParam(required = false,defaultValue = "2") Integer pageSize, Model model){
        //因为在数据库中使用的是limit start,size，所以说，这里的页码不对应start，所以需要转换一下
        Map<String ,Object> map=new HashMap();
        map.put("start",(pageNumber-1)*pageSize);
        map.put("pageSize",pageSize);
        List<User> users= userService.pageQueryUser(map);
        model.addAttribute("users",users);
        //当前页码
        model.addAttribute("pageNumber",pageNumber);
        //当前的数据条数
        int totalSize=userService.pageQueryCount();
        //当前总页码
        int totalNumber=0;
        //如果正好整除，总页码=总记录/每页记录数,不正好，那么，总页码=总记录/每页记录数+1
        if(totalSize%pageSize==0){
            totalNumber=totalSize/pageSize;
        }else {
            totalNumber=totalSize/pageSize+1;
        }
        //将当前总页码传入
        model.addAttribute("totalNumber",totalNumber);

        return "user/userMain";
    }
    */


}
