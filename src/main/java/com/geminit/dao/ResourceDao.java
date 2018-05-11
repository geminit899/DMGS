package com.geminit.dao;

import com.geminit.entity.Resource;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Repository
public interface ResourceDao {

    int getAllResourceNum();

    List<String> getResourceName(@Param("start")int start, @Param("num")int num);

    List<Resource> getResourceByName(String name);

    void insertResource(@Param("name")String name, @Param("content")byte[] content);

    void deleteResourceByName(String name);

}
