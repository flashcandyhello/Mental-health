package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 心理干预记录对象 sys_intervention_record
 * 
 * @author ruoyi
 * @date 2025-12-26
 */
public class SysInterventionRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 记录ID */
    private Long recordId;

    /** 学生姓名 */
    @Excel(name = "学生姓名")
    private String studentName;

    /** 风险等级（0正常 1低 2中 3高） */
    @Excel(name = "风险等级", readConverterExp = "0=正常,1=低,2=中,3=高")
    private String riskLevel;

    /** AI给出的干预建议 */
    @Excel(name = "AI给出的干预建议")
    private String aiSuggestion;

    /** 处理人（老师/辅导员） */
    @Excel(name = "处理人", readConverterExp = "老=师/辅导员")
    private String handlerName;

    /** 谈话/干预内容记录 */
    @Excel(name = "谈话/干预内容记录")
    private String content;

    /** 状态（0待处理 1已完成） */
    @Excel(name = "状态", readConverterExp = "0=待处理,1=已完成")
    private String status;

    public void setRecordId(Long recordId) 
    {
        this.recordId = recordId;
    }

    public Long getRecordId() 
    {
        return recordId;
    }

    public void setStudentName(String studentName) 
    {
        this.studentName = studentName;
    }

    public String getStudentName() 
    {
        return studentName;
    }

    public void setRiskLevel(String riskLevel) 
    {
        this.riskLevel = riskLevel;
    }

    public String getRiskLevel() 
    {
        return riskLevel;
    }

    public void setAiSuggestion(String aiSuggestion) 
    {
        this.aiSuggestion = aiSuggestion;
    }

    public String getAiSuggestion() 
    {
        return aiSuggestion;
    }

    public void setHandlerName(String handlerName) 
    {
        this.handlerName = handlerName;
    }

    public String getHandlerName() 
    {
        return handlerName;
    }

    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("recordId", getRecordId())
            .append("studentName", getStudentName())
            .append("riskLevel", getRiskLevel())
            .append("aiSuggestion", getAiSuggestion())
            .append("handlerName", getHandlerName())
            .append("content", getContent())
            .append("status", getStatus())
            .append("createTime", getCreateTime())
            .toString();
    }
}
