package com.geminit.service;

import com.geminit.entity.Permission;
import com.geminit.entity.User;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-20
 * @modify 2018-5-20
 */

public interface ShiroService {

    User getUserByUserName(String username);

    List<Permission> getPermissionsByUser(User user);

}
