package com.hua.service;


import com.hua.dao.RoleDao;
import com.hua.dao.UserDao;
import com.hua.entity.Role;
import com.hua.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    RoleDao roleDao;


    public List<Role> queryAllRole() {

        return roleDao.queryAllRole();
    }

    public List<Integer> queryAssignedRoleId(Integer userId) {
        return roleDao.queryAssignedRoleId(userId);
    }

    public List<Role> pageQueryRole(Map<String, Object> map) {
        return roleDao.pageQueryRole(map);
    }

    public Integer pageQueryCount(Map<String,Object> map) {
        return roleDao.pageQueryCount(map);
    }

    public void insertRolePermission(Map<String, Object> map) {
        roleDao.deletePermission(map);
        roleDao.insertRolePermission(map);
    }


}
