package com.hua.web;

import com.github.pagehelper.util.StringUtil;
import com.hua.entity.Permission;
import com.hua.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 此处换一个，，学习一下，使用适配器（有印象，在编程思想里肯定有）
 *权限拦截器
 * 即当某个用户没有对应权限就算使用链接的方式也过不去
 */
public class AuthorityInteceptor extends HandlerInterceptorAdapter {

    @Autowired
    private PermissionService permissionService;
    //快速重写父类方法的快捷键ctrl+o
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取用户请求地址
        String uri=request.getRequestURI();
        //判断当前路径是否需要进行验证
        //查询所有需要验证的集合
        List<Permission> permissions=permissionService.queryAllPermission();
        //此处用set的原因是，希望不要重复
        Set<String> uriSet=new HashSet<String>();
        for(Permission permission:permissions){
            if(StringUtil.isNotEmpty(uri)){
                uriSet.add(request.getContextPath()+ permission.getUrl());
            }
        }
        //判断是当前uri是否跟权限有关，如果有关则拦下来判断，若无关则放行
        if(uriSet.contains(uri)){
            //权限验证
            //判断当前用户是否拥有对应的权限
            Set<String> authUriSet=(Set<String>)request.getSession().getAttribute("authUriSet");
            if(authUriSet.contains(uri)){
                return true;
            }else{
                response.sendRedirect(request.getContextPath()+"/error");
                return false;
            }
        }else{
            return true;
        }

    }
}
