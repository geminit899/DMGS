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

    List<City> getCityByName(String name);

    List<City> getTop10TemperatureCities();

    List<City> getTop10Pm2_5Cities();

    void setTemperatureById(@Param("id")int id, @Param("temperature")String temperature);

    void setPm2_5ById(@Param("id")int id, @Param("pm2_5")String pm2_5);

}
