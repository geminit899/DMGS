package com.geminit.dao;

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

    List<Earthquake> getEarthquakeInfo();

    Earthquake getLatestEarthquake();

    void insertEarthquakeInfo(@Param("name")String name, @Param("lng")String lng, @Param("lat")String lat,
                              @Param("time")String time);

}
