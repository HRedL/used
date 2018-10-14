package com.hua.service;

import com.hua.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    public List<User> queryAll();

    public User query4Login(User user);

    public List<User> pageQueryUser(Map<String,Object> map);


    public Integer pageQueryCount(Map<String,Object> map);


    public void addUser(User user);

    public Boolean query4Validate(User user);

    public void updateUser(User user);

    public void deleteUser(Integer id);

    public void deleteUsers(Map<String, Object> map);

    void insertUserRoles(Map<String, Object> map);

    void deleteUserRoles(Map<String, Object> map);
}
