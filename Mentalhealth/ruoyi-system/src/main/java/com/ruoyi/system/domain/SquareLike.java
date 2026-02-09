package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

import java.util.Date;

/**
 * 广场点赞对象 square_like
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
public class SquareLike extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 日记ID(关联biz_mood_diary表) */
    private Long postId;

    /** 用户ID(关联sys_user表) */
    private Long userId;

    /** 创建时间 */
    private Date createTime;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setPostId(Long postId) 
    {
        this.postId = postId;
    }

    public Long getPostId() 
    {
        return postId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    @Override
    public void setCreateTime(Date createTime) 
    {
        this.createTime = createTime;
    }

    @Override
    public Date getCreateTime() 
    {
        return createTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("postId", getPostId())
            .append("userId", getUserId())
            .append("createTime", getCreateTime())
            .toString();
    }
}
