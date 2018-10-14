package com.hua.service;

import com.hua.entity.Permission;

import java.util.List;

public interface PermissionService {


    public List<Permission> queryPermission(Integer pid);

    List<Permission> queryAllPermission();

    void addNode(Permission permission);

    Permission queryAPermission(Integer id);

    void updatePermission(Permission permission);

    void deletePermission(Integer id);

    List<Permission> queryPermissionByUser(Integer id);
}
