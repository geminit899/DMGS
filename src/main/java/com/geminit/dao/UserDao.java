package com.geminit.dao;

import com.geminit.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-4
 * @modify 2018-5-4
 */

@Repository
public interface UserDao {

    List<User> getAllUsers();

    User getUserByName(String name);

    String getSaltByName(String name);

    String getMd5ByName(String name);

}
