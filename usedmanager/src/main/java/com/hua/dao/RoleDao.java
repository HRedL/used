package com.hua.dao;

import com.hua.entity.Role;
import com.hua.entity.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface RoleDao {

    List<Role> queryAllRole();


    @Select("SELECT roleId  FROM user_role where userId=#{userId}")
    List<Integer> queryAssignedRoleId(Integer userId);



    public List<Role> pageQueryRole(Map<String,Object> map);


    public Integer pageQueryCount(Map<String,Object> map);

    void insertRolePermission(Map<String, Object> map);


    @Delete("DELETE FROM role_permission WHERE roleId=#{roleId}")
    void deletePermission(Map<String, Object> map);
}
