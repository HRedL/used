package com.hua.controller;


import com.hua.entity.User;
import com.hua.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/test")
public class TestController {

    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping("/queryAll")
    public Object queryAll(){
        List<User> users= userService.queryAll();

        return users;
    }

    @RequestMapping("index")
    public String testReuqest(){

        return "index";
    }

}
