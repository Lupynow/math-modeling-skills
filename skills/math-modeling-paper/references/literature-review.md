# 文献查阅与综述写作指南

## 文献在数学建模竞赛中的三个作用

文献不是只为了填充「参考文献」章节。它在比赛中扮演三个关键角色：

| 阶段 | 作用 | 典型问题 |
|------|------|---------|
| **选模型之前** | 了解这类问题学术界通常用什么方法，避免闭门造车 | 「别人怎么解这种题的？」 |
| **建模过程中** | 为参数取值、假设合理性、模型结构提供外部证据 | 「这个参数的典型值是多少？」 |
| **写论文时** | 在研究背景和模型选择理由中引用，提升学术可信度 | 「为什么选这个方法？有文献支持吗？」 |

---

## 第一部分：文献检索

### 1.1 检索时机

```
拿到题目 → 拆题分析(阶段1) → 🔍 文献检索 → 模型匹配(阶段2)
```

在拆完题、明确了每个子问题的数学本质后，**先搜索再选模型**。花 20-30 分钟检索，可以避免方向性错误。

### 1.2 构建检索词

从题目中提取核心概念，组合为检索式：

**公式**：`[问题核心概念] + [方法关键词] + [场景限定词]`

**示例**：

| 题目场景 | 核心概念 | 方法关键词 | 检索式示例 |
|---------|---------|-----------|-----------|
| 工厂 RGV 动态调度 | RGV scheduling | optimization / genetic algorithm | `"rail guided vehicle" scheduling optimization` |
| 玻璃文物成分分类 | glass classification | clustering / classification | `ancient glass composition classification machine learning` |
| 生态系统食物网 | food web | Lotka-Volterra / network | `"food web" stability analysis ODE` |
| 信贷风险评估 | credit risk | evaluation / TOPSIS / entropy | `credit risk assessment entropy weight TOPSIS` |
| 奥运奖牌预测 | Olympic medal | prediction / regression / Bayesian | `Olympic medal prediction Bayesian hierarchical` |
| 热传导温度曲线 | heat transfer | PDE / finite element | `reflow soldering temperature profile heat transfer` |

**技巧**：
- 中英文都搜。中文用知网，英文用 Google Scholar / Semantic Scholar
- 先宽后窄：先用宽泛关键词了解领域概况，再精确锁定相关方法
- 加模型名作为方法关键词（如 `genetic algorithm scheduling`）可以快速找到直接可参考的论文

### 1.3 检索渠道

| 渠道 | 适用场景 | 访问方式 | 优缺点 |
|------|---------|---------|--------|
| **Google Scholar** | 英文文献首选 | scholar.google.com | 覆盖面广，引用追踪好；需要翻墙 |
| **Semantic Scholar** | 英文文献，AI 辅助筛选 | semanticscholar.org | 免费，自带 TLDR 摘要，引用图谱；覆盖稍少 |
| **知网 (CNKI)** | 中文期刊、硕博论文 | cnki.net（学校 VPN） | 国赛引用首选；英文文献覆盖少 |
| **arXiv** | 最新预印本，方法前沿 | arxiv.org | 免费，更新快；未经同行评审 |
| **IEEE Xplore** | 工程/优化/信号处理 | ieeexplore.ieee.org | 优化算法和工程建模权威来源 |
| **Web of Science** | 高质量期刊筛选 | webofscience.com | 收录标准高，结果偏少 |
| **Connected Papers** | 文献关联图谱 | connectedpapers.com | 输入一篇论文，找到相关研究网络 |
| **万方/维普** | 中文文献备选 | 学校图书馆 | 与知网互补 |

**比赛实操建议**：
- **首选**：Google Scholar（英文）+ 知网（中文），各搜 3-5 个检索式
- **辅助**：Semantic Scholar 的 TLDR 功能快速判断论文相关性
- **深挖**：找到一篇高度相关的论文后，用 Connected Papers 或 Google Scholar 的「被引用」和「相关文章」扩展

### 1.4 筛选标准

搜到几十篇论文后，按以下优先级筛选出 5-10 篇精读：

1. **最相关** — 问题和你的赛题高度相似（场景、方法、数据）
2. **期刊含金量高** — 优先 SCI/EI/中文核心期刊，避免引用普刊/会议短文/学报（见 1.5 节期刊分级）
3. **方法可操作** — 论文中的方法你能用 Python/MATLAB 复现
4. **近 5-10 年** — 优先 2020 年后，经典方法可追溯到 2000 年左右
5. **高引用** — 优先高引用论文（领域基准方法）
6. **有代码/数据** — GitHub 有实现更佳，可直接验证

**快速筛选流程**：
```
搜索结果 50 篇（先过滤掉非SCI/EI/核心的普刊，剩余约 25 篇）
  → 看标题筛到 15 篇（优先 Q1/Q2 期刊和高引用论文）
    → 读摘要筛到 6 篇
      → 精读 introduction + method 筛到 3-5 篇（确保至少 2 篇来自好期刊）
        → 这 3-5 篇就是你论文的核心参考文献
```

### 1.5 期刊含金量分级

比赛引用文献的含金量直接影响评审对论文学术深度的判断。优先引用高级别期刊。

**英文期刊分级**：

| 级别 | 标识 | 典型期刊 | 含金量 |
|------|------|---------|--------|
| **顶级 SCI** | JCR Q1，影响因子 >5 | Nature, Science, PNAS, Nature子刊 | ★★★★★ 极高（比赛中罕用，除非做综述） |
| **权威 SCI** | JCR Q1-Q2，影响因子 2-10 | IEEE TEC, Mathematical Programming, Operations Research, SIAM J. Optimization, Water Resources Research, Environmental Science & Technology | ★★★★ 高（模型方法论的黄金来源） |
| **主流 SCI** | JCR Q2-Q3 | Applied Mathematical Modelling, European J. Operational Research, Computers & Operations Research, Mathematical Biosciences, Ecological Modelling, Journal of Cleaner Production | ★★★ 中高（应用类论文主力来源） |
| **EI 期刊** | Engineering Index 收录 | 多数 IEEE 会议转期刊、Engineering Applications of AI, Expert Systems with Applications | ★★★ 中 |
| **EI/SCI 会议** | 顶会论文 | AAAI, NeurIPS, ICML, IEEE CEC（进化计算）, GECCO | ★★☆ 中（计算机/优化领域的顶会含金量不输期刊） |
| **普通 SCI** | JCR Q3-Q4 | Mathematical Problems in Engineering 等 | ★★ 偏低（慎用，部分水刊审稿宽松） |
| **无检索** | 未被 SCI/EI 收录 | 多数开放获取新刊（MDPI部分期刊除外） | ★ 低（尽量不引用） |

**中文期刊分级**：

| 级别 | 典型期刊 | 含金量 |
|------|---------|--------|
| **一级学报** | 数学学报、应用数学学报、系统工程理论与实践、运筹与管理、控制与决策、管理科学学报 | ★★★★ 高 |
| **EI 中文刊** | 控制理论与应用、模式识别与人工智能、软件学报 | ★★★★ 高 |
| **核心期刊** | 大多数被 PKU 核心/CSSCI/CSCD 收录的大学学报和领域期刊 | ★★★ 中 |
| **普通期刊** | 未入库的非核心期刊 | ★☆ 低（尽量不引用） |
| **学位论文** | 硕士/博士论文 | ★★ 可用（适合找详细方法步骤，但论文引用优先期刊） |

**快速判断含金量的方法**：

1. **Google Scholar 搜期刊名** → 看 h5-index。数学建模相关领域 h5-index >30 算好期刊
2. **知网搜期刊名** → 看是否标注「核心期刊」「EI 收录」「SCI 收录」
3. **Master Journal List** (mjl.clarivate.com) → 查是否被 SCI 收录
4. **LetPub** (letpub.com.cn) → 查影响因子、审稿周期、国人占比

**赛场实操建议**：

- 每道赛题的参考文献中，至少引用 **2-3 篇 SCI 期刊论文**（英文），其余的可以是中文核心或教材
- 如果找到的论文来自普通期刊，试着在 Google Scholar 点击「被引用」→ 看看高引用论文是否引用了它并用了类似方法 → 改为引用那篇更好的论文
- 同等条件下（方法相同、场景相同），优先引用期刊论文而非会议论文/学位论文
- 普刊论文如果方法确实直接相关，可以引用，但不要在论文中把它当成「权威来源」来大段论证

### 1.6 阅读重点

对于赛场上的文献，**不需要从头读到尾**。按需阅读：

| 你需要什么 | 重点读哪里 |
|-----------|-----------|
| 这类问题通常用什么方法 | Abstract + Introduction 末尾 |
| 方法的具体公式/算法 | Method / Methodology |
| 方法的适用条件和局限 | Discussion / Conclusion |
| 典型参数值 | Experiment setup 部分 |
| 结果好坏的标准 | Results 中的 baseline 对比 |
| 有什么改进方向 | Future work（最后一段） |

---

## 第二部分：文献支撑模型选择

这是 solver 阶段最关键的用法——用文献证据而不是直觉来推荐模型。

### 2.1 文献→模型推荐的推理链

```
文献中 N 篇论文用方法A解了类似问题，效果达到X
文献中 M 篇论文用方法B解了类似问题，效果达到Y
在本题的约束下（数据规模/可解释性要求/...），
方法A更适用因为...，方法B的不适用条件是因为...
→ 候选模型A（文献支撑，优先级高）
→ 候选模型B（文献支撑，备选）
```

### 2.2 向用户呈现文献支撑的模型推荐

在 solver 阶段2 的模型推荐输出中，增加「文献支撑」维度：

```
| 候选模型A | [模型名] — 更适用于 [条件] |
| 文献支撑 | [3-5篇]: [Author (Year)] 用此方法解决 [场景]，[关键结果] |
| 候选模型B | [模型名] — 更适用于 [条件] |
| 文献支撑 | [2-3篇]: [Author (Year)] ... |
| 选择建议 | 基于文献和本题约束的分析 |
```

### 2.3 常见题型→典型方法→关键文献线索

| 题型 | 高频方法 | 值得搜的方向 |
|------|---------|------------|
| 调度优化 | GA, NSGA-II, PSO, SA | "flexible job shop scheduling NSGA-II" |
| 评价排序 | TOPSIS, AHP, 熵权法, 模糊综合评价 | "multi-criteria decision making [应用场景]" |
| 分类问题 | RF, XGBoost, SVM, Logistic | "[应用场景] classification machine learning" |
| 回归预测 | LASSO, RF, XGBoost, ARIMA | "[应用场景] prediction [方法]" |
| 物理机理 | PDE, ODE, FEM, 热传导/扩散方程 | "[物理现象] mathematical modeling" |
| 网络/图论 | Max Flow, Shortest Path, Centrality | "network flow optimization [场景]" |
| 生态系统 | Lotka-Volterra, 物种分布模型, 碳循环 | "food web dynamics ODE model" |
| 博弈策略 | Nash Equilibrium, Evolutionary Game | "evolutionary game theory [场景]" |

---

## 第三部分：文献综述写作

### 3.1 国赛 vs 美赛 文献综述对比

| 维度 | 国赛 CUMCM | 美赛 MCM/ICM |
|------|-----------|-------------|
| 独立章节 | 通常没有独立的 Literature Review | ~60% 论文有（1.3 Literature Review） |
| 写法 | 在问题分析中穿插引用，论证模型选择理由 | 独立小节，总结现有方法后引出自己的方法 |
| 篇幅 | 嵌入在 1-2 页问题分析中 | 0.5-1 页独立小节 |
| 文献数量 | 正文引用≥6条 | 正文引用≥5条（Literature Review 中一般 3-6 条） |
| 深度要求 | 点到为止：某方法已被用于某问题即可 | 需说明现有方法的局限→你的方法的定位 |
| 语言 | 中文 | 英文 |

### 3.2 美赛 Literature Review 写作模板

**标准三段式结构**（0.5 页）：

```
段落1（2-3句）：问题域概述
  「[问题领域] has been extensively studied. 
   Traditional approaches include [方法A] and [方法B].」
  
段落2（3-4句）：现有方法的局限
  「However, [方法A] suffers from [局限1] when applied to [场景X]. 
   [方法B] addresses [局限1] but introduces [局限2].
   Recent work by [Author (Year)] proposed [方法C] which improves [某方面] 
   but still [仍有不足].」
   
段落3（2-3句）：本模型的定位
  「To address these gaps, our model combines [创新点1] with [创新点2], 
   achieving [目标]. Our approach differs from existing work by [关键差异].」
```

**示例**（2024 MCM C 题网球 momentum 预测）：

> The quantification of momentum in sports has been studied through various statistical frameworks. Early work by Smith et al. (2018) applied Markov chain models to tennis match sequences, while Johnson (2020) proposed a Bayesian approach incorporating player-specific priors. However, Markov-based methods struggle to capture the non-stationary nature of momentum swings, and Bayesian approaches often require extensive historical data that may not generalize across tournaments.
>
> Our model innovatively combines an LSTM framework for temporal pattern recognition with a graph neural network that encodes player interaction dynamics. Unlike existing approaches that treat momentum as a univariate time series, our two-stream architecture jointly models performance metrics and psychological indicators, achieving more robust predictions across diverse match conditions.

### 3.3 国赛文献引用写法

国赛没有独立的 Literature Review，文献引用分布在两处：

**位置1 — 问题分析中论证模型选择理由**：

> 针对 RGV 动态调度问题，目前学术界主要采用遗传算法[1]和粒子群算法[2]两类启发式方法。郭明等(2024)对比发现，在设备数量超过5台的场景下，遗传算法的收敛速度和求解质量均优于粒子群算法[3]。考虑到本题涉及8台CNC的调度，选择自适应遗传算法作为求解框架，并通过引入精英保留策略改善早熟收敛问题。

**位置2 — 模型建立中引用方法来源**：

> 本文采用改进的 TOPSIS 法进行综合评价[4]。传统 TOPSIS 法采用欧氏距离计算贴近度，但当指标间存在相关性时，马氏距离能更准确地反映样本间的差异[5]。

### 3.4 常见错误

| 错误 | 为什么不行 | 正确做法 |
|------|-----------|---------|
| **综述写成教科书式介绍** | 「遗传算法是一种模拟自然进化的优化方法，由 Holland 于 1975 年提出……」— 评委不需要你科普 | 直接说「遗传算法已被广泛应用于车间调度[1-3]，但在大规模实例中收敛速度不足[4]。本文通过 XX 改进解决此问题。」 |
| **引用过时或无关文献** | 引用 1990 年代的论文来说「最近研究」 | 优先 2020 年后。引经典方法时注明是基础文献 |
| **文献全是方法类，没有应用类** | 只引了 GA/PSO 的原始论文，没有引这些方法在你赛题领域的应用 | 方法原始文献 + 领域应用文献 = 2:3 比例 |
| **引而不述** | 「[1]用 GA 解了调度问题。[2]用 PSO 解了调度问题。」— 没有对比、没有判断 | 必须说清楚：哪篇的方法更好？为什么？你的模型在哪篇基础上做了改进？ |
| **引了非学术来源** | CSDN、知乎、百度百科、AI 对话 | 找到这些来源引用的原始论文，引用原始论文 |

---

## 第四部分：参数溯源

### 4.1 何时需要文献支撑参数

建模中任何**不是从题目数据中拟合出来的参数**都需要说明来源：

| 参数类型 | 来源 | 示例 |
|---------|------|------|
| 物理常数 | 教材/手册 | 重力加速度 g=9.8 m/s²、气体常数 R=8.314 J/(mol·K) |
| 领域经验值 | 期刊论文 | 种群内禀增长率 r=0.03/day（Fahrig, 2002）、碳排放因子 2.46 kgCO₂/kg（IPCC, 2019） |
| 模型超参数 | 论文/实验 | LSTM hidden layer=64（Zhang et al., 2023 的推荐设置） |
| 经济/社会参数 | 统计年鉴/国家标准 | 折现率=5%（建设项目经济评价方法与参数，第三版） |

### 4.2 参数溯源写法

```
参数值（来源，年份）

示例：
- 碳捕集效率 η = 0.85（IPCC Special Report on CCS, 2005）
- 人口自然增长率 r = 0.0052/year（中国统计年鉴 2023）
- 捕食率 a = 0.03 prey/(predator·day)（Turchin, 2003, p.84）
```

**红线**：任何没有题目数据支撑也没有文献出处的参数值，在评审中会被质疑为「随意设定」。

---

## 第五部分：引用格式速查

### 5.1 国赛引用格式（GB/T 7714-2015 简化版）

**正文引用**：上标序号 `[1]` 或 `[1,2]` 或 `[1-3]`

**参考文献列表**：

```
期刊论文：
[1] 作者. 题名[J]. 刊名, 年份, 卷(期): 起止页码.
例：[1] 郭明, 张强, 李华. 基于改进遗传算法的RGV动态调度研究[J]. 运筹与管理, 2024, 33(2): 45-52.

教材/专著：
[2] 作者. 书名[M]. 版本. 出版地: 出版社, 年份.
例：[2] 姜启源, 谢金星, 叶俊. 数学模型[M]. 5版. 北京: 高等教育出版社, 2018.

学位论文：
[3] 作者. 题名[D]. 学校, 年份.
例：[3] 王芳. 基于深度学习的玻璃文物成分分类研究[D]. 西北大学, 2023.

英文期刊：
[4] Author A, Author B. Title[J]. Journal, Year, Volume(Issue): Pages.
例：[4] Deb K, Pratap A, Agarwal S, et al. A fast and elitist multiobjective genetic algorithm: NSGA-II[J]. IEEE Transactions on Evolutionary Computation, 2002, 6(2): 182-197.
```

### 5.2 美赛引用格式（APA / IEEE 任选）

**APA 正文引用**：`(Author, Year)` 如 `(Deb et al., 2002)`

**APA 参考文献**：
```
Deb, K., Pratap, A., Agarwal, S., & Meyarivan, T. (2002). A fast and elitist multiobjective 
  genetic algorithm: NSGA-II. IEEE Transactions on Evolutionary Computation, 6(2), 182-197.
```

**IEEE 正文引用**：`[1]`, `[2]`

**IEEE 参考文献**：
```
[1] K. Deb, A. Pratap, S. Agarwal, and T. Meyarivan, "A fast and elitist multiobjective 
    genetic algorithm: NSGA-II," IEEE Trans. Evol. Comput., vol. 6, no. 2, pp. 182-197, 2002.
```

### 5.3 快速决策：选哪个格式

- 国赛 → GB/T 7714
- 美赛 → 看组委会当年要求，无明确要求则用 APA（最通用）
- 引用英文论文时 → 保持原文语言，不翻译

---

## 第六部分：AI 工具在文献检索中的使用

### 6.1 可以做的（用 AI 辅助检索）

- 用 Semantic Scholar 的 AI 摘要功能快速判断论文相关性
- 用 Connected Papers 的图谱功能发现相关论文网络
- 让 Claude 帮你从论文 PDF 中提取关键公式和参数
- 用 AI 翻译非母语论文的摘要
- 让 Claude 帮你生成检索关键词

### 6.2 绝对不做的（红线）

- **不引用 AI 工具**（ChatGPT/DeepSeek/Claude 等）作为参考文献来源
- **不直接用 AI 生成的文献**而不验证（AI 会编造不存在的论文）
- **不复制 AI 输出的通用描述**作为「文献综述」

### 6.3 验证 AI 给的文献

AI 可能「发明」看起来合理的论文。每次 AI 推荐文献后：

1. 在 Google Scholar / 知网搜索该论文标题
2. 确认作者、年份、期刊名是否匹配
3. 如果能找到全文，快速阅读摘要确认内容
4. **找不到的论文绝对不引用**

---

## 第七部分：文献检索→模型推荐 实操流程（给 solver 用）

当 solver 在阶段1完成拆题后，执行以下文献辅助流程：

```
Step A: 生成检索式
  对每个子问题，组合 [核心概念] + [方法关键词] 生成 2-3 个检索式

Step B: 检索（告知用户自己去做，或直接在对话中协助）
  告知用户：建议在 Google Scholar 和知网分别搜索以下关键词...
  （如用户在对话中要求协助，用 WebSearch 工具代为检索）

Step C: 提取方法证据
  从检索结果中提取：
  - 哪些方法被用于类似问题
  - 各方法的优缺点对比
  - 典型性能指标（准确率/MSE/收敛速度等）

Step D: 融入模型推荐
  在阶段2的推荐输出中，对每个候选模型附上文献证据
```

这样用户看到的不只是「矩阵说该用 XGBoost」，而是「近年来 5 篇类似问题的论文中有 4 篇用了 XGBoost，且 Liu (2024) 对比发现 XGBoost 在你的数据规模下比随机森林准确率高 8%」。
