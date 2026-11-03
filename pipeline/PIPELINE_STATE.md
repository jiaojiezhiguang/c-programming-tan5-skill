# PIPELINE_STATE — C程序设计（第五版）蒸馏

> 本文件记录 cangjie-skill 蒸馏流水线的当前阶段与进度，用于断点续跑。更新：2026-11-03

## 文字源

| 项 | 值 |
|---|---|
| **采用文件** | `C程序设计（第五版） (谭浩强) (9787302481447).docx`（带文字层，5.3 MB） |
| 提取方式 | python-docx 抽取段落 → `_book_text.md`（8344 段 / 387,782 字） |
| 弃用来源 | 原始 137MB `.md`（base64 内嵌扫描图，剥图后仅 789 字符）；3 个 PDF（PyMuPDF 检测文字层均为 0） |
| OCR 备用路径 | 已装 easyocr 1.7.2 + torch 2.15 CPU，跑通前 29 页后放弃——docx 文字版保真度远高于 OCR |

## 阶段进度

- [x] 阶段 0 前置：源文件验证（4 个来源均为扫描图，最终由用户提供带文字层 docx）
- [x] 阶段 0：整书理解 → `BOOK_OVERVIEW.md`（已用 docx 核对精确定位，8 个 task 全覆盖）
- [x] 阶段 1：提取候选 → `candidates/` 5 个文件（framework×10、principle×17、case×18、counter-example×18、glossary×70）
- [x] 阶段 1.5：三重验证 → **63 条候选原文锚点全部机械核验通过**（脚本比对 `_book_text.md`）
- [x] 阶段 1.6：晋级门 → 6 promoted + 4 router；`destinations.json` 已同步；可发现入口 7 ≤ 预算 8
- [x] 阶段 2：RIA++ 能力卡 → `cards/` 10 张（R/I/A1/A2/E/B 六段齐备）
- [x] 阶段 3：Zettelkasten → `also_read` 关系；`GLOSSARY.md`、`book/overview.md`
- [x] 阶段 4：压力测试 → **71 用例，独立 sub-agent 盲测，6 个能力全部 F1 = 1.000**（兄弟混淆 0）
- [x] 阶段 4b：输出质量 → 机械断言 new_skill 6/6 vs without_skill 6/6；匿名 A/B 语义盲评 **3:3**
- [x] 阶段 5 编译 → `dist/` 7 个可发现入口（1 路由 + 6 晋级），`validate_skill_pack` **0 errors / 0 warnings**
- [x] 阶段 5 文档 → `DIGEST.md`（6,152 中文字）、`INDEX.md`、`GLOSSARY.md`
- [x] 阶段 5 安装 → **已安装**到 `~/.workbuddy-ai/skills/`（7 个入口，frontmatter 与 references 已校验）

## 产物清单

```
cangjie-books/c-programming-5th-tan/
├── BOOK_OVERVIEW.md        阶段0 整书理解
├── DIGEST.md               精华长文（面向读者，按书骨架组织）
├── INDEX.md                能力索引（从 Bundle 生成）
├── GLOSSARY.md             70 条术语
├── PIPELINE_STATE.md       本文件
├── _book_text.md           干净全文（蒸馏事实源）
├── candidates/             5 类候选（含原文锚点）
├── .cangjie/capabilities/
│   ├── verified.yaml       唯一可编译事实源（10 能力）
│   ├── destinations.json   去向清单
│   ├── cards/              10 张能力卡
│   ├── book/               overview.md / glossary.md
│   ├── evals/              6 套测试用例 + 判分报告
│   └── test-results.md     阶段4 总结（含可信度声明与修正记录）
└── dist/                   编译产物（7 入口，可安装）
    ├── program-skeleton/  algorithm-design/  control-flow/
    ├── array-and-string/  function-and-recursion/  pointer-model/
    ├── c-programming-tan5-reference/   ← 路由入口（含 10 张能力卡 + index + cheatsheet）
    ├── DIGEST.md / INDEX.md / GLOSSARY.md
    ├── capability-destinations.json
    └── BUILD_MANIFEST.json
```

## 评测结果摘要

| 指标 | 结果 | 数据属性 |
|---|---|---|
| 触发精度（71 用例） | 6 能力 F1 全 **1.000**，兄弟混淆 0/12 | 迭代后达成，**已过拟合**，不代表泛化 |
| **router 可达性（13 用例）** | **13/13 = 100%** | 首次测，未见数据 |
| **Holdout-1 验收（23 用例）** | **20/23 = 87.0%** | **真实未见数据**，暴露 2 个真缺陷 |
| **Holdout-2 终局（16 用例）** | 最优 **93.8%** / 可达 **100%** | 未见数据，修复后 |
| **独立题集（20 用例 × 3 采样）** | 最优 **91.7%** / 可达 **100%** / 稳定性 18/20 | **题目由第三方 agent 独立生成，最可信** |
| 输出质量（机械断言，29 条） | new 6/6 vs baseline 6/6 | 持平 |
| 输出质量（匿名 A/B 盲评） | new 3 胜 / baseline 3 胜 | 持平 |

**最终可宣称的数字**（来自独立题集，题目由未看过描述的 agent 生成）：
- **最优路径命中率 ≈ 91.7%**
- **最终可达率 = 100%**
- **逐题稳定性 18/20**

**不可宣称**：首轮 F1=1.000（作者自写题，已过拟合）；任何"输出质量提升"（A/B 3:3 平局）。

三轮验证过程中共修掉 **5 个真缺陷**（注释触发缺失、模块划分与函数实现抢触发、"所有乱码"过宽、malloc/free 描述缺口、排序归属），并承认 **1 处标注偏差**。已在独立题集上停止调优，不再据此改描述。

**诚实结论**：触发精度是这套产物的独有优势（泛化模型不知道该用哪张卡）；但在"单题作答正确性"上，能力足够的通用模型与带技能的模型**持平**。技能包的真实价值在可发现性、方法一致性和边界自觉，不在单题质量提升。详细分析与全部修正记录见 `.cangjie/capabilities/test-results.md`。

## 未完成项（不掩盖）

1. **`old_skill` 变体缺失**：首次发布无旧版可对照，三变体退化为两变体。
2. ~~单次采样~~ → 独立题集已做 3 次采样（稳定性 18/20）；其余套件仍为 `runs=1`。
3. **输出评测样本偏小**：只用 6 个任务；`without_skill` 基线是同一模型，不是人类基线。
4. **无真实使用数据**：技能包默认不上报，没有线上触发记录。
5. **`DIGEST.md` / `INDEX.md` / `GLOSSARY.md` 为编译后追加**：编译器不认识这三个文件，重新编译会丢失，需手动从 pack 根复制回 `dist/`（已写入下方"下一步"）。

> 原"validation 未验收"与"router 可达性未测"两项**已补做**，见 `test-results.md` 附录。

## 下一步

- `darwin evolve`：用 `evals/` 下用例做 ratcheting 自动进化。
- 重编译后别忘了恢复文档：`cp DIGEST.md INDEX.md GLOSSARY.md dist/`。
- 若要补做验证：额度充足时对 4 个 router 能力单独测可达性；把 `runs` 提到 3 重跑以看稳定性。

## 已知风险

- 书中 C 代码在 docx 中部分片段被压缩（如 `#include<stdio.h> int main( )` 合为一行），蒸馏时已按语义还原，但逐字引用处可能与原书排版不同。
- docx 为他人整理版（非出版社排版文件），个别地方有 OCR 残留错字（如 `%1f` 实为 `%lf`），已在相应卡片中用注说明。
- 技能包基于 C99/Visual C++ 6.0 时代的教材内容，用户若用现代编译器（GCC 13+/Clang），部分示例会触发新警告，卡片的 B 段已声明此局限。
