package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.BizMoodDiaryMapper;
import com.ruoyi.system.domain.BizMoodDiary;
import com.ruoyi.system.service.IBizMoodDiaryService;

/**
 * 学生心情日记Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-23
 */
@Service
public class BizMoodDiaryServiceImpl implements IBizMoodDiaryService 
{
    @Autowired
    private BizMoodDiaryMapper bizMoodDiaryMapper;

    /**
     * 查询学生心情日记
     * 
     * @param id 学生心情日记主键
     * @return 学生心情日记
     */
    @Override
    public BizMoodDiary selectBizMoodDiaryById(Long id)
    {
        return bizMoodDiaryMapper.selectBizMoodDiaryById(id);
    }

    /**
     * 查询学生心情日记列表
     * 
     * @param bizMoodDiary 学生心情日记
     * @return 学生心情日记
     */
    @Override
    public List<BizMoodDiary> selectBizMoodDiaryList(BizMoodDiary bizMoodDiary)
    {
        return bizMoodDiaryMapper.selectBizMoodDiaryList(bizMoodDiary);
    }

    /**
     * 新增学生心情日记
     * 
     * @param bizMoodDiary 学生心情日记
     * @return 结果
     */
    @Override
    public int insertBizMoodDiary(BizMoodDiary bizMoodDiary)
    {
        bizMoodDiary.setCreateTime(DateUtils.getNowDate());
        return bizMoodDiaryMapper.insertBizMoodDiary(bizMoodDiary);
    }

    /**
     * 修改学生心情日记
     * 
     * @param bizMoodDiary 学生心情日记
     * @return 结果
     */
    @Override
    public int updateBizMoodDiary(BizMoodDiary bizMoodDiary)
    {
        bizMoodDiary.setUpdateTime(DateUtils.getNowDate());
        return bizMoodDiaryMapper.updateBizMoodDiary(bizMoodDiary);
    }

    /**
     * 批量删除学生心情日记
     * 
     * @param ids 需要删除的学生心情日记主键
     * @return 结果
     */
    @Override
    public int deleteBizMoodDiaryByIds(Long[] ids)
    {
        return bizMoodDiaryMapper.deleteBizMoodDiaryByIds(ids);
    }

    /**
     * 删除学生心情日记信息
     * 
     * @param id 学生心情日记主键
     * @return 结果
     */
    @Override
    public int deleteBizMoodDiaryById(Long id)
    {
        return bizMoodDiaryMapper.deleteBizMoodDiaryById(id);
    }
}
