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
import com.ruoyi.system.domain.SysInterventionRecord;
import com.ruoyi.system.service.ISysInterventionRecordService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 心理干预记录Controller
 * 
 * @author ruoyi
 * @date 2025-12-26
 */
@RestController
@RequestMapping("/system/record")
public class SysInterventionRecordController extends BaseController
{
    @Autowired
    private ISysInterventionRecordService sysInterventionRecordService;

    /**
     * 查询心理干预记录列表
     */
//    @PreAuthorize("@ss.hasPermi('system:record:list')")
//    @GetMapping("/list")
//    public TableDataInfo list(SysInterventionRecord sysInterventionRecord)
//    {
//        startPage();
//        List<SysInterventionRecord> list = sysInterventionRecordService.selectSysInterventionRecordList(sysInterventionRecord);
//        return getDataTable(list);
//    }
    /**
     * 查询心理干预记录列表
     */
    @GetMapping("/list")
    public TableDataInfo list(SysInterventionRecord sysInterventionRecord)
    {
        // 1. 获取当前用户ID
        Long userId = getUserId();

        // 2. 判断当前用户是否是“老师”
        // 根据你的截图，老师的角色权限字符是 "common"
        boolean isTeacher = false;
        try {
            // 获取当前登录用户的所有角色
            List<com.ruoyi.common.core.domain.entity.SysRole> roles = getLoginUser().getUser().getRoles();
            for (com.ruoyi.common.core.domain.entity.SysRole role : roles) {
                if ("common".equals(role.getRoleKey())) {
                    isTeacher = true;
                    break;
                }
            }
        } catch (Exception e) {
            // 忽略异常，防止无角色时报错
        }

        // 3. 权限控制逻辑：
        // 如果【不是管理员】且【不是老师】，则强制只查自己的记录
        // 这样一来：管理员(admin)可以看到所有，老师(common)可以看到所有，只有学生(lower)会被限制
        if (!com.ruoyi.common.utils.SecurityUtils.isAdmin(userId) && !isTeacher) {
            sysInterventionRecord.setStudentName(String.valueOf(userId));
        }

        startPage();
        List<SysInterventionRecord> list = sysInterventionRecordService.selectSysInterventionRecordList(sysInterventionRecord);
        return getDataTable(list);
    }
    /**
     * 导出心理干预记录列表
     */
    @PreAuthorize("@ss.hasPermi('system:record:export')")
    @Log(title = "心理干预记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysInterventionRecord sysInterventionRecord)
    {
        List<SysInterventionRecord> list = sysInterventionRecordService.selectSysInterventionRecordList(sysInterventionRecord);
        ExcelUtil<SysInterventionRecord> util = new ExcelUtil<SysInterventionRecord>(SysInterventionRecord.class);
        util.exportExcel(response, list, "心理干预记录数据");
    }

    /**
     * 获取心理干预记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:record:query')")
    @GetMapping(value = "/{recordId}")
    public AjaxResult getInfo(@PathVariable("recordId") Long recordId)
    {
        return success(sysInterventionRecordService.selectSysInterventionRecordByRecordId(recordId));
    }

    /**
     * 新增心理干预记录
     */
    @PreAuthorize("@ss.hasPermi('system:record:add')")
    @Log(title = "心理干预记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysInterventionRecord sysInterventionRecord)
    {
        return toAjax(sysInterventionRecordService.insertSysInterventionRecord(sysInterventionRecord));
    }

    /**
     * 修改心理干预记录
     */
    @PreAuthorize("@ss.hasPermi('system:record:edit')")
    @Log(title = "心理干预记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysInterventionRecord sysInterventionRecord)
    {
        return toAjax(sysInterventionRecordService.updateSysInterventionRecord(sysInterventionRecord));
    }

    /**
     * 删除心理干预记录
     */
    @PreAuthorize("@ss.hasPermi('system:record:remove')")
    @Log(title = "心理干预记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{recordIds}")
    public AjaxResult remove(@PathVariable Long[] recordIds)
    {
        return toAjax(sysInterventionRecordService.deleteSysInterventionRecordByRecordIds(recordIds));
    }
}
