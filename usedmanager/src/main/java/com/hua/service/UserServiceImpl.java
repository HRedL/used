package com.hua.service;

import com.hua.dao.UserDao;
import com.hua.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    public List<User> queryAll(){

        return userDao.queryAll();
    }

    public User query4Login(User user){

        return userDao.query4Login(user);
    }

    public List<User> pageQueryUser(Map<String, Object> map) {
        return userDao.pageQueryUser(map);
    }

    public Integer pageQueryCount(Map<String,Object> map) {
        return userDao.pageQueryCount(map);
    }


    public void addUser(User user){
        userDao.addUser(user);
    }


    public Boolean query4Validate(User user) {
        Integer num=userDao.query4Validate(user);
        if(num==0){
            return true;
        }else{
            return false;
        }
    }

    public void updateUser(User user){
        userDao.updateUser(user);
    }

    public void deleteUser(Integer id){
        userDao.deleteUser(id);

    }

    public void deleteUsers(Map<String, Object> map) {
        userDao.deleteUsers(map);
    }

    public void insertUserRoles(Map<String, Object> map) {
        userDao.insertUserRoles(map);
    }

    public void deleteUserRoles(Map<String, Object> map) {
        userDao.deleteUserRoles(map);
    }


}
