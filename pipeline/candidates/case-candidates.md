# 案例候选（case）

> 提取自《C程序设计（第五版）》谭浩强著，文字源 `_book_text.md`。
> 提取器：case-extractor。只收「能体现某一方法论/原则、且套路可迁移」的代表性例题。

```yaml
- id: c01
  title: 例1.1 输出一行信息——最小 C 程序骨架
  type: case
  source_chapter: 第1章 §1.4.1 例1.1
  source_quote: |
    "#include<stdio.h> int main( ) { printf(\"This is a C program.\\n\"); return 0; }"
  embodies: p13（注释）、f07（编译运行）、第1章「C 程序结构」
  summary: |
    问题：在屏幕上输出一行文字。
    思路：用主函数调用 printf 原样输出。
    关键代码：#include <stdio.h>（提供 printf 的信息）+ int main() + printf(...) + return 0;
    要点：每个 C 程序必须有且只有一个 main；语句以分号结束；\n 是换行符。
    可复用：任何 C 程序的最小骨架都可由此扩展（换 printf 内容、加变量声明与运算）。
  tags: [case, hello-world, skeleton, io]

- id: c02
  title: 例1.3 求两个整数中的较大者——函数声明与调用
  type: case
  source_chapter: 第1章 §1.4.1 例1.3
  source_quote: |
    "int max(int x,int y); …… c=max(a,b); …… int max(int x,int y){ int z; z=x>y?x:y; return(z); }"
  embodies: p10（函数就是功能）、p09（值传递）、第7章函数
  summary: |
    问题：输入两个整数，输出较大者。
    思路：把「求较大者」抽成一个函数 max，主函数只负责输入、调用、输出。
    关键代码：主函数内先声明 int max(int,int); 再 c=max(a,b); max 定义中 z=x>y?x:y; return(z);
    要点：函数定义在调用之后必须先声明（告诉编译器 max 是什么）；实参 a,b 的值传给形参 x,y。
    可复用：这是「主函数负责 IO、子函数负责计算」的标准分工模板。
  tags: [case, function, declaration, parameter]

- id: c03
  title: 例2.3 判定闰年——复合条件的逻辑表达
  type: case
  source_chapter: 第2章 §2.3 例2.3 / 第4章 §4.4.2 逻辑表达式
  source_quote: |
    "(1)能被4整除，但不能被100整除的年份都是闰年……(2)能被400整除的年份是闰年。"
    "(year%4==0 && year%100!=0) || year%400==0"
  embodies: p03（结构化）、第4章选择结构、逻辑运算符优先级
  summary: |
    问题：判定 2000—2500 每一年是否闰年。
    思路：把文字条件直接翻译成逻辑表达式，再套选择结构。
    关键代码：(year%4==0 && year%100!=0) || year%400==0
    要点：&& 优先于 ||；表达式为真(1)即闰年；注意三种判断（闰年/非闰年）的括号位置。
    可复用：任何「多个条件组合」的判断，都可先写成逻辑表达式再代入 if，减少分支嵌套。
  tags: [case, selection, logic-expression, condition]

- id: c04
  title: 例2.5 / 例5.9 判定素数——循环 + 提前收敛 + 优化上界
  type: case
  source_chapter: 第2章 §2.3 例2.5 / 第5章 §5.8 例5.9
  source_quote: |
    "将n作为被除数，将2～(n-1)的各个整数先后作为除数，如果都不能被整除，则n为素数。"
    "实际上，n不必被2～(n-1)的整数除，只须被2～n/2的整数除即可，甚至只须被2~ √n的整数除即可。"
  embodies: f03（循环归纳）、f06（标志变量收敛出口）、p05（循环终止）
  summary: |
    问题：判定 n(n≥3) 是否素数。
    思路：用 i 从 2 试除到 √n，一旦整除即可判定非素数。
    关键代码：for(i=2;i<=sqrt(n);i++) if(n%i==0){flag=1;break;} 
    要点：①试除上界可优化到 √n（数学上等价，效率大幅提升）；②「提前判定非素数」用 break 或标志变量，把多出口收敛成单出口。
    可复用：凡是「存在反例即可否定」的判定问题，都用「循环 + 一旦命中就退出」的模式。
  tags: [case, loop, prime, optimization, flag-variable]

- id: c05
  title: 例2.4 多项式求和 1-1/2+1/3-… —— 符号交替 + 累加
  type: case
  source_chapter: 第2章 §2.3 例2.4
  source_quote: |
    "②第2项的分母是2，以后每一项的分母都是前一项的分母加1；③第2项前的运算符为'—'，后一项前面的运算符都与前一项前的运算符相反。这就找到了多项式的规律，能把多项式表示为一般形式，即把问题抽象化了。"
  embodies: f03（循环归纳）、「把具体问题抽象化」
  summary: |
    问题：求 1 - 1/2 + 1/3 - 1/4 + … 前若干项之和。
    思路：先找规律——分母逐项+1、符号逐项取反，于是引入 sign、deno、term、sum 四个变量。
    关键代码：sign=-sign; term=sign/deno; sum=sum+term; deno=deno+1;
    要点：①「符号交替」用 sign=-sign 实现，无需分奇偶讨论；②把「第1项特例」先预置进 sum，循环从第2项开始。
    可复用：任何「项之间按固定规律递变」的级数，都先提炼出递推关系再写循环。
  tags: [case, series, loop, abstraction, sign-alternation]

- id: c06
  title: 例4.2 交换两个变量的值——必须借助第三个变量
  type: case
  source_chapter: 第4章 §4.2.1 例4.2
  source_quote: |
    "为了实现互换。必须借助于第3个变量。可以这样考虑：将 A 和 B 两个杯子中的水互换，用两个杯子的水倒来倒去的办法是无法实现的。必须借助于第3个杯子C……"
  embodies: 第4章选择结构、反例 ce01（a=b;b=a; 错误）
  summary: |
    问题：输入两实数，按由小到大输出。
    思路：若 a>b 就交换 a、b，再顺序输出。
    关键代码：if(a>b){ t=a; a=b; b=t; }
    要点：交换必须借第三变量 t；直接写 a=b;b=a; 会把 a 的原值覆盖掉（见 ce01）。
    可复用：所有「交换两值」的场景（排序内层、指针交换、数组逆置）都用这个三行模板。
  tags: [case, swap, selection, idiom]

- id: c07
  title: 例4.3 三个数排序——有限次比较交换
  type: case
  source_chapter: 第4章 §4.2.1 例4.3
  source_quote: |
    "S1:if a>b, 将a和b对换（交换后，a是a,b中的小者）S2:if a>c, 将a和c对换（交换后，a是a,c中的小者，因此a是三者中最小者）S3:if b>c, 将b和c对换"
  embodies: 第4章选择结构、c06（交换）、p02（先算法后编码）
  summary: |
    问题：输入 3 个数，由小到大输出。
    思路：先用伪代码排出 3 步交换序列，保证每步把当前最小值「顶」到前面。
    关键代码：if(a>b){t=a;a=b;b=t;} if(a>c){...} if(b>c){...}
    要点：3 个元素的排序只需固定 3 次比较-交换；顺序不能乱（先把最小顶到 a，再处理 b、c）。
    可复用：这是「小规模定长排序」的穷举式解法，也是理解排序本质（比较+交换）的起点。
  tags: [case, sorting, selection, swap]

- id: c08
  title: 例5.1 求 1+2+…+100——累加循环的标准写法
  type: case
  source_chapter: 第5章 §5.2 例5.1
  source_quote: |
    "int i=1,sum=0; while(i<=100){ sum=sum+i; i++; }"
  embodies: p05（循环终止）、f03（循环归纳）、p06（初值）
  summary: |
    问题：求 1+2+…+100。
    思路：看清「每次加的数比上次大1」的规律，用 i 代表当前加数，sum 累加。
    关键代码：i=1; sum=0; while(i<=100){ sum=sum+i; i++; }
    要点：①sum 与 i 都必须赋初值（否则值不可预测）；②循环体内必须有 i++ 使条件终将不成立；③循环体多语句必须加花括号。
    可复用：一切累加/累乘问题都是这个骨架（换初值、换步长、换条件）。
  tags: [case, loop, accumulation, while]

- id: c09
  title: 例5.4 慈善募捐——用 break 提前终止循环
  type: case
  source_chapter: 第5章 §5.7.1 例5.4
  source_quote: |
    "for(i=1,total=0;i<=1000;i++){ ... total=total+amount; if(total>=SUM)break; }"
  embodies: 第5章 break、p05（循环终止）
  summary: |
    问题：1000 人募捐，总数达 10 万即停止，统计人数与人均。
    思路：按最大次数 1000 设循环，循环体内累加并检查是否达标，达标就 break 跳出。
    关键代码：total=total+amount; if(total>=SUM) break;
    要点：循环次数「事先不确定、但有上限」时，用「上限做 for 边界 + 达标 break」的模式；break 后 i 的值正好是实际人数。
    可复用：搜索、累计达标即停、找第一个满足条件的元素——都用 break。
  tags: [case, loop, break, early-exit]

- id: c10
  title: 例5.5 输出 100~200 不能被 3 整除的数——用 continue 跳过本次
  type: case
  source_chapter: 第5章 §5.7.2 例5.5
  source_quote: |
    "continue语句只结束本次循环，而不是终止整个循环的执行。而break语句则是结束整个循环过程。"
  embodies: 第5章 continue vs break
  summary: |
    问题：输出 100~200 中不能被 3 整除的数。
    思路：遍历 100~200，能被 3 整除就 continue 跳过本次，否则输出。
    关键代码：for(n=100;n<=200;n++){ if(n%3==0) continue; printf("%d",n); }
    要点：break＝终止整个循环；continue＝只结束本次、继续下一次。二者不可混用。
    可复用：「过滤掉一部分、只处理其余」时用 continue，比写嵌套 if 更扁平整洁。
  tags: [case, loop, continue, filter]

- id: c11
  title: 例6.3 起泡法排序——双重循环的经典结构
  type: case
  source_chapter: 第6章 §6.1.4 例6.3
  source_quote: |
    "起泡法的基本思路是：每次将相邻两个数比较，将小的调到前面。……如果有 n 个数，则要进行 n-1 趟比较。在第1趟比较中要进行 n-1 次两两比较，在第 j 趟比较中要进行 n-j 次两两比较。"
  embodies: 第6章数组、第5章嵌套循环、c06（交换）
  summary: |
    问题：对 10 个数由小到大排序。
    思路：每趟把当前最大数「沉底」，共 n-1 趟；第 j 趟只需比较 n-j 次。
    关键代码：for(j=0;j<9;j++) for(i=0;i<9-j;i++) if(a[i]>a[i+1]){t=a[i];a[i]=a[i+1];a[i+1]=t;}
    要点：①外层控制趟数、内层控制本趟比较次数；②内层上界 9-j 随趟数递减（已沉底的不再比）；③交换用三行模板。
    可复用：一切「相邻比较、逐步归位」的排序/扫描都套这个双层结构。
  tags: [case, array, bubble-sort, nested-loop]

- id: c12
  title: 例6.2 用数组求 Fibonacci 数列——把「值」变成「可留存的数据」
  type: case
  source_chapter: 第6章 §6.1.4 例6.2
  source_quote: |
    "在第5章例5.8中是用简单变量处理的……但不能在内存中保存这些数。假如想直接输出数列中第25个数，是很困难的。如果用数组来处理，在概念上反而简单了：每一个数组元素代表数列中的一个数，依次求出各数并存放在相应的数组元素中即可。"
  embodies: 第6章数组、f03（循环归纳）、递推
  summary: |
    问题：输出 Fibonacci 数列前 40 项。
    思路：用 f[40] 保存每一项，f[i]=f[i-2]+f[i-1] 递推填充，再统一输出。
    关键代码：f[0]=1;f[1]=1; for(i=2;i<40;i++) f[i]=f[i-2]+f[i-1];
    要点：①用简单变量只能「算一个丢一个」，用数组才能保留全部历史；②前两项是已知的递推基。
    可复用：凡需要「保留中间结果以便后续复用」的递推，都改用数组承载。
  tags: [case, array, fibonacci, recurrence]

- id: c13
  title: 例7.6 五个学生的年龄——递归的「回溯 + 递推」两阶段
  type: case
  source_chapter: 第7章 §7.6 例7.6
  source_quote: |
    "也就是说，一个递归的问题可以分为'回溯'和'递推'两个阶段。……显而易见，如果要求递归过程不是无限制进行下去，必须具有一个结束递归过程的条件。例如，age(1)=10，就是使递归结束的条件。"
  embodies: 第7章递归、p05（终止条件）
  summary: |
    问题：第 n 个学生比前一个大 2 岁，第 1 个 10 岁，求第 5 个年龄。
    思路：写出递归关系 age(n)=age(n-1)+2，基例 age(1)=10，直接译为递归函数。
    关键代码：int age(int n){ int c; if(n==1) c=10; else c=age(n-1)+2; return c; }
    要点：递归 = ①递归关系（把大问题化为同类小问题）+ ②终止条件（基例）；执行分「回溯」（一路展开到基例）与「递推」（自基例回代求值）两阶段。
    可复用：任何「第 n 项依赖第 n-1 项、且有明确起点」的问题都可先写递归式再编码。
  tags: [case, recursion, base-case, induction]

- id: c14
  title: 例7.7 递归求 n! —— 最简递归与溢出边界
  type: case
  source_chapter: 第7章 §7.6 例7.7
  source_quote: |
    "求 n! 也可以用递归方法，即 5! 等于 4!×5，而 4!=3!×4，…，1!=1。"
    "注意：程序中的变量是 int 型……当 n=12 时，运行正常……如果输入13，企图求13!，是得不到预期结果的，因为求出的结果超过了 int 型数据的最大值。"
  embodies: 第7章递归、类型取值范围
  summary: |
    问题：用递归求 n!。
    思路：n!=n×(n-1)!，基例 0!/1!=1。
    关键代码：int fac(int n){ int f; if(n==0||n==1) f=1; else f=fac(n-1)*n; return f; }
    要点：①递归式与基例各一行即可；②必须意识到数据类型的表示范围——int 存不下 13!，要换 float/double。
    可复用：递归模板 + 「先问返回值类型够不够大」的自觉。
  tags: [case, recursion, factorial, integer-overflow]

- id: c15
  title: 例7.8 Hanoi 塔——把复杂问题降一阶的递归思维
  type: case
  source_chapter: 第7章 §7.6 例7.8
  source_quote: |
    "老和尚会这样想：假如有另外一个和尚能有办法将上面63个盘子从一个座移到另一座。那么，问题就解决了。……这就是递归方法，把移动64个盘子简化为移动63个盘子，难度减小了一些。"
  embodies: 第7章递归、f02（自顶向下分解）
  summary: |
    问题：把 64 个盘从 A 经 B 移到 C，每次一个、大盘不能压小盘。
    思路：不直接求 64 步，而假设「已有人能搬 63 个」，于是只需三步：①63 个 A→B；②最大盘 A→C；③63 个 B→C。递归下去直到 1 个盘。
    关键代码：hanoi(n,a,b,c){ if(n==1) move(a,c); else { hanoi(n-1,a,c,b); move(a,c); hanoi(n-1,b,c,a); } }
    要点：递归的威力在于「假设子问题已解决」，把 n 降为 n-1；座位的角色在递归调用中互换（a,b,c 传参顺序变化是核心技巧）。
    可复用：任何「规模可降一阶、且子问题同构」的问题（分治、树遍历、汉诺塔类）。
  tags: [case, recursion, hanoi, divide-and-conquer]

- id: c16
  title: 例8.3 用指针作函数参数交换两数——让函数真正改变实参
  type: case
  source_chapter: 第8章 §8.2.4 例8.3
  source_quote: |
    "void swap(int *p1,int *p2){ int temp; temp=*p1; *p1=*p2; *p2=temp; }"
    "在函数中通过指针实现交换两个变量的值。"
  embodies: p07（指针就是地址）、p09（值传递）、c06（交换）
  summary: |
    问题：用函数交换两个整数的值。
    思路：直接传 int 只交换了形参副本（无效）；改为传地址，在函数内通过 *p 改目标单元。
    关键代码：swap(&a,&b);  void swap(int *p1,int *p2){ int t; t=*p1; *p1=*p2; *p2=t; }
    要点：①形参是指针，实参用 &a、&b；②交换的是 *p1、*p2（目标变量），不是 p1、p2（地址本身）；③这解释了「为什么值传递下要靠指针带回结果」。
    可复用：凡「函数需要修改调用者变量 / 返回多个结果」的场合，都传指针。
  tags: [case, pointer, swap, pass-by-address]

- id: c17
  title: 例10.2 复制磁盘文件——文件循环读写的标准骨架
  type: case
  source_chapter: 第10章 §10.3.1 例10.2
  source_quote: |
    "处理此问题的算法是：从 filel.dat 文件中逐个读入字符，然后逐个输出到 file2.dat 中。"
    "fopen(...,\"r\") …… while(!feof(in)){ ch=fgetc(in); fputc(ch,out); } …… fclose(in); fclose(out);"
  embodies: f09（打开-读写-关闭）、c08（循环）、p14（必须关闭）
  summary: |
    问题：把一个文件内容复制到另一个文件。
    思路：以「读」方式打开源、以「写」方式打开目标，循环「读一个字符→写一个字符」，直到 feof 为真。
    关键代码：while(!feof(in)){ ch=fgetc(in); fputc(ch,out); }，最后 fclose 两个文件。
    要点：①两个 fopen 都要检查 NULL；②feof 在「读到文件尾之后」才为真，所以循环写法要配合 fgetc 的返回值；③必须 fclose，否则缓冲区数据可能丢失。
    可复用：一切「逐条/逐字符/逐记录搬数据」的文件处理都套这个「双开—循环读写—双关」骨架。
  tags: [case, file-io, copy, loop, feof]

- id: c18
  title: 例9.8 建立简单链表——结构体 + 指针串起动态数据
  type: case
  source_chapter: 第9章 §9.4 例9.8
  source_quote: |
    "【例9.8】建立一个如图9.9所示的简单链表，它由3个学生数据的结点组成，要求输出各结点中的数据。"
  embodies: 第9章结构体、p07（指针）、p08（指针必须赋值）
  summary: |
    问题：用链表存放 3 个学生数据并输出。
    思路：定义含数据域与「指向自身类型的指针域」的结构体；逐个结点 malloc、填数据、把 next 连到下一结点；最后 p=head 遍历输出。
    关键代码：struct Student{ int num; float score; struct Student *next; };  p1->next=p2; p2->next=p3; p3->next=NULL;
    要点：①结构体成员可是指向自身类型的指针（自引用结构），这是链表的根基；②尾结点 next 必须置 NULL 作为遍历终止标志；③遍历用 p=p->next 直到 p==NULL。
    可复用：任何需要「动态增删、长度不定」的数据集合（链表、树、图）都从自引用结构 + 指针连接开始。
  tags: [case, struct, linked-list, pointer, dynamic]
```
