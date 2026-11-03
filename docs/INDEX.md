# C程序设计（第五版）· 能力索引（INDEX）

> 来源：《C程序设计（第五版）》 谭浩强（2017，清华大学出版社）
> 本索引由 Capability Bundle 自动生成，共 10 个 active 能力：6 个独立 Skill + 4 张路由能力卡。
> 精华长文见 [DIGEST.md](DIGEST.md)，术语表见 [GLOSSARY.md](GLOSSARY.md)。

## 一句话主旨

用尽量少的语法概念、配合大量可运行实例，把零基础读者带到「能独立写出结构化 C 程序、理解指针与文件」的程度。

## 推荐学习顺序

按依赖关系推出（前者是后者的前置）：

1. **C 程序骨架与编译运行** — 先认清错误出现在编译期还是运行期，再决定改语法还是查逻辑。
2. **算法先行：从任务到算法的设计流程** — 先把任务拆成算法与模块再写代码；重复操作找规律改写为循环。
3. **控制结构选型与陷阱** — 常量多分支用 switch、范围判断用 if；可能一次不执行用 while、至少一次用 do-while。
4. **数组与字符串处理批量数据** — 定义长度 N 就一律写 for(i=0;i<N;i++)，合法下标只到 N-1。
5. **函数、参数传递与递归** — 想在函数里改调用者的变量，就传地址而不是传值。
6. **指针：地址模型与间接访问** — 指针就是地址；地址带类型，所以指针必须指定基类型，且用前必须指向合法对象。
7. **结构体与链表** — 结构体类型不占空间、变量才占；链表尾结点 next 必须置 NULL。
8. **文件读写：打开—读写—关闭** — 打开必须判空、用完必须 fclose，否则缓冲区数据会丢。
9. **调试与测试** — 跑通一组数据不等于正确；必须测边界值。
10. **术语速查（C 程序设计核心概念）** — 指针≠指针变量、常量≠常变量、定义≠声明——先分清边界再谈用法。

## 独立 Skill（可直接触发）

| Skill | 标题 | 重要性 | 一句话规则 |
|---|---|---|---|
| [`program-skeleton`](../pack/program-skeleton/SKILL.md) | C 程序骨架与编译运行 | critical | 先认清错误出现在编译期还是运行期，再决定改语法还是查逻辑。 |
| [`algorithm-design`](../pack/algorithm-design/SKILL.md) | 算法先行：从任务到算法的设计流程 | critical | 先把任务拆成算法与模块再写代码；重复操作找规律改写为循环。 |
| [`control-flow`](../pack/control-flow/SKILL.md) | 控制结构选型与陷阱 | high | 常量多分支用 switch、范围判断用 if；可能一次不执行用 while、至少一次用 do-while。 |
| [`array-and-string`](../pack/array-and-string/SKILL.md) | 数组与字符串处理批量数据 | high | 定义长度 N 就一律写 for(i=0;i<N;i++)，合法下标只到 N-1。 |
| [`function-and-recursion`](../pack/function-and-recursion/SKILL.md) | 函数、参数传递与递归 | critical | 想在函数里改调用者的变量，就传地址而不是传值。 |
| [`pointer-model`](../pack/pointer-model/SKILL.md) | 指针：地址模型与间接访问 | critical | 指针就是地址；地址带类型，所以指针必须指定基类型，且用前必须指向合法对象。 |

## 路由能力卡（经路由入口访问）

| 能力卡 | 标题 | 重要性 | 一句话规则 |
|---|---|---|---|
| [struct-and-linked-list](../pack/c-programming-tan5-reference/references/capabilities/struct-and-linked-list.md) | 结构体与链表 | medium | 结构体类型不占空间、变量才占；链表尾结点 next 必须置 NULL。 |
| [file-io](../pack/c-programming-tan5-reference/references/capabilities/file-io.md) | 文件读写：打开—读写—关闭 | high | 打开必须判空、用完必须 fclose，否则缓冲区数据会丢。 |
| [debug-and-test](../pack/c-programming-tan5-reference/references/capabilities/debug-and-test.md) | 调试与测试 | high | 跑通一组数据不等于正确；必须测边界值。 |
| [glossary](../pack/c-programming-tan5-reference/references/capabilities/glossary.md) | 术语速查（C 程序设计核心概念） | medium | 指针≠指针变量、常量≠常变量、定义≠声明——先分清边界再谈用法。 |

路由入口：[`c-programming-tan5-reference`](../pack/c-programming-tan5-reference/SKILL.md)

## 意图 → 能力映射

| 你想做什么 | 用哪个 |
|---|---|
| 写一个最简 C 程序并跑起来 | [`program-skeleton`](../pack/program-skeleton/SKILL.md) |
| 看不懂编译报错，想知道错在哪一类 | [`program-skeleton`](../pack/program-skeleton/SKILL.md) |
| 拿到编程题不知道从哪下手 | [`algorithm-design`](../pack/algorithm-design/SKILL.md) |
| 主函数太长，想把大问题拆成模块 | [`algorithm-design`](../pack/algorithm-design/SKILL.md) |
| 多分支该用 if 还是 switch | [`control-flow`](../pack/control-flow/SKILL.md) |
| while 和 do-while 该选哪个 | [`control-flow`](../pack/control-flow/SKILL.md) |
| 怎么存一批同类型数据 | [`array-and-string`](../pack/array-and-string/SKILL.md) |
| 数组下标越界/结果差一位 | [`array-and-string`](../pack/array-and-string/SKILL.md) |
| 主函数太长想把功能拆成函数 | [`function-and-recursion`](../pack/function-and-recursion/SKILL.md) |
| 在函数里改了变量外面没变 | [`function-and-recursion`](../pack/function-and-recursion/SKILL.md) |
| 指针到底是什么、*p 和 &a 分别是什么 | [`pointer-model`](../pack/pointer-model/SKILL.md) |
| 分不清指针和指针变量 | [`pointer-model`](../pack/pointer-model/SKILL.md) |
| 一组不同类型的数据怎么组织 | [`struct-and-linked-list`](../pack/c-programming-tan5-reference/references/capabilities/struct-and-linked-list.md) |
| struct 和 typedef struct 的写法 | [`struct-and-linked-list`](../pack/c-programming-tan5-reference/references/capabilities/struct-and-linked-list.md) |
| C 怎么读写文件 | [`file-io`](../pack/c-programming-tan5-reference/references/capabilities/file-io.md) |
| fopen 返回 NULL / 打不开文件 | [`file-io`](../pack/c-programming-tan5-reference/references/capabilities/file-io.md) |
| 程序跑通了是不是就没问题 | [`debug-and-test`](../pack/c-programming-tan5-reference/references/capabilities/debug-and-test.md) |
| 结果不对怎么查 | [`debug-and-test`](../pack/c-programming-tan5-reference/references/capabilities/debug-and-test.md) |
| 某个术语到底指什么 | [`glossary`](../pack/c-programming-tan5-reference/references/capabilities/glossary.md) |
| 两个相近概念的区别 | [`glossary`](../pack/c-programming-tan5-reference/references/capabilities/glossary.md) |

## 覆盖的原书任务

| task | 读者任务 | 对应能力 |
|---|---|---|
| task-01 | 写出能编译运行的 C 程序骨架 | program-skeleton |
| task-02 | 用流程图/N-S 图表达算法 | algorithm-design |
| task-03 | 选择正确的控制结构实现逻辑 | control-flow |
| task-04 | 用数组/字符串批量处理数据 | array-and-string |
| task-05 | 设计可复用的函数（含递归） | function-and-recursion |
| task-06 | 用指针理解与操作内存 | pointer-model |
| task-07 | 诊断并修复 C 编译/运行错误 | program-skeleton / debug-and-test |
| task-08 | 用结构体组织复合数据 + 文件读写 | struct-and-linked-list / file-io |
