package com.geminit.dao;

import com.geminit.entity.Law;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Repository
public interface LawDao {

    List<Law> getLaws();

    Law getLatestLaw();

    void insertLaws(@Param("title")String title, @Param("time")String time, @Param("content")String content);

}
