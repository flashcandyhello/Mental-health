package com.ruoyi.system.controller;

import java.util.List;
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
 * @author ruoyi
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
    @PreAuthorize("@ss.hasPermi('system:diary:add')")
    @Log(title = "学生心情日记", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BizMoodDiary bizMoodDiary)
    {
        return toAjax(bizMoodDiaryService.insertBizMoodDiary(bizMoodDiary));
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
}
