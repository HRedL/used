package com.hua.dao;


import com.hua.entity.User;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface UserDao {

    @Select("select  from user")
    List<User> queryAll();


    @Select("select * from User where account=#{account} and password=#{password}")
    public User query4Login(User user);


    public List<User> pageQueryUser(Map<String,Object> map);


    public Integer pageQueryCount(Map<String,Object> map);


    public void addUser(User user);

    public Integer query4Validate(User user);

    public void updateUser(User user);

    public void deleteUser(Integer id);

    public void deleteUsers(Map<String, Object> map);

    void insertUserRoles(Map<String, Object> map);

    void deleteUserRoles(Map<String, Object> map);


}
