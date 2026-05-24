# Math Modeling Skills

数学建模竞赛全套工具链 —— 解题 + 写作。覆盖国赛(CUMCM)和美赛(MCM/ICM)。

基于 **72 篇国赛一等 + 24 篇美赛 O/F 奖论文** 的系统分析。

## 包含的 Skill

### `math-modeling-solver` — 解题指导

从拿到赛题到出代码的完整建模方案。

| 功能 | 说明 |
|------|------|
| 问题拆解 | 12 种数学本质类型自动判定 |
| 模型匹配 | 95+ 场景决策矩阵，含首选/备选/边界条件 |
| 算法展开 | 5 本 Cookbook（优化/ML/评价/机理/统计） |
| 代码生成 | 22 个 Python + 7 个 MATLAB 可运行模板 |
| 案例参考 | 11 本 Playbook（国赛 8 + 美赛 3），含完整例题走通 |
| 美赛专项 | 模型命名策略、Memo/Letter 框架、Our Work 流程图 |

### `math-modeling-paper` — 论文写作

从结构规划到最终排版的全流程指导。

| 功能 | 说明 |
|------|------|
| 结构模板 | 国赛/美赛双赛道标准结构 |
| 摘要指导 | 中英双语模板 + 获奖实例 |
| 模型检验 | 灵敏度分析/误差分析/鲁棒性检验方法大全 |
| 图表规范 | 流程图/数据图/伪代码绘制标准 |
| 学术句式 | 中英双语常用句式库 |
| 排版检查 | LaTeX/Word 检查清单 |
| Memo/Letter | 美赛 B-F 题 Memo 和 Letter 写作框架 |

## 安装

```bash
cd ~/.claude/skills/
git clone https://github.com/Lupynow/math-modeling-paper.git
# 重启 Claude Code 即可自动加载两个 skill
```

## 使用流程

```
拿到赛题
  ↓
启动 math-modeling-solver
  ├─ 阶段1: 拆题分析（12种数学本质判定）
  ├─ 阶段2: 模型匹配（95+场景决策矩阵）
  ├─ 阶段3: 算法展开 + 代码生成（22个Python模板）
  └─ 阶段4: 论文衔接 → [PAPER_READY]
  ↓
切换到 math-modeling-paper
  ├─ 规划 → 写作 → 润色 → 检查
  ↓
交卷
```

## 文件结构

```
math-modeling-paper/          # 仓库根目录
├── README.md
├── SKILL.md                  # math-modeling-paper 主文件
├── references/
│   ├── abstract-writing.md
│   ├── common-phrases.md
│   ├── cumcm-guide.md
│   ├── figure-and-code-guide.md
│   ├── mcm-icm-guide.md
│   ├── memo-writing.md
│   ├── model-validation.md
│   └── problem-type-strategies.md
└── math-modeling-solver/     # solver skill（子目录）
    ├── SKILL.md
    └── references/
        ├── problem-decomposition.md
        ├── model-selection-matrix.md
        ├── paper-bridge.md
        ├── mcm-specific-guide.md
        ├── cookbook-*.md (5本)
        ├── code-templates/  (29 files)
        └── playbooks/       (11 files)
```

## License

MIT
