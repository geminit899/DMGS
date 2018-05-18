package com.geminit.dao;

import com.geminit.entity.DataList;
import com.geminit.entity.Earthquake;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Repository
public interface EarthquakeDao {

    int getEarthquakeNum();

    List<Earthquake> getEarthquakeInfo(@Param("start")int start, @Param("num")int num);

    List<Earthquake> getStrongestEarthquake();

    Earthquake getLatestEarthquake();

    List<DataList> getEarthquakeList();

    void updateEarthquakeById(@Param("id")String id, @Param("name")String name, @Param("lng")String lng,
                              @Param("lat")String lat, @Param("degree")String degree, @Param("time")String time);

    void insertEarthquakeInfo(@Param("name")String name, @Param("lng")String lng, @Param("lat")String lat,
                              @Param("degree")String degree, @Param("time")String time);

    void deleteEarthquakeById(String id);

}
