package com.hua.controller;


import com.github.pagehelper.util.StringUtil;
import com.hua.entity.AJAXResult;
import com.hua.entity.Permission;
import com.hua.entity.User;
import com.hua.service.PermissionService;
import com.hua.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class DispatcherController {

    @Autowired
    UserService userService;

    @Autowired
    PermissionService permissionService;


    @RequestMapping("/error")
    public String error(){
        return "error";
    }


    /**
     * 跳转到登录页面
     * @return
     */
    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession httpSession){
        httpSession.invalidate();
        return "redirect:login";
    }

    /**
     * 处理登录页面上的ajax请求,并且把查询出来的user存入到session域中
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping("/ajaxLogin")
    public AJAXResult doAjaxLogin(User user,HttpSession session){

        AJAXResult result=new AJAXResult();
        User dbUser=userService.query4Login(user);
        if(dbUser!=null){
            session.setAttribute("userInf",dbUser);

            //获取用户权限信息
            List<Permission> permissions= permissionService.queryPermissionByUser(dbUser.getId());
            Map<Integer,Permission> map=new HashMap<Integer, Permission>();

            Permission root=null;
            Set<String> uriSet=new HashSet<String>();
            //先把所有的东西都存到这里面，方便下面的孩子找父母
            for(Permission permission:permissions){
                map.put(permission.getId(),permission);
                //得到当前用户所有有权限的uri，以方便拦截
                if(StringUtil.isNotEmpty(permission.getUrl())){
                    uriSet.add(session.getServletContext().getContextPath()+permission.getUrl());
                }
            }
            session.setAttribute("authUriSet",uriSet);
            //给每一个以child都弄上一个父母
            for(Permission permission:permissions){
                Permission child=permission;
                if(child.getPid()==0){
                    root=permission;
                }else{
                    Permission parent=map.get(child.getPid());
                    parent.getChildren().add(child);
                }
            }
            session.setAttribute("rootPermission",root);
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 跳转到主界面
     * @return
     */
    @RequestMapping("/main")
    public String toMain(){
        return "main";
    }


    @RequestMapping("/dologin")
    public String dologin(User user,Model model){
        //1).获取表单数据

        //2).查询用户信息
        User dbUser=userService.query4Login(user);
        //3)判断用户信息是否存在
        if(dbUser!=null){
            //登录成功，跳转到主页面
            return "main";
        }else{
            //登陆失败，跳转回到登录页面，并且提示错误信息
            String errorMsg="登录账号或密码不正确，请重新输入";
            model.addAttribute("errorMsg",errorMsg);
            return "redirect:login";
        }

    }
}
