package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.BizMoodDiary;
import com.ruoyi.system.domain.SquareLike;
import com.ruoyi.system.domain.vo.SquarePostVO;
import com.ruoyi.system.mapper.BizMoodDiaryMapper;
import com.ruoyi.system.mapper.SquareLikeMapper;
import com.ruoyi.system.service.ISquareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 匿名广场Service业务层处理
 *
 * @author ruoyi
 * @date 2026-02-09
 */
@Service
public class SquareServiceImpl implements ISquareService
{

    @Autowired
    private BizMoodDiaryMapper bizMoodDiaryMapper;

    @Autowired
    private SquareLikeMapper squareLikeMapper;

    /**
     * 查询广场公开帖子列表
     *
     * @param pageNum 页码
     * @param pageSize 每页大小
     * @return 分页结果
     */
    @Override
    public PageInfo<SquarePostVO> selectPublicPosts(int pageNum, int pageSize)
    {
        PageHelper.startPage(pageNum, pageSize);
        List<BizMoodDiary> list = bizMoodDiaryMapper.selectPublicPosts();
        
        // 转换为 VO
        List<SquarePostVO> voList = new ArrayList<>();
        for (BizMoodDiary diary : list)
        {
            SquarePostVO vo = new SquarePostVO();
            vo.setId(diary.getId());
            vo.setContent(diary.getContent());
            vo.setAnonymousTag(diary.getAnonymousTag());
            vo.setCreateTime(diary.getCreateTime());
            vo.setHugCount(diary.getHugCount() != null ? diary.getHugCount() : 0);
            voList.add(vo);
        }
        
        return new PageInfo<>(voList);
    }

    /**
     * 抱抱帖子
     *
     * @param postId 帖子ID
     * @param userId 用户ID
     * @return 当前抱抱总数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int hugPost(Long postId, Long userId)
    {
        // 1. 检查是否已抱抱
        SquareLike existingLike = squareLikeMapper.selectByUserAndPost(userId, postId);
        if (existingLike != null)
        {
            // 已抱抱，直接返回当前抱抱数
            Integer currentCount = bizMoodDiaryMapper.selectHugCountById(postId);
            return currentCount != null ? currentCount : 0;
        }

        // 2. 插入点赞记录
        SquareLike squareLike = new SquareLike();
        squareLike.setPostId(postId);
        squareLike.setUserId(userId);
        squareLike.setCreateTime(DateUtils.getNowDate());
        squareLikeMapper.insert(squareLike);

        // 3. 更新日记的抱抱数
        bizMoodDiaryMapper.incrementHugCount(postId);

        // 4. 返回更新后的抱抱数
        Integer newCount = bizMoodDiaryMapper.selectHugCountById(postId);
        return newCount != null ? newCount : 0;
    }
}
