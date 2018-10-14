package com.hua.service;

import com.hua.dao.PermissionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hua.entity.Permission;


import java.util.List;

@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    PermissionDao permissionDao;

    public List<com.hua.entity.Permission> queryPermission(Integer pid) {
        return permissionDao.queryPermission(pid) ;
    }

    public List<com.hua.entity.Permission> queryAllPermission() {
        return permissionDao.queryAllPermission();
    }

    public void addNode(com.hua.entity.Permission permission) {
        permissionDao.insertPermission(permission);
    }

    public Permission queryAPermission(Integer id) {
        return permissionDao.queryAPermission(id) ;
    }

    public void updatePermission(Permission permission) {
        permissionDao.updatePermission(permission);
    }

    public void deletePermission(Integer id) {
        permissionDao.deletePermission(id);
    }

    public List<Permission> queryPermissionByUser(Integer id) {
        return permissionDao.queryPermissionByUser(id);
    }

}
