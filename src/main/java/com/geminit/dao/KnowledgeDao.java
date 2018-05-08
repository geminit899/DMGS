package com.geminit.dao;

import com.geminit.entity.Knowledge;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Repository
public interface KnowledgeDao {

    List<Knowledge> getKnowledges();

    Knowledge getLatestKnowledge();

    void insertKnowledges(@Param("title")String title, @Param("time")String time, @Param("content")String content);

}
