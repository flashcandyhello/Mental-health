<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学生姓名" prop="studentName">
        <el-input
          v-model="queryParams.studentName"
          placeholder="请输入学生姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="风险等级" prop="riskLevel">
    <el-select v-model="queryParams.riskLevel" placeholder="请选择风险等级" clearable size="small" style="width: 240px">
      <el-option label="1级 - 状态良好" value="1"><span style="color: #67C23A">● 1级 - 状态良好</span></el-option>
      <el-option label="2级 - 一般关注" value="2"><span style="color: #409EFF">● 2级 - 一般关注</span></el-option>
      <el-option label="3级 - 重点关注" value="3"><span style="color: #E6A23C">● 3级 - 重点关注</span></el-option>
      <el-option label="4级 - 紧急干预" value="4"><span style="color: #F56C6C">● 4级 - 紧急干预</span></el-option>
    </el-select>
  </el-form-item>
      <el-form-item label="处理人" prop="handlerName">
        <el-input
          v-model="queryParams.handlerName"
          placeholder="请输入处理人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

<el-form-item label="干预状态" prop="status">
  <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small" style="width: 240px">
    <el-option label="待处理" value="0"><span style="color: #F56C6C">● 待处理</span></el-option>
    <el-option label="进行中" value="1"><span style="color: #409EFF">● 进行中</span></el-option>
    <el-option label="已结案" value="2"><span style="color: #67C23A">● 已结案</span></el-option>
    <el-option label="已转介" value="3"><span style="color: #E6A23C">● 已转介</span></el-option>
  </el-select>
</el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:record:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:record:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:record:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:record:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="recordList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="记录ID" align="center" prop="recordId" />
      <el-table-column label="学生姓名" align="center" prop="studentName" />
      <el-table-column label="风险等级" align="center" prop="riskLevel">
  <template slot-scope="scope">
    <el-tag v-if="scope.row.riskLevel == 1" type="success">
      1级 - 状态良好
    </el-tag>

    <el-tag v-else-if="scope.row.riskLevel == 2">
      2级 - 一般关注
    </el-tag>

    <el-tag v-else-if="scope.row.riskLevel == 3" type="warning">
      3级 - 重点关注
    </el-tag>

    <el-tag v-else-if="scope.row.riskLevel == 4" type="danger">
      4级 - 紧急干预
    </el-tag>

    <span v-else>{{ scope.row.riskLevel }}</span>
  </template>
</el-table-column>
      <el-table-column label="AI给出的干预建议" prop="aiSuggestion" min-width="300" align="center">
  <template slot-scope="scope">
    <div v-if="scope.row.aiSuggestion" style="
      text-align: left;
      background-color: #ecf5ff;
      border-left: 4px solid #409EFF;
      padding: 8px 10px;
      border-radius: 4px;
      font-size: 13px;
      line-height: 1.5;
      white-space: pre-wrap; 
      color: #606266;
    ">
      <i class="el-icon-chat-dot-round" style="color: #409EFF; margin-right: 4px;"></i>
      {{ scope.row.aiSuggestion }}
    </div>
    <span v-else>-</span>
  </template>
</el-table-column>
      <el-table-column label="处理人" align="center" prop="handlerName" />
      <el-table-column label="谈话/干预内容记录" align="center" prop="content" />
<el-table-column label="干预状态" align="center" prop="status" width="100">
  <template slot-scope="scope">
    <el-tag v-if="scope.row.status == '0' || scope.row.status == 0" type="danger" effect="dark">
      待处理
    </el-tag>
    
    <el-tag v-else-if="scope.row.status == '1'" type="primary" effect="plain">
      进行中
    </el-tag>
    
    <el-tag v-else-if="scope.row.status == '2'" type="success" effect="dark">
      <i class="el-icon-circle-check"></i> 已结案
    </el-tag>
    
    <el-tag v-else-if="scope.row.status == '3'" type="warning" effect="plain">
      已转介
    </el-tag>
    
    <span v-else>{{ scope.row.status }}</span>
  </template>
</el-table-column>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:record:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:record:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改心理干预记录对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学生姓名" prop="studentName">
          <el-input v-model="form.studentName" placeholder="请输入学生姓名" />
        </el-form-item>
        <el-form-item label="风险等级" prop="riskLevel">
  <el-select v-model="form.riskLevel" placeholder="请选择风险等级" style="width: 100%">
    <el-option label="1级 - 状态良好" value="1">
      <span style="float: left; color: #67C23A; font-weight: bold;">● 1级 - 状态良好</span>
    </el-option>
    <el-option label="2级 - 一般关注" value="2">
      <span style="float: left; color: #409EFF; font-weight: bold;">● 2级 - 一般关注</span>
    </el-option>
    <el-option label="3级 - 重点关注" value="3">
      <span style="float: left; color: #E6A23C; font-weight: bold;">● 3级 - 重点关注</span>
    </el-option>
    <el-option label="4级 - 紧急干预" value="4">
      <span style="float: left; color: #F56C6C; font-weight: bold;">● 4级 - 紧急干预</span>
    </el-option>
  </el-select>
</el-form-item>
        <el-form-item label="AI 智能诊断" prop="aiSuggestion">
  <div style="
    background-color: #ecf5ff; 
    border-left: 5px solid #409EFF; 
    padding: 12px 15px; 
    border-radius: 4px; 
    color: #303133; 
    line-height: 1.6; 
    font-family: 'PingFang SC', sans-serif;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  ">
    <div style="font-weight: bold; color: #409EFF; margin-bottom: 8px;">
      <i class="el-icon-magic-stick"></i> DeepSeek 辅助分析报告：
    </div>
    
    <div style="white-space: pre-wrap; font-size: 14px;">
      {{ form.aiSuggestion || '暂无 AI 分析数据，请从日记页面转录...' }}
    </div>
  </div>

  <el-input v-show="false" v-model="form.aiSuggestion" />
</el-form-item>
        <el-form-item label="处理人" prop="handlerName">
          <el-input v-model="form.handlerName" placeholder="请输入处理人" />
        </el-form-item>

        <el-form-item label="干预状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">待处理</el-radio>
            <el-radio label="1">进行中</el-radio>
            <el-radio label="2">已结案</el-radio>
            <el-radio label="3">已转介 (医院/专家)</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="谈话/干预内容记录">
          <editor v-model="form.content" :min-height="192"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listRecord, getRecord, delRecord, addRecord, updateRecord } from "@/api/system/record"

export default {
  name: "Record",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 心理干预记录表格数据
      recordList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        studentName: null,
        riskLevel: null,
        aiSuggestion: null,
        handlerName: null,
        content: null,
        status: null,
        // 👇👇👇 新增这两行 👇👇👇
      orderByColumn: 'createTime', // 告诉后端按“创建时间”排序
      isAsc: 'desc'                // desc 代表“降序”（最新的在上面）
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        studentName: [
          { required: true, message: "学生姓名不能为空", trigger: "blur" }
        ],
      }
    }
  },
// 1. 页面初始化时执行
  created() {
    this.getList();
    this.checkRouteParams(); // 抽取出来的通用方法
  },

  // 2. 页面被缓存重新激活时执行 (这是 vue-router 的特性)
  activated() {
    this.checkRouteParams(); // 再次检查有没有新参数传过来
  },
  
  methods: {
    /** * 核心修复：统一处理路由参数 
     * 作用：接收从日记页传过来的 建议、姓名、风险等级
     */
    checkRouteParams() {
      const advice = this.$route.query.advice;
      const name = this.$route.query.name;
      const level = this.$route.query.level; // <--- 【关键新增】获取风险等级

      // 只要有任意一个参数，就视为“转录”操作
      if (advice || name || level) {
        console.log("检测到转录参数 - 姓名:", name, "等级:", level);
        
        this.reset(); // 先重置表单，清空旧数据
        
        // 自动回填数据
        this.form.aiSuggestion = advice;
        this.form.studentName = name;
        
        // 【关键逻辑】如果有等级，自动选中下拉框
        if (level) {
          this.form.riskLevel = level; 
        }
        
        this.open = true; // 打开弹窗
        this.title = "新增心理干预记录 (AI 智能转录)";
        
        // (可选) 建议清空路由参数，防止刷新页面时重复弹窗
        // this.$router.replace({ path: this.$route.path, query: {} });
      }
    },
    /** 查询心理干预记录列表 */
    getList() {
      this.loading = true
      listRecord(this.queryParams).then(response => {
        this.recordList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        recordId: null,
        studentName: null,
        riskLevel: null,
        aiSuggestion: null,
        handlerName: null,
        content: null,
        status: "0",// <--- 修改这里：默认设为 "0" (待处理)
        createTime: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.recordId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加心理干预记录"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const recordId = row.recordId || this.ids
      getRecord(recordId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改心理干预记录"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.recordId != null) {
            updateRecord(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addRecord(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const recordIds = row.recordId || this.ids
      this.$modal.confirm('是否确认删除心理干预记录编号为"' + recordIds + '"的数据项？').then(function() {
        return delRecord(recordIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/record/export', {
        ...this.queryParams
      }, `record_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
