package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学生心情日记对象 biz_mood_diary
 * 
 * @author ruoyi
 * @date 2025-12-23
 */
public class BizMoodDiary extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private String riskLevel;
    public void setRiskLevel(String riskLevel)
    {
        this.riskLevel = riskLevel;
    }

    public String getRiskLevel()
    {
        return riskLevel;
    }


    /** 主键ID */
    private Long id;



    /** 学生ID(关联sys_user表) */
    @Excel(name = "学生ID(关联sys_user表)")
    private Long userId;

    /** 学生姓名 (新增字段) */
    @Excel(name = "学生姓名")
    private String nickName;

    // ... Getter 和 Setter 方法 ...
    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }

    public String getNickName()
    {
        return nickName;
    }


    /** 日记内容(支持表情) */
    @Excel(name = "日记内容(支持表情)")
    private String content;

    /** 情绪评分(0-100分) */
    @Excel(name = "情绪评分(0-100分)")
    private Integer moodScore;

    /** 情绪标签(如:焦虑/开心/平淡) */
    @Excel(name = "情绪标签(如:焦虑/开心/平淡)")
    private String moodTag;

    /** AI给出的建议 */
    @Excel(name = "AI给出的建议")
    private String aiAdvice;

    /** 删除标志(0代表存在 2代表删除) */
    private String delFlag;

    /** 是否公开(0否 1是) */
    private String isPublic;

    /** 匿名标签 */
    private String anonymousTag;

    /** 抱抱数 */
    private Integer hugCount;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }

    public void setMoodScore(Integer moodScore) 
    {
        this.moodScore = moodScore;
    }

    public Integer getMoodScore() 
    {
        return moodScore;
    }

    public void setMoodTag(String moodTag) 
    {
        this.moodTag = moodTag;
    }

    public String getMoodTag() 
    {
        return moodTag;
    }

    public void setAiAdvice(String aiAdvice) 
    {
        this.aiAdvice = aiAdvice;
    }

    public String getAiAdvice() 
    {
        return aiAdvice;
    }

    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    public void setIsPublic(String isPublic) 
    {
        this.isPublic = isPublic;
    }

    public String getIsPublic() 
    {
        return isPublic;
    }

    public void setAnonymousTag(String anonymousTag) 
    {
        this.anonymousTag = anonymousTag;
    }

    public String getAnonymousTag() 
    {
        return anonymousTag;
    }

    public void setHugCount(Integer hugCount) 
    {
        this.hugCount = hugCount;
    }

    public Integer getHugCount() 
    {
        return hugCount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("content", getContent())
            .append("moodScore", getMoodScore())
            .append("moodTag", getMoodTag())
            .append("aiAdvice", getAiAdvice())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("delFlag", getDelFlag())
            .append("isPublic", getIsPublic())
            .append("anonymousTag", getAnonymousTag())
            .append("hugCount", getHugCount())
            .toString();
    }
}
