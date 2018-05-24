package com.geminit.dao;

import com.geminit.entity.Permission;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-20
 * @modify 2018-5-20
 */

@Repository
public interface ShiroDao {

    List<Integer> getUserRoleByUserId(int id);

    List<Permission> getPermissionsByRoleId(int id);

}
