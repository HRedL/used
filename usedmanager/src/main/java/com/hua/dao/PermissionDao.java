package com.hua.dao;

import com.hua.entity.Permission;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface PermissionDao {

    @Select("SELECT * FROM permission where pid=#{pid}")
    public List<Permission> queryPermission(Integer pid);

    @Select("SELECT * FROM permission")
    List<Permission> queryAllPermission();

    void insertPermission(Permission permission);


    @Select("SELECT * FROM permission where id=#{id}")
    Permission queryAPermission(Integer id);


    @Update("UPDATE permission SET name=#{name},url=#{url} where id=#{id}")
    void updatePermission(Permission permission);


    @Delete("DELETE FROM permission WHERE id=#{id}")
    void deletePermission(Integer id);

    List<Permission> queryPermissionByUser(Integer id);
}
