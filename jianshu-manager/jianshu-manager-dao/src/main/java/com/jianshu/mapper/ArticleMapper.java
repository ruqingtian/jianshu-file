package com.jianshu.mapper;

import com.jianshu.pojo.Article;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ArticleMapper {
    //根据文章集id 查询List
    public List<Article> selectArticleByCollectionId(int collcetionId);
    //根据文章id 查询文章
    public Article selectArticleById(int id);
    //根据文章id 修改文章
    public void updataArticleById(Map map);
    //新建文章
    public void saveArticle(Map map);
    //根据id 删除文章
    public void deleteArticle(int id);
    //查询所有的文章
    public List<Article> selectAllArticle();
    //分页查询文章
    public List<Article> selectPageArticle(@Param("index")int index,@Param("currentCount") int currentCount);
    //查询总条数
    public int selectCountArticle();
    //根据userId 查询集合
    public List<Article> selectListByUserId(int userId);
    //模糊查询  分页
    public List<Article> selectListByTitleOrContent(@Param("title")String title,@Param("index")int index,@Param("currentCount")int currentCount);
    //模糊查询总条数
    public int selectCountLikeTitleOrContent(@Param("title")String title);
}
