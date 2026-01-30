package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.BizMoodDiary;
import io.lettuce.core.dynamic.annotation.Param;
import java.util.Map;
/**
 * 学生心情日记Mapper接口
 *
 * @author ruoyi
 * @date 2025-12-23
 */
public interface BizMoodDiaryMapper 
{

    public int selectStudentCount();
    public int selectTotalDiaryCount();
    public int selectTotalInterventionCount();


    public int selectRiskCountToday();

    public int selectUnprocessedCount(); // 注意：这个实际上是查 record 表，但为了方便写在这里

    public List<Map<String, Object>> selectMoodTrend();

    public List<Map<String, Object>> selectHotWords();

    // 记得保留你之前写的 selectLatestDiaryByUserId 和 selectChartData
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
    // 在文件末尾添加这个方法
    /**
     * 查询当前用户最近7天的情绪数据用于图表展示
     * @param userId 当前用户ID
     * @return 结果集
     */
    List<BizMoodDiary> selectChartData(@Param("userId") Long userId);
    /**
     * 查询指定用户最近的一条日记（用于获取上次能量值）
     */
    public BizMoodDiary selectLatestDiaryByUserId(Long userId);
}
