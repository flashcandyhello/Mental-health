package com.ruoyi.system.controller;

import com.github.pagehelper.PageInfo;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.vo.SquarePostVO;
import com.ruoyi.system.service.ISquareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 匿名广场Controller
 * 
 * @author ruoyi
 * @date 2026-02-09
 */
@RestController
@RequestMapping("/api/square")
public class SquareController extends BaseController
{

    @Autowired
    private ISquareService squareService;

    // ✅ 只保留这一个 list 方法，并添加 @Anonymous
    @Anonymous  // ← 加在这里！
    @GetMapping("/list")
    public R<PageInfo<SquarePostVO>> list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        PageInfo<SquarePostVO> pageInfo = squareService.selectPublicPosts(pageNum, pageSize);
        return R.ok(pageInfo);
    }
    /**
     * 抱抱帖子
     */
    @PostMapping("/hug/{postId}")
    public R<Integer> hug(@PathVariable Long postId)
    {
        Long userId = SecurityUtils.getUserId();
        int count = squareService.hugPost(postId, userId);
        return R.ok(count);
    }
}
