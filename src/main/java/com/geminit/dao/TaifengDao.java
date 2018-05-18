package com.geminit.dao;

import com.geminit.entity.DataList;
import com.geminit.entity.Taifeng;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Repository
public interface TaifengDao {

    List<String> getTaifengName();

    List<Taifeng> getTaifengByName(String name);

    List<Taifeng> getStrongestTaifeng();

    List<DataList> getTaifengList();

    void updateTaifengById(@Param("id")String id, @Param("name")String name, @Param("lng")String lng,
                           @Param("lat")String lat, @Param("time")String time, @Param("degree")String degree);

    void insertTaifeng(@Param("pid")String pid, @Param("name")String name, @Param("lng")String lng,
                       @Param("lat")String lat, @Param("time")String time, @Param("degree")String degree);

    void deleteTaifengById(String id);

}
