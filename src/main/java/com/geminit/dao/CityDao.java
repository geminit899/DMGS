package com.geminit.dao;

import com.geminit.entity.City;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Repository
public interface CityDao {

    List<City> getCities();

    List<String> getLLTByName(String name);

    void setTemperatureById(@Param("id")int id, @Param("temperature")String temperature);

}
