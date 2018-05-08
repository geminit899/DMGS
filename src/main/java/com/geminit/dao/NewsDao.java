package com.geminit.dao;

import com.geminit.entity.News;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Repository
public interface NewsDao {

    List<News> getNews();

    News getLatestNews();

    void insertNews(@Param("title")String title, @Param("time")String time, @Param("content")String content);

}
