package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysInterventionRecordMapper;
import com.ruoyi.system.domain.SysInterventionRecord;
import com.ruoyi.system.service.ISysInterventionRecordService;

/**
 * 心理干预记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-26
 */
@Service
public class SysInterventionRecordServiceImpl implements ISysInterventionRecordService 
{
    @Autowired
    private SysInterventionRecordMapper sysInterventionRecordMapper;

    /**
     * 查询心理干预记录
     * 
     * @param recordId 心理干预记录主键
     * @return 心理干预记录
     */
    @Override
    public SysInterventionRecord selectSysInterventionRecordByRecordId(Long recordId)
    {
        return sysInterventionRecordMapper.selectSysInterventionRecordByRecordId(recordId);
    }

    /**
     * 查询心理干预记录列表
     * 
     * @param sysInterventionRecord 心理干预记录
     * @return 心理干预记录
     */
    @Override
    public List<SysInterventionRecord> selectSysInterventionRecordList(SysInterventionRecord sysInterventionRecord)
    {
        return sysInterventionRecordMapper.selectSysInterventionRecordList(sysInterventionRecord);
    }

    /**
     * 新增心理干预记录
     * 
     * @param sysInterventionRecord 心理干预记录
     * @return 结果
     */
    @Override
    public int insertSysInterventionRecord(SysInterventionRecord sysInterventionRecord)
    {
        sysInterventionRecord.setCreateTime(DateUtils.getNowDate());
        return sysInterventionRecordMapper.insertSysInterventionRecord(sysInterventionRecord);
    }

    /**
     * 修改心理干预记录
     * 
     * @param sysInterventionRecord 心理干预记录
     * @return 结果
     */
    @Override
    public int updateSysInterventionRecord(SysInterventionRecord sysInterventionRecord)
    {
        return sysInterventionRecordMapper.updateSysInterventionRecord(sysInterventionRecord);
    }

    /**
     * 批量删除心理干预记录
     * 
     * @param recordIds 需要删除的心理干预记录主键
     * @return 结果
     */
    @Override
    public int deleteSysInterventionRecordByRecordIds(Long[] recordIds)
    {
        return sysInterventionRecordMapper.deleteSysInterventionRecordByRecordIds(recordIds);
    }

    /**
     * 删除心理干预记录信息
     * 
     * @param recordId 心理干预记录主键
     * @return 结果
     */
    @Override
    public int deleteSysInterventionRecordByRecordId(Long recordId)
    {
        return sysInterventionRecordMapper.deleteSysInterventionRecordByRecordId(recordId);
    }
}
