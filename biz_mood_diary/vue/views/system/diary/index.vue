<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学生ID(关联sys_user表)" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入学生ID(关联sys_user表)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="情绪评分(0-100分)" prop="moodScore">
        <el-input
          v-model="queryParams.moodScore"
          placeholder="请输入情绪评分(0-100分)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="情绪标签(如:焦虑/开心/平淡)" prop="moodTag">
        <el-input
          v-model="queryParams.moodTag"
          placeholder="请输入情绪标签(如:焦虑/开心/平淡)"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['system:diary:add']"
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
          v-hasPermi="['system:diary:edit']"
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
          v-hasPermi="['system:diary:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:diary:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="diaryList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="学生ID(关联sys_user表)" align="center" prop="userId" />
      <el-table-column label="日记内容(支持表情)" align="center" prop="content" />
      <el-table-column label="情绪评分(0-100分)" align="center" prop="moodScore" />
      <el-table-column label="情绪标签(如:焦虑/开心/平淡)" align="center" prop="moodTag" />
      <el-table-column label="AI给出的建议" align="center" prop="aiAdvice" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:diary:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:diary:remove']"
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

    <!-- 添加或修改学生心情日记对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学生ID(关联sys_user表)" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入学生ID(关联sys_user表)" />
        </el-form-item>
        <el-form-item label="日记内容(支持表情)">
          <editor v-model="form.content" :min-height="192"/>
        </el-form-item>
        <el-form-item label="情绪评分(0-100分)" prop="moodScore">
          <el-input v-model="form.moodScore" placeholder="请输入情绪评分(0-100分)" />
        </el-form-item>
        <el-form-item label="情绪标签(如:焦虑/开心/平淡)" prop="moodTag">
          <el-input v-model="form.moodTag" placeholder="请输入情绪标签(如:焦虑/开心/平淡)" />
        </el-form-item>
        <el-form-item label="AI给出的建议" prop="aiAdvice">
          <el-input v-model="form.aiAdvice" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="删除标志(0代表存在 2代表删除)" prop="delFlag">
          <el-input v-model="form.delFlag" placeholder="请输入删除标志(0代表存在 2代表删除)" />
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
import { listDiary, getDiary, delDiary, addDiary, updateDiary } from "@/api/system/diary"

export default {
  name: "Diary",
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
      // 学生心情日记表格数据
      diaryList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        content: null,
        moodScore: null,
        moodTag: null,
        aiAdvice: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "学生ID(关联sys_user表)不能为空", trigger: "blur" }
        ],
        content: [
          { required: true, message: "日记内容(支持表情)不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询学生心情日记列表 */
    getList() {
      this.loading = true
      listDiary(this.queryParams).then(response => {
        this.diaryList = response.rows
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
        id: null,
        userId: null,
        content: null,
        moodScore: null,
        moodTag: null,
        aiAdvice: null,
        createTime: null,
        updateTime: null,
        delFlag: null
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加学生心情日记"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getDiary(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改学生心情日记"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateDiary(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addDiary(this.form).then(response => {
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
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除学生心情日记编号为"' + ids + '"的数据项？').then(function() {
        return delDiary(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/diary/export', {
        ...this.queryParams
      }, `diary_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
