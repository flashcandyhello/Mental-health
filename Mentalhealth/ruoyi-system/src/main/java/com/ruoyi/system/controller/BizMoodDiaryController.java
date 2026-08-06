package com.ruoyi.system.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.BizMoodDiary;
import com.ruoyi.system.service.IBizMoodDiaryService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学生心情日记Controller
 * 
 * @author zzs
 * @date 2025-12-23
 */
@RestController
@RequestMapping("/system/diary")
public class BizMoodDiaryController extends BaseController
{
    @Autowired
    private IBizMoodDiaryService bizMoodDiaryService;

    /**
     * 查询学生心情日记列表
     */
    @PreAuthorize("@ss.hasPermi('system:diary:list')")
    @GetMapping("/list")
    public TableDataInfo list(BizMoodDiary bizMoodDiary)
    {
        startPage();
        List<BizMoodDiary> list = bizMoodDiaryService.selectBizMoodDiaryList(bizMoodDiary);
        return getDataTable(list);
    }

    /**
     * 导出学生心情日记列表
     */
    @PreAuthorize("@ss.hasPermi('system:diary:export')")
    @Log(title = "学生心情日记", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, BizMoodDiary bizMoodDiary)
    {
        List<BizMoodDiary> list = bizMoodDiaryService.selectBizMoodDiaryList(bizMoodDiary);
        ExcelUtil<BizMoodDiary> util = new ExcelUtil<BizMoodDiary>(BizMoodDiary.class);
        util.exportExcel(response, list, "学生心情日记数据");
    }

    /**
     * 获取学生心情日记详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:diary:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(bizMoodDiaryService.selectBizMoodDiaryById(id));
    }

    /**
     * 新增学生心情日记
     */
    //@PreAuthorize("@ss.hasPermi('system:diary:add')")
    @Log(title = "学生心情日记", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BizMoodDiary bizMoodDiary)
    {
        // 2. 先执行插入（这一步 Service 层会调用 AI，把分数和建议填进 bizMoodDiary 对象里）
        bizMoodDiaryService.insertBizMoodDiary(bizMoodDiary);

        // 3. 把填满数据的对象 bizMoodDiary 返回给前端
        // 这样前端的 response.data 就能拿到 score, moodTag, aiAdvice 了
        return AjaxResult.success(bizMoodDiary);
    }

    /**
     * 修改学生心情日记
     */
    @PreAuthorize("@ss.hasPermi('system:diary:edit')")
    @Log(title = "学生心情日记", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody BizMoodDiary bizMoodDiary)
    {
        return toAjax(bizMoodDiaryService.updateBizMoodDiary(bizMoodDiary));
    }

    /**
     * 删除学生心情日记
     */
    @PreAuthorize("@ss.hasPermi('system:diary:remove')")
    @Log(title = "学生心情日记", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(bizMoodDiaryService.deleteBizMoodDiaryByIds(ids));
    }
    /*
     * 获取图表数据 (新加的接口)
     */
    @PreAuthorize("@ss.hasPermi('system:diary:list')")
    @GetMapping("/chartData")
    public AjaxResult getChartData(Long userId)
    {
        // 如果传入userId参数则使用该userId，否则使用当前登录用户ID
        Long targetUserId = (userId != null) ? userId : getUserId();
        List<BizMoodDiary> list = bizMoodDiaryService.getChartData(targetUserId);
        return success(list);
    }
    /**
     * 获取后台驾驶舱统计数据
     */
    @GetMapping("/dashboardData")
    public AjaxResult getDashboardData()
    {
        AjaxResult ajax = AjaxResult.success();

        // 1. 今日预警数 (3级和4级，即分数 < 60)
        // 这里简化写法，建议你在 Mapper 中写专门的 count SQL
        BizMoodDiary queryRisk = new BizMoodDiary();
        // 伪代码：实际需要在 SQL 中处理 "create_time is today" 和 "score < 60"
        // 暂时模拟数据，或者你可以在 Service 层实现 selectCountRiskToday()
        int riskCount = bizMoodDiaryService.selectRiskCountToday();

        // 2. 未处理预警 (status = 0)
        // 假设你有一个 InterventionService
        int todoCount = bizMoodDiaryService.selectUnprocessedCount();

        // 3. 全校情绪趋势 (最近7天平均分)
        // 返回格式: {dates: ["Mon", "Tue"...], scores: [80, 75, ...]}
        Map<String, Object> trend = bizMoodDiaryService.selectMoodTrend();

        // 4. 高频词云 (统计 mood_tag 出现次数)
        // 返回格式: [{name: "焦虑", value: 50}, {name: "失眠", value: 30}]
        List<Map<String, Object>> words = bizMoodDiaryService.selectHotWords();

        ajax.put("riskCount", riskCount);
        ajax.put("todoCount", todoCount);
        ajax.put("trend", trend);
        ajax.put("words", words);
        ajax.put("studentCount", bizMoodDiaryService.selectStudentCount()); // 学生总数
        ajax.put("aiCount", bizMoodDiaryService.selectTotalDiaryCount());   // AI 诊断数
        ajax.put("interventionCount", bizMoodDiaryService.selectTotalInterventionCount()); // 累计干预
        return ajax;
    }



}
