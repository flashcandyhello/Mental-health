package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.BizMoodDiary;

/**
 * 学生心情日记Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-23
 */
public interface BizMoodDiaryMapper 
{
    /**
     * 查询学生心情日记
     * 
     * @param id 学生心情日记主键
     * @return 学生心情日记
     */
    public BizMoodDiary selectBizMoodDiaryById(Long id);

    /**
     * 查询学生心情日记列表
     * 
     * @param bizMoodDiary 学生心情日记
     * @return 学生心情日记集合
     */
    public List<BizMoodDiary> selectBizMoodDiaryList(BizMoodDiary bizMoodDiary);

    /**
     * 新增学生心情日记
     * 
     * @param bizMoodDiary 学生心情日记
     * @return 结果
     */
    public int insertBizMoodDiary(BizMoodDiary bizMoodDiary);

    /**
     * 修改学生心情日记
     * 
     * @param bizMoodDiary 学生心情日记
     * @return 结果
     */
    public int updateBizMoodDiary(BizMoodDiary bizMoodDiary);

    /**
     * 删除学生心情日记
     * 
     * @param id 学生心情日记主键
     * @return 结果
     */
    public int deleteBizMoodDiaryById(Long id);

    /**
     * 批量删除学生心情日记
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteBizMoodDiaryByIds(Long[] ids);
}
