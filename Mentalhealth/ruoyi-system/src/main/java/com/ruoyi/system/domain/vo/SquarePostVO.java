package com.ruoyi.system.domain.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 广场帖子视图对象
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
public class SquarePostVO implements Serializable
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 日记内容 */
    private String content;

    /** 匿名标签 */
    private String anonymousTag;

    /** 创建时间 */
    private Date createTime;

    /** 抱抱数 */
    private Integer hugCount;

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getAnonymousTag()
    {
        return anonymousTag;
    }

    public void setAnonymousTag(String anonymousTag)
    {
        this.anonymousTag = anonymousTag;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    public Integer getHugCount()
    {
        return hugCount;
    }

    public void setHugCount(Integer hugCount)
    {
        this.hugCount = hugCount;
    }
}
