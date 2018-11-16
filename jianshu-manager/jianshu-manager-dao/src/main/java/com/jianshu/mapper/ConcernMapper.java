package com.jianshu.mapper;

import com.jianshu.pojo.Concern;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ConcernMapper {
    //查询该用户关注的 id   集合
    public List<Integer> selectListByUserId(int userId);
    //添加关注
    public void insertConcern(@Param("userId") int userId,@Param("concernId") int concernId);
//    查询关注
    public Concern selectConcern(@Param("userId") int userId,@Param("concernId") int concernId);
    //删除关注
    public void deleteConcern(@Param("userId") int userId,@Param("concernId") int concernId);
}
