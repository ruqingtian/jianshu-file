package com.jianshu.mapper;

import com.jianshu.pojo.Article_collection;

import java.util.List;

public interface ArticleCollectionMapper {
    //根据user_id 查询  返回List 集合
    public List<Article_collection> selectUserIdByArticleCollection(int userId);
}
