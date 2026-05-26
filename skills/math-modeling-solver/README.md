# Math Modeling Solver — 数学建模竞赛解题指导

> 从拆题到代码的完整建模方案。与 `math-modeling-paper` 形成"解题→写作"配对。

## 功能

- **五阶段解题工作流**：拆题分析 → 文献检索 → 模型匹配 → 算法展开+代码生成 → 论文衔接
- **模型决策矩阵**：覆盖 12 种问题本质类型，每种含首选/备选模型及选择理由
- **8 本算法 Cookbook**：优化/ML/评价/机理/统计/图论网络/聚类/博弈论
- **29 个可运行代码模板**：22 Python + 7 MATLAB，含问题适配注释
- **12 本 Playbook**：完整例题端到端走通，拆题到代码全流程
- **论文桥接**：输出可直接嵌入 `math-modeling-paper` 的论文草稿片段

## 安装

```bash
cd ~/.claude/skills/
git clone https://github.com/Lupynow/math-modeling-solver.git
```

重启 Claude Code 即可自动加载。

## 使用方式

```
这道题怎么建模：[粘贴赛题文本]
2024 国赛 A 题板凳龙用什么模型？
我已经拆完题了，帮我选模型：[分析文本]
给我写一个带约束的 GA 代码框架
C 题数据预测，XGBoost 和随机森林怎么选？
```

## 搭配使用

- `math-modeling-paper`：解题完成后切换到论文写作
- `nature-figure`：科研级图表
- `xlsx`：数据清洗与分析

## 文件结构

```
math-modeling-solver/
├── SKILL.md
└── references/
    ├── problem-decomposition.md
    ├── model-selection-matrix.md
    ├── paper-bridge.md
    ├── mcm-specific-guide.md
    ├── cookbook-optimization.md     (优化)
    ├── cookbook-ml.md               (机器学习)
    ├── cookbook-evaluation.md       (评价)
    ├── cookbook-mechanistic.md      (机理)
    ├── cookbook-statistical.md      (统计)
    ├── cookbook-network.md          (图论/网络)
    ├── cookbook-clustering.md       (聚类)
    ├── cookbook-game-theory.md      (博弈论)
    ├── code-templates/
    │   ├── python/   (22 个模板)
    │   └── matlab/   (7 个模板)
    └── playbooks/     (12 本端到端例题)
```

## License

MIT
