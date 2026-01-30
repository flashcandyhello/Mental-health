package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.SysInterventionRecord;

/**
 * 心理干预记录Service接口
 * 
 * @author ruoyi
 * @date 2025-12-26
 */
public interface ISysInterventionRecordService 
{
    /**
     * 查询心理干预记录
     * 
     * @param recordId 心理干预记录主键
     * @return 心理干预记录
     */
    public SysInterventionRecord selectSysInterventionRecordByRecordId(Long recordId);

    /**
     * 查询心理干预记录列表
     * 
     * @param sysInterventionRecord 心理干预记录
     * @return 心理干预记录集合
     */
    public List<SysInterventionRecord> selectSysInterventionRecordList(SysInterventionRecord sysInterventionRecord);

    /**
     * 新增心理干预记录
     * 
     * @param sysInterventionRecord 心理干预记录
     * @return 结果
     */
    public int insertSysInterventionRecord(SysInterventionRecord sysInterventionRecord);

    /**
     * 修改心理干预记录
     * 
     * @param sysInterventionRecord 心理干预记录
     * @return 结果
     */
    public int updateSysInterventionRecord(SysInterventionRecord sysInterventionRecord);

    /**
     * 批量删除心理干预记录
     * 
     * @param recordIds 需要删除的心理干预记录主键集合
     * @return 结果
     */
    public int deleteSysInterventionRecordByRecordIds(Long[] recordIds);

    /**
     * 删除心理干预记录信息
     * 
     * @param recordId 心理干预记录主键
     * @return 结果
     */
    public int deleteSysInterventionRecordByRecordId(Long recordId);
}
