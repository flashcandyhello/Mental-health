package com.ruoyi.system.service;

import com.github.pagehelper.PageInfo;
import com.ruoyi.system.domain.vo.SquarePostVO;

/**
 * 匿名广场Service接口
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
public interface ISquareService 
{

    /**
     * 查询广场公开帖子列表
     * 
     * @param pageNum 页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    public PageInfo<SquarePostVO> selectPublicPosts(int pageNum, int pageSize);

    /**
     * 抱抱帖子
     * 
     * @param postId 帖子ID
     * @param userId 用户ID
     * @return 当前抱抱总数
     */
    public int hugPost(Long postId, Long userId);
}
