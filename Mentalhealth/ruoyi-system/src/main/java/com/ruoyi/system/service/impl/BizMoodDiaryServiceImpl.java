package com.ruoyi.system.service.impl;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.DeepSeekUtils;
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

    @Override
    public int selectStudentCount() { return bizMoodDiaryMapper.selectStudentCount(); }

    @Override
    public int selectTotalDiaryCount() { return bizMoodDiaryMapper.selectTotalDiaryCount(); }

    @Override
    public int selectTotalInterventionCount() { return bizMoodDiaryMapper.selectTotalInterventionCount(); }


    @Override
    public int selectRiskCountToday() {
        return bizMoodDiaryMapper.selectRiskCountToday();
    }

    @Override
    public int selectUnprocessedCount() {
        return bizMoodDiaryMapper.selectUnprocessedCount();
    }

    @Override
    public Map<String, Object> selectMoodTrend() {
        // 从数据库查出来是 List<Map>
        List<Map<String, Object>> list = bizMoodDiaryMapper.selectMoodTrend();

        // 需要拆分成两个数组给前端 ECharts 用
        List<String> dates = new ArrayList<>();
        List<Double> scores = new ArrayList<>();

        for (Map<String, Object> map : list) {
            dates.add(map.get("date").toString());
            scores.add(Double.parseDouble(map.get("score").toString()));
        }

        Map<String, Object> result = new HashMap<>();
        result.put("dates", dates);
        result.put("scores", scores);
        return result;
    }

    @Override
    public List<Map<String, Object>> selectHotWords() {
        return bizMoodDiaryMapper.selectHotWords();
    }

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
    /**
     * 新增学生心情日记 (集成加权移动平均算法)
     */
    @Override
    public int insertBizMoodDiary(BizMoodDiary bizMoodDiary)
    {
        // 1. 获取用户ID (必须先获取ID，才能去查历史记录)
        try {
            bizMoodDiary.setUserId(SecurityUtils.getUserId());
        } catch (Exception e) {
            throw new ServiceException("获取用户ID失败，请确保已登录");
        }

        // ==================== 算法核心逻辑 START ====================

        // 2. 调用 AI 获取“当次评分” (S_current)
        JSONObject aiResult = DeepSeekUtils.analyzeMood(bizMoodDiary.getContent());


        double sCurrent = aiResult.getDoubleValue("score");
        String moodTag = aiResult.getString("tag");
        String advice = aiResult.getString("advice");

        // 3. 获取“上一次能量值” (E_prev)

        BizMoodDiary lastDiary = bizMoodDiaryMapper.selectLatestDiaryByUserId(bizMoodDiary.getUserId());

        // 如果是该用户的第一篇日记，默认上次状态为 80 (健康基准)
        double ePrev = (lastDiary != null && lastDiary.getMoodScore() != null) ? lastDiary.getMoodScore() : 80.0;

        // 4. 定义算法参数
        // α = 0.7 (权重系数：70%取决于当下心情，30%取决于历史惯性)
        double alpha = 0.7;
        double penalty = 0.0;

        // 5. 计算 Penalty (惩罚项)
        // 如果出现极端负面词汇，施加额外扣分
        if ("绝望".equals(moodTag) || "想死".equals(moodTag) || "自杀".equals(moodTag)) {
            penalty = 20.0;
        } else if (sCurrent < 50) {
            penalty = 5.0; // 心情不好时，稍微受到一点历史惯性的拖累
        }

        // 6. 【核心公式】E_today = α * S_current + (1-α) * E_prev - Penalty
        double eToday = (alpha * sCurrent) + ((1 - alpha) * ePrev) - penalty;

        // 7. 边界修正 (确保分数锁定在 0-100 之间)
        if (eToday > 100) eToday = 100;
        if (eToday < 0) eToday = 0;

        // 8. 存入最终计算结果
        // 强转为 int 类型，完美匹配
        bizMoodDiary.setMoodScore((int) eToday); // 存入数据库的是“算法处理后”的分数
        bizMoodDiary.setMoodTag(moodTag);
        bizMoodDiary.setAiAdvice(advice);

        // ==================== 算法核心逻辑 END ======================

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
    // 添加方法实现
    @Override
    public List<BizMoodDiary> getChartData(Long userId) {
        return bizMoodDiaryMapper.selectChartData(userId);
    }
}
