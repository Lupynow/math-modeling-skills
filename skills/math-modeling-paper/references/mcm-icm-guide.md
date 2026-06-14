# 美赛 (MCM/ICM) 详细写作指南

## 评审机制与写作策略

美赛评审特点（基于 2024-2025 年 80 篇 Outstanding/Finalist 论文分析）：
- 评委是国际学者，看重建模**创新性**和**方法论**
- 数学推导的原创性远比代码实现细节重要
- 模型需要有多层结构，不是单一算法
- **Our Work 流程图近乎必须**：几乎每篇 Outstanding 论文都有整体建模框架图
- 灵敏度分析独立成章的比例约 50%，另一半嵌入在模型评价章节中
- 英文文法小瑕疵可被容忍，但结构缺失不可

## 各章节详细写法

### Summary Sheet（独立1页，最关键的1页）

这是评委最先读的，有时也是唯一读完的内容。Outstanding 论文的 Summary 约 **400-550 词**。

**强制检查清单**：
- [ ] 有 Hook 句吗？
- [ ] 每个 Task 的模型有名字和缩写吗？
- [ ] 每个 Task 有量化结果吗？（NRMSE/R²/覆盖率/具体预测值）
- [ ] 有至少一个置信区间或误差指标吗？
- [ ] 关键词有 5-8 个吗？
- [ ] 每个模型缩写首次出现时展开了全称吗？

**结构模板**：

```
[Hook句 - 1句，有修辞感]
"Golden competition, glorious shine — but behind every medal lies a complex web of national investment, coaching excellence, and statistical uncertainty."

[问题陈述 - 1-2句]
We develop a comprehensive framework to forecast Olympic medal counts, quantify prediction uncertainty, and analyze the "Great Coach Effect."

[Task 1 - 模型名+方法+结果，3-4句]
We propose CHAMPS (Comprehensive Hierarchical Athletic Medal Prediction System), integrating a Tobit model to handle the medal count censoring problem with Bayesian change-point detection. Our model achieves NRMSE = 0.07 on historical data, with 93.2% coverage for 95% prediction intervals. The United States is predicted to lead with 122 total medals.

[Task 2 - 同上]
For uncertainty quantification, we employ Bootstrap resampling (n=10,000) combined with Monte Carlo simulation. ...

[Task 3 - 同上]

[Task 4 - 同上，如果有]

[结论 - 1-2句]
Our integrated framework demonstrates that ... Sensitivity analysis via Sobol' indices confirms that GDP (elasticity 0.42) and host nation advantage (+12% medal boost) are the dominant drivers.

Keywords: Olympic Medal Prediction, Tobit Model, Bayesian Change-Point Detection, Sobol' Sensitivity Analysis, Bootstrap Uncertainty Quantification, XGBoost Ensemble
```

**模型命名提示**：好的模型缩写（如 FATE、CHAMPS、HARMONIE）拼成有意义的英文单词，3-6 个字母。在 Summary 中首次出现时必须展开全称（如 "FATE (Forest-to-Agriculture Transition Ecosystem)"）。

### Introduction（2-3页）

**1.1 Problem Background**（0.5-1页）：问题域的介绍。**放一张问题场景照片/示意图**（如灯塔照片、奥运五环、雨林图片）——几乎每篇 Outstanding 论文都这么做。引用已有研究建立学术语境。

**1.2 Restatement of the Problem**（0.5页）：用 bullet points 列出每个 Task 的核心要求。每个 bullet 1-2 句话。

**1.3 Literature Review**（0.5页，约 60% 论文包含）：简要总结相关方法的研究现状。**不需要深度文献综述**——引用 3-6 篇足够，核心是说明「现有方法的局限 → 你的方法的定位」。如果篇幅紧张，可并入 1.1。

**1.4 Our Work**（0.5页，近乎必须）：用流程图展示整体建模 pipeline。流程图要用英文标注，展示各个模型之间的关系和数据流。**这是 Outstanding 论文的标志性特征之一。**

### Assumptions and Justifications（1-2页）

格式：`Assumption X: [statement]. Justification: [reasoning].`

**5-6 条假设**，每条都要有 Justification。Justification 可以引用文献、数据特征、或领域常识。

例子：
> **Assumption 1: Medal counts follow a censored normal distribution.**
> Justification: Medal counts are non-negative integers with a concentration at zero (countries winning no medals). The Tobit model is specifically designed for such censored data [1]. The assumption of underlying normality is supported by the Central Limit Theorem given the aggregation of multiple independent events.

不要写"Data is accurate"或"The problem is well-posed"等废话。

### Notations Table

英文三线表：Symbol | Definition | Unit

### Data Processing（1-2页，独立章节）

美赛将数据处理作为独立章节（Data Preparation 或 Data Preprocessing），这是加分项。

内容覆盖：
1. Data Collection / Sources
2. Data Cleaning（missing values, outliers）
3. Feature Engineering（derived variables, transformations）
4. Exploratory Data Analysis (EDA)：summary statistics, correlation matrix, initial visualizations

**关键**：每种处理都要说明 WHY，不只是 WHAT。

### Model Building（每个模型4-6页）

**美赛模型写作的核心差异**：每个模型必须是一个"故事"，有完整的概念-推导-实现-验证弧线。

每个模型章节结构：
1. **Model Concept**：给出模型名称+缩写，解释核心思想和直觉
2. **Mathematical Formulation**：从问题出发推导，不是抄教科书
3. **Algorithm**：用伪代码框（Algorithm 1, Algorithm 2...）展示求解过程
4. **Implementation**：关键参数设置和实现细节
5. **Results**：表格+图表+分析
6. **Validation**：本模型的局限性检查（可以引用后面 Sensitivity Analysis 章节）

**关于模型深度**：美赛评委偏好多模型融合而非单一方法。如果你的某个 Task 只用了"paired t-test"，考虑升级为 DID（双重差分）、2SLS（两阶段最小二乘）、或 Bayesian structural time series。

**关于数学推导**：不需要从 textbook 级别推导欧氏距离公式。把你的篇幅留给针对本问题的推导。例如：如果你用 XGBoost，重点不是 XGBoost 的目标函数公式（那是通用的），而是你的特征工程如何映射到本问题的数据特征。

### Sensitivity Analysis（1-3页，必做项）

美赛论文必须包含灵敏度分析，但**不必独立成章**。实际 Outstanding 论文中约 50% 独立设章，50% 嵌入在模型评价/讨论章中。两种方式均可接受。

**最常用方法**（按实际出现频率排序）：
1. **Parameter sweeps**（±10%, ±20%）— 几乎所有论文都做，最基础
2. **Monte Carlo 仿真** — 随机扰动输入，观察输出分布
3. **弹性系数分析** — 计算每个参数的相对影响
4. **Morris 方法** — 全局定性筛选（罕见但加分）
5. **Sobol' indices** — 全局定量分析（极罕见，仅顶级论文）

**实际上大多数论文只对 1-3 个关键参数做局部灵敏度**，不需要每个模型都做全方法覆盖。选择一个最关键的参数，改变 ±10% 和 ±20%，展示输出变化趋势，这已经足够。

国赛嵌入子问题末尾，美赛可独立可嵌入——关键差异在于**必须做**，不在于放哪里。

参考 `model-validation.md` 获取完整方法。

### Strengths and Weaknesses（1页）

每个 Strengths/Weakness 用 `[S1]`, `[S2]`, `[W1]`, `[W2]` 标记。

关键语句：
- Strengths: "Our model innovatively combines..." "Unlike existing approaches that..., we..." "A key strength is..."
- Weaknesses: "A limitation of our approach is..." "The assumption of ... may not hold when..."

**每个 weakness 写具体建模选择带来的局限**（不是通用套话）。映射到具体改进方案是加分项，但在实际 Outstanding 论文中并不普遍——不强求。

### References（1页，≥5条）

来源要求：学术期刊 > 会议论文 > 学位论文 > 教材 > 官方报告。Wikipedia 在实际获奖论文中被频繁引用（视为事实性数据来源），可谨慎使用但不作为学术引用。禁止 blog/CSDN。

格式统一（推荐 APA 或 IEEE）。

### AI Usage Report（1页）

2024 年起美赛要求汇报 AI 工具使用情况。首届约 37% 的论文包含此章节，2025 年已接近普遍包含（接近 100%）。典型内容：
- 列出 AI 工具名称和版本（如 ChatGPT-4o, Nov 2023 version）
- 逐条记录查询内容和 AI 输出
- 常见用途：写作润色、LaTeX 代码生成、概念解释、代码片段

如果没有使用 AI，写明「No AI tools were used in this article」即可。

### Memorandum / Letter（如有，1-2页）

部分年份美赛要求写备忘录（B/D/E/F 题常见）。详细格式和模板见 `memo-writing.md`。

核心要点：
- 受众是决策者，**不出现数学公式**
- 必须有 Date / To / From / Subject 抬头
- 建议逐条列出，可执行
- 长度 ≤ 2 页

## 英文写作要点

### 时态
- Abstract、Introduction 背景：现在时
- 描述你的建模工作：过去时 ("We developed...", "We applied...")
- 描述结果/发现：现在时 ("The results indicate...", "Figure 3 shows...")

### 人称
- 统一用 "we"（第一人称复数），不要混用 "this paper" 或被动语态

### 过渡词
- 序列：First, Subsequently, Furthermore, Finally
- 对比：In contrast, However, On the other hand
- 因果：Consequently, Therefore, As a result, This suggests that
- 总结：In summary, Overall, Taken together

### 图表标题
- Figure X: [描述性标题，完整的句子]
- Table X: [描述性标题]
- 在多面板图中使用 (a), (b), (c) 子图标注

### 常见短语
参考 `common-phrases.md` 获取更多句式。

---

## 英文写作润色策略（nature-polishing 方法论整合）

> 以下内容来自学术写作策略，专门针对中国学生写美赛英文论文的常见问题。

### 中→英三阶段转换

写英文论文时的最大误区是「逐句翻译中文草稿」。正确的三阶段流程：

```
阶段1：提取核心命题
  从中文草稿中提取每段的逻辑主张（而非逐字翻译）
  例：中文「我们先用熵权法算了权重然后丢进TOPSIS里面算分」
     → 命题：Weights were derived via entropy method, then TOPSIS aggregated scores.

阶段2：重建逻辑连接
  英文写作要求显式的逻辑连接词。中文可以靠语序暗示，英文不行。
  补全每段中的：contrast / cause / implication / limitation

阶段3：校准术语、动词强度、hedging
  见下方各小节。
```

### 动词强度校准

英文论文的动词选择直接决定主张的可靠性。用错了动词=给评审提供了攻击面。

| 强度 | 动词 | 使用条件 |
|------|------|---------|
| **强** | show, demonstrate, prove, establish | 有统计显著性（p<0.01）+ 多数据集验证 |
| **中** | indicate, reveal, find, observe | 有实验数据支撑但缺独立验证 |
| **弱** | suggest, imply, appear to, may | 趋势存在但未达显著性或样本小 |
| **最弱** | could, might, potentially | 假设或外推，不是直接观察 |

```
❌ Our model proves that GDP is the dominant factor.
   （除非有严格的因果推断，否则 prove 是 overclaim）

✅ The Sobol' analysis indicates that GDP (elasticity 0.42) is the dominant driver
   among the six factors tested.
   （indicate + 具体数值 + 限定范围 "among the six factors tested"）
```

铁律：**动词强度不能超过证据强度**。如果只有一张图和一个数据集，不要用 `demonstrate`；用 `indicate` 或 `suggest`。

### Results vs Discussion 严格分离

这是中国学生最常混淆的。数模论文中，建模求解章节里经常把「观察到什么」和「这意味着什么」混在一起写。

| | Results（结果描述） | Discussion（结果解释） |
|---|---|---|
| **回答什么问题** | What happened? | What does it mean? |
| **时态** | 过去时 | 现在时 |
| **典型动词** | was detected, increased, showed, enabled, achieved | may reflect, suggests that, could indicate, is likely due to, may facilitate |
| **内容** | 数据+观察+统计 | 解释原因+联系文献+推论+局限 |
| **位置** | 建模求解章节各子问题末尾 | 模型评价与改进章 / 灵敏度分析章 |

```
Results 写法（过去时，报告观察）：
  "When λ increased from 0.01 to 0.1, the F1 score rose from 0.87 to 0.92 (p<0.01).
   Beyond λ=1.0, F1 declined to 0.85."

Discussion 写法（现在时，解释含义）：
  "The decline in F1 beyond λ=1.0 suggests that excessive regularization suppresses
   informative features. This is consistent with the bias-variance tradeoff [3] and
   indicates that λ ∈ [0.05, 0.5] provides a robust operating range for this problem."
```

如果在建模求解章节中必须简要解释结果，控制在 1-2 句，不要展开成一整段 Discussion。

### 句长控制

| 规则 | 数值 |
|------|------|
| 一句话一个主张 | 如果一句包含两个以上的主张→拆成两句 |
| 最优句长 | 15-25 词 |
| 上限 | 30 词/句（超过就拆） |
| 下限 | 不低于 8 词（除非是标题、标注、或技术术语） |
| 段落末句检查 | 每段最后一句往往是全段最长最弱的一句，显式检查它 |

```
❌ (38 words, two claims mashed together)
   Our model combines an LSTM framework for temporal pattern recognition with
   a graph neural network that encodes player interaction dynamics, achieving
   robust predictions across diverse match conditions while maintaining interpretability
   through attention weights.

✅ (split into claim 1 + claim 2)
   Our model combines an LSTM framework for temporal pattern recognition with a
   graph neural network encoding player interaction dynamics (25 words).
   Attention weights provide interpretability: the model achieves robust predictions
   across diverse match conditions while exposing which features drive each forecast
   (22 words).
```

### 沙漏结构

优秀的美赛论文在结构上呈现 **沙漏形**：

```
Introduction: 宽 → 窄
  从问题大背景 → 现有方法的局限 → 本文填补的具体缺口

Model Building（中间窄腰）:
  聚焦于你的模型：推导→求解→验证

Discussion / Conclusion: 窄 → 宽
  从你的具体发现 → 对领域的启示 → 局限和未来工作方向
```

检查方法：读你的 Introduction 最后一段和 Conclusion 第一段——它们应该形成对称的「收窄」和「放宽」，而不是重复同样的内容。

### 段落规则

- **一段一个控制思想**。如果写到一半开始讲新想法→另起一段。
- **段首句 = 段落主张**。读者扫读时只看每段第一句就应该能理解论文的逻辑流。
- **支撑句类型**：数据、对比、解释、推论、文献、局限——选 1-2 种，不要在一段里塞全部类型。
- **段落衔接**：避免连续两段用同样的开头（如连续两段用 "We then..." 或 "This suggests..."）。

```
段落结构示意：

[段首句：控制思想]
  → [支撑数据/对比]
  → [解释/推论]
  → [回到控制思想或过渡到下一段]
```

### 美赛英文润色快速检查清单

论文英文稿完成后，逐项检查：

- [ ] 每句话 ≤ 30 词？
- [ ] 动词强度与证据强度匹配？（有没有不该用 demonstrate 的地方用了？）
- [ ] Results 里有没有混入 Discussion 句式（suggests that / may reflect）？
- [ ] Discussion 里有没有重复 Results 的数据描述？
- [ ] Introduction 是由宽收窄的吗？Conclusion 是由窄放宽的吗？
- [ ] 每段第一句话能独立传达段落主旨吗？
- [ ] 有没有连续两句用同样的开头词？
