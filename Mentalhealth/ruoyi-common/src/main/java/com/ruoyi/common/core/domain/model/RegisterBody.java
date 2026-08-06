package com.ruoyi.common.core.domain.model;

/**
 * 用户注册对象
 * 
 * @author ruoyi
 */
public class RegisterBody extends LoginBody
{
    /**
     * 是否有意向帮助他人
     */
    private Boolean helpOthers;

    public Boolean getHelpOthers()
    {
        return helpOthers;
    }

    public void setHelpOthers(Boolean helpOthers)
    {
        this.helpOthers = helpOthers;
    }
}
