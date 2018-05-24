package com.geminit.service.impl;


import com.geminit.dao.ShiroDao;
import com.geminit.dao.UserDao;
import com.geminit.entity.Permission;
import com.geminit.entity.User;
import com.geminit.service.ShiroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-20
 * @modify 2018-5-20
 */

@Service
@Transactional(rollbackFor = Exception.class)
public class ShiroServiceImpl implements ShiroService {

    @Autowired
    ShiroDao shiroDao;

    @Autowired
    UserDao userDao;

    public User getUserByUserName(String username) {
        //根据账号获取账号密码
        User userByUserName = userDao.getUserByName(username);
        return userByUserName;
    }

    public List<Permission> getPermissionsByUser(User user) {
        //获取到用户角色userRole
        List<Integer> roleId = shiroDao.getUserRoleByUserId(user.getId());
        List<Permission> perArrary = new ArrayList<>();

        if (roleId!=null&&roleId.size()!=0) {
            //根据roleid获取peimission
            for (Integer i : roleId) {
                perArrary.addAll(shiroDao.getPermissionsByRoleId(i));
            }
        }

        System.out.println(perArrary);
        return perArrary;
    }

}
