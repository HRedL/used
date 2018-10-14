package com.hua.service;

import com.hua.entity.Role;
import com.hua.entity.User;

import java.util.List;
import java.util.Map;

public interface RoleService {
    public List<Role> queryAllRole();

    List<Integer> queryAssignedRoleId(Integer userId);


    public List<Role> pageQueryRole(Map<String,Object> map);


    public Integer pageQueryCount(Map<String,Object> map);


    void insertRolePermission(Map<String, Object> map);
}
