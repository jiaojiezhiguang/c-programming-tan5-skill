---
name: c-programming-tan5-reference
description: |
  谭浩强《C程序设计（第五版）》的**结构体与链表、文件读写、调试与测试、术语速查**四类主题入口。
  当用户问：怎么用 struct/typedef struct、. 与 -> 的区别、结构体数组排序、链表怎么建怎么遍历；
  或问 C 怎么读写文件、fopen 返回 NULL、写完文件数据少了一截、feof/EOF 怎么用；
  或问程序跑通了怎么确认对、该测哪些数据、怎么查偶发错误；
  或问两个相近术语的区别（指针 vs 指针变量、define vs const、数组名算不算指针）时使用。
  本入口内含全书 10 张能力卡，也可按主题查其它能力。
metadata:
  cangjie.generated-by: cangjie-tools v2.5.0
  cangjie.variant: router
  cangjie.bundle-id: bundle.c-programming-5th-tan
  cangjie.capability-count: 10
  cangjie.entrypoint-count: 7
---
# C程序设计（第五版） — 来源路由入口（compact pack）

## 触发与不触发

**适用**：与本书能力域相关的咨询与任务（见下方路由表的意图列）。
**不适用**：
- 现代工程实践：Makefile/CMake、版本控制、单元测试框架、sanitizer、静态分析
- C11/C17/C23 新特性（_Generic、线程、原子操作）与 C++ 及其他语言
- 并发编程、网络编程、图形界面、数据库访问
- 真实工程规模的架构设计、需求变更管理、性能调优

## 核心原则（常驻速览，概览类问题读到这里即可回答）

1. 程序 = 算法 + 数据结构；算法是灵魂，数据结构是加工对象，语言只是工具
2. 先设计算法再编码，不要坐下来就写程序
3. 任何复杂算法都由顺序、选择、循环三种基本结构嵌套组成，且必须单入口单出口
4. 指针就是地址；地址是带类型的，所以指针必须指定基类型
5. 实参向形参是单向值传递；要改调用者的变量必须传地址
6. 程序能跑不等于正确；必须设计多组（含边界）数据测试

## 能力路由（先读本表，按意图加载 1 张能力卡）

| 用户意图 | 先读 | 补读/备注 |
|---|---|---|
| 写一个最简 C 程序并跑起来；看不懂编译报错，想知道错在哪一类；程序能编译但结果不对，想知道往哪查；想搞清 .c/.obj/.exe 与编译连接的关系 | references/capabilities/program-skeleton.md | 已晋级为独立 Skill `program-skeleton`（已安装时优先直接使用；本卡仅作原文与背景补充） |
| 拿到编程题不知道从哪下手；主函数太长，想把大问题拆成模块；不知道该用流程图、N-S 图还是伪代码；一段重复操作想改写成循环但找不到规律 | references/capabilities/algorithm-design.md | 已晋级为独立 Skill `algorithm-design`（已安装时优先直接使用；本卡仅作原文与背景补充） |
| 多分支该用 if 还是 switch；while 和 do-while 该选哪个；程序死循环了；输入一个值却输出好几行（switch 穿透）；else 到底跟哪个 if 配对 | references/capabilities/control-flow.md | 已晋级为独立 Skill `control-flow`（已安装时优先直接使用；本卡仅作原文与背景补充） |
| 怎么存一批同类型数据；数组下标越界/结果差一位；冒泡排序怎么写；字符串输出乱码、'\0' 是什么；二维数组行列怎么用、传参第二维能不能省 | references/capabilities/array-and-string.md | 已晋级为独立 Skill `array-and-string`（已安装时优先直接使用；本卡仅作原文与背景补充） |
| 主函数太长想把功能拆成函数；在函数里改了变量外面没变；分不清函数定义和声明；递归怎么写、在哪里停；递归和循环该用哪个；数组传进函数后被改掉了 | references/capabilities/function-and-recursion.md | 已晋级为独立 Skill `function-and-recursion`（已安装时优先直接使用；本卡仅作原文与背景补充） |
| 指针到底是什么、*p 和 &a 分别是什么；分不清指针和指针变量；为什么要指定基类型、p+1 为什么加4；程序随机崩溃或有野指针；函数传指针为什么能改实参 | references/capabilities/pointer-model.md | 已晋级为独立 Skill `pointer-model`（已安装时优先直接使用；本卡仅作原文与背景补充） |
| 一组不同类型的数据怎么组织；struct 和 typedef struct 的写法；. 和 -> 什么时候用；结构体数组怎么排序；链表怎么建、怎么遍历 | references/capabilities/struct-and-linked-list.md | references/capabilities/pointer-model.md、references/capabilities/file-io.md |
| C 怎么读写文件；fopen 返回 NULL / 打不开文件；写文件后数据少了一截；文本方式和二进制方式该用哪个；feof 怎么用、EOF 是什么 | references/capabilities/file-io.md | references/capabilities/struct-and-linked-list.md、references/capabilities/array-and-string.md |
| 程序跑通了是不是就没问题；结果不对怎么查；要测哪些数据；有时对有时错；调试和测试有什么区别 | references/capabilities/debug-and-test.md | references/capabilities/program-skeleton.md、references/capabilities/control-flow.md |
| 某个术语到底指什么；两个相近概念的区别；数组名是指针吗；define 和 const 有什么区别 | references/capabilities/glossary.md | references/capabilities/pointer-model.md、references/capabilities/function-and-recursion.md、references/capabilities/program-skeleton.md |

**非能力类查询**：
- 书名/作者/章节/整书概览 → references/overview.md
- 术语解释 → references/glossary.md
- 决策规则速查（不需要原文依据时） → references/cheatsheet.md
- 完整意图与关键词索引（本表未覆盖的意图先查这里） → references/capability-index.md

## 加载规则

- 每次任务先读本文件，再按路由表加载 **1** 张能力卡；任务明确跨域时最多加载 2 张。
- 概览/书名类问题不加载能力卡，用「核心原则」与 overview.md 回答。
- 路由表与 capability-index.md 都无法命中的意图，明确告知超出本书范围，不要硬套。

## 边界与判停

- 用户问题涉及本书未覆盖的现代特性或工程实践时，说明超出范围并给出方向，不臆造答案
- 涉及指针解引用、动态内存写入等有破坏性风险的操作时，先确认指针有效性再给可执行代码
- 用户描述不足以判断输入输出契约时，先追问，不静默假设需求
