package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.SquareLike;
import org.apache.ibatis.annotations.Param;

/**
 * 广场点赞Mapper接口
 *
 * @author ruoyi
 * @date 2026-02-09
 */
public interface SquareLikeMapper 
{

    /**
     * 新增广场点赞
     * 
     * @param squareLike 广场点赞
     * @return 结果
     */
    public int insert(SquareLike squareLike);

    /**
     * 统计某日记的抱抱数
     * 
     * @param postId 日记ID
     * @return 抱抱数
     */
    public int countByPostId(Long postId);

    /**
     * 检查用户是否已对该日记抱抱
     * 
     * @param userId 用户ID
     * @param postId 日记ID
     * @return 广场点赞对象
     */
    public SquareLike selectByUserAndPost(@Param("userId") Long userId, @Param("postId") Long postId);
}
