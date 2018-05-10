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

    int getTotalLawNum();

    List<Law> getLaws(@Param("start")int start, @Param("num")int num);

    Law getLawById(String id);

    Law getLatestLaw();

    void updateLaw(@Param("id")String id, @Param("title")String title, @Param("time")String time, @Param("content")String content);

    void insertLaws(@Param("title")String title, @Param("time")String time, @Param("content")String content);

    void deleteLawById(String id);

}
