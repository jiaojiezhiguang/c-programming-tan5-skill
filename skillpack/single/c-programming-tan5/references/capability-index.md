# 能力索引（完整版）

| capability_id | 标题 | 重要度 | 意图 | 关键词 | 能力卡 |
|---|---|---|---|---|---|
| cap.c-programming-5th.program-skeleton | C 程序骨架与编译运行 | critical | 写一个最简 C 程序并跑起来；看不懂编译报错，想知道错在哪一类；程序能编译但结果不对，想知道往哪查；想搞清 .c/.obj/.exe 与编译连接的关系 | C程序结构、include、main、编译、连接、目标程序、可执行程序、语法错误、逻辑错误、compile、link、undefined reference、注释 | capabilities/program-skeleton.md |
| cap.c-programming-5th.algorithm-design | 算法先行：从任务到算法的设计流程 | critical | 拿到编程题不知道从哪下手；主函数太长，想把大问题拆成模块；不知道该用流程图、N-S 图还是伪代码；一段重复操作想改写成循环但找不到规律 | 算法、程序设计过程、结构化程序设计、自顶向下、逐步细化、模块化、流程图、N-S图、伪代码、循环归纳、标志变量、top-down、pseudocode、flowchart | capabilities/algorithm-design.md |
| cap.c-programming-5th.control-flow | 控制结构选型与陷阱 | high | 多分支该用 if 还是 switch；while 和 do-while 该选哪个；程序死循环了；输入一个值却输出好几行（switch 穿透）；else 到底跟哪个 if 配对 | if、switch、case、break、continue、while、do-while、for、死循环、悬空else、穿透、fall-through、循环嵌套 | capabilities/control-flow.md |
| cap.c-programming-5th.array-and-string | 数组与字符串处理批量数据 | high | 怎么存一批同类型数据；数组下标越界/结果差一位；冒泡排序怎么写；字符串输出乱码、'\0' 是什么；二维数组行列怎么用、传参第二维能不能省 | 数组、一维数组、二维数组、下标、越界、初始化、字符数组、字符串、结束标志、起泡排序、冒泡排序、array、bubble sort、strcmp、strlen | capabilities/array-and-string.md |
| cap.c-programming-5th.function-and-recursion | 函数、参数传递与递归 | critical | 主函数太长想把功能拆成函数；在函数里改了变量外面没变；分不清函数定义和声明；递归怎么写、在哪里停；递归和循环该用哪个；数组传进函数后被改掉了 | 函数、定义、声明、原型、形参、实参、值传递、返回值、递归、终止条件、回溯、递推、function、recursion、pass by value | capabilities/function-and-recursion.md |
| cap.c-programming-5th.pointer-model | 指针：地址模型与间接访问 | critical | 指针到底是什么、*p 和 &a 分别是什么；分不清指针和指针变量；为什么要指定基类型、p+1 为什么加4；程序随机崩溃或有野指针；函数传指针为什么能改实参 | 指针、指针变量、地址、基类型、取地址、解引用、间接访问、直接访问、野指针、空指针、NULL、带类型的地址、pointer、dereference、segmentation fault | capabilities/pointer-model.md |
| cap.c-programming-5th.struct-and-linked-list | 结构体与链表 | medium | 一组不同类型的数据怎么组织；struct 和 typedef struct 的写法；. 和 -> 什么时候用；结构体数组怎么排序；链表怎么建、怎么遍历 | 结构体、struct、typedef、成员、结构体数组、结构体指针、链表、结点、next、自引用结构、malloc、linked list | capabilities/struct-and-linked-list.md |
| cap.c-programming-5th.file-io | 文件读写：打开—读写—关闭 | high | C 怎么读写文件；fopen 返回 NULL / 打不开文件；写文件后数据少了一截；文本方式和二进制方式该用哪个；feof 怎么用、EOF 是什么 | 文件、fopen、fclose、文件指针、FILE、缓冲区、文本文件、二进制文件、fgetc、fputc、fscanf、fprintf、fread、fwrite、feof、EOF、rewind、file io | capabilities/file-io.md |
| cap.c-programming-5th.debug-and-test | 调试与测试 | high | 程序跑通了是不是就没问题；结果不对怎么查；要测哪些数据；有时对有时错；调试和测试有什么区别 | 调试、测试、debug、test、边界值、测试用例、逻辑错误、语法错误、回归、定位 | capabilities/debug-and-test.md |
| cap.c-programming-5th.glossary | 术语速查（C 程序设计核心概念） | medium | 某个术语到底指什么；两个相近概念的区别；数组名是指针吗；define 和 const 有什么区别 | 术语、概念、区别、定义、指针变量、常变量、符号常量、声明、形参、实参、glossary、terminology | capabilities/glossary.md |
