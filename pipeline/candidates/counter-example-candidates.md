# 反例候选（counter-example）

> 提取自《C程序设计（第五版）》谭浩强著，文字源 `_book_text.md`。
> 提取器：counter-example-extractor。只收「作者明确指出的常见错误、陷阱、易混淆点」。

```yaml
- id: ce01
  title: 用 a=b; b=a; 交换两值——原值被覆盖
  type: counter-example
  source_chapter: 第4章 §4.2.1 例4.2
  source_quote: |
    "不能把两个变量直接互相赋值，如为了将a和b对换，不能用下面的办法：a=b; b=a;（把变量b的值赋给变量a，a的值等于b的值）（再把变量a的值赋给变量b，变量b值没有改变）"
  trap: |
    直觉上「把 a 给 b、把 b 给 a」就是交换，但赋值是覆盖操作：执行 a=b 后 a 的原值已被销毁，
    再执行 b=a 只是把 b 的值又赋回 b，两个变量最后都等于原来 b 的值。
  warning_sign: 交换后两个变量的值相同；或排序/逆置后数据出现重复、丢失。
  correct: 必须借助第三个临时变量：t=a; a=b; b=t;（或对指针场景交换指针而非值）
  tags: [counter-example, swap, assignment, lost-value]

- id: ce02
  title: 数组下标从 1 开始 / 访问 a[n] 越界
  type: counter-example
  source_chapter: 第6章 §6.1.2 怎样引用一维数组元素
  source_quote: |
    "应当特别提醒的是：数组元素的下标从0开始，如果用'int a[10];'定义数组，则最大下标值为9，不存在数组元素a[10]。下面是常见的错误。for(i=1;i<=10;i++) a[i]=i; for(i=10;i>=1;i--) printf(\"%d\",a[i]);"
  trap: |
    把「10 个元素」误当成「下标 1~10」。C 的下标是 0 基的：a[10] 有元素 a[0]…a[9]，
    循环写 i=1;i<=10 会同时犯两个错——漏掉 a[0]、并写到不存在的 a[10]。
    而 C 不做下标越界检查（§1.3 特点(5)），越界不报错，只会悄悄破坏相邻内存。
  warning_sign: 数组首元素始终为 0/空；程序偶发崩溃或别的变量莫名改变；结果差一位。
  correct: 定义长度 N，遍历一律写 for(i=0;i<N;i++)；记住合法下标是 0..N-1。
  tags: [counter-example, array, off-by-one, out-of-bounds]

- id: ce03
  title: 循环体内缺少使循环趋于结束的语句——死循环
  type: counter-example
  source_chapter: 第5章 §5.2 例5.1 程序分析(3)
  source_quote: |
    "在循环体中应有使循环趋向于结束的语句。……如果无此语句，则i的值始终不改变，循环永远不结束。"
  trap: |
    只写了循环条件（如 i<=100），却忘了在循环体里改变 i。
    条件永远为真，程序卡死；若循环体还带输出，会刷屏。
  warning_sign: 程序不结束、CPU 占用高、屏幕上重复输出同一条内容。
  correct: 循环体内必须有推进循环变量的语句（i++ / i=i+1 / 读下一个数据），并确认它最终能让条件为假。
  tags: [counter-example, loop, infinite-loop, termination]

- id: ce04
  title: 循环体有多条语句却漏写花括号
  type: counter-example
  source_chapter: 第5章 §5.2 例5.1 程序分析(1)
  source_quote: |
    "循环体如果包含一个以上的语句，应该用花括号括起来，作为复合语句出现。如果不加花括号，则while语句的范围只到while后面第1个分号处。"
  trap: |
    while/for 的「语句」只涵盖紧随其后的一个语句。若循环体本意是两条语句却没加 {}，
    则只有第一条属于循环，第二条在循环结束后才执行一次（或每次都执行但不受条件控制）。
  warning_sign: 循环次数对但累加结果错；某条语句只执行了一次；while 后跟 i++ 却没进循环。
  correct: 循环体只要超过一条语句，一律用 {} 包起来；初学阶段建议即使一条也加。
  tags: [counter-example, loop, compound-statement, braces]

- id: ce05
  title: 忘记给变量/累加器赋初值
  type: counter-example
  source_chapter: 第5章 §5.2 例5.1 程序分析(2)
  source_quote: |
    "不要忽略给i和sum赋初值（这是未进行累加前的初始情况），否则它们的值是不可预测的，结果显然不正确。读者可上机试一下。"
  trap: |
    累加器 sum、循环变量 i 不赋初值就直接用，它们的值是内存里的残留垃圾，
    因此 sum 的初值可能不是 0，i 可能一上来就大于终止值。
  warning_sign: 同一程序多次运行结果不同；累加结果莫名偏大；循环一次都不执行。
  correct: 累加前 sum=0（累乘前 t=1），循环变量按需赋初值；局部变量声明即初始化。
  tags: [counter-example, initialization, uninitialized, accumulation]

- id: ce06
  title: 指针未赋值（野指针）就解引用
  type: counter-example
  source_chapter: 第8章 §8.9 有关指针的小结(8)
  source_quote: |
    "p 的值为NULL与未对p赋值是两个不同的概念。前者是有值的（值为0），不指向任何变量，后者虽未对p赋值但并不等于p无值，只是它的值是一个无法预料的值，也就是p可能指向一个事先未指定的单元。这种情况是很危险的。因此，在引用指针变量之前应对它赋值。"
  trap: |
    定义 int *p; 后 p 里是随机地址，此时执行 *p=3 或 printf("%d",*p) 会读写一块
    完全无关的内存——可能改坏别的变量、可能段错误。
    注意「未赋值」≠「值为 NULL」：NULL 是明确不指向任何对象的合法状态，未赋值是脏值。
  warning_sign: 程序随机崩溃；某个不相干变量的值莫名改变；换一次编译/运行表现不同。
  correct: 指针定义后立即初始化（p=&a 或 p=NULL）；使用 *p 前确保它已指向合法对象；
           需要空语义时显式 p=NULL 并做 if(p!=NULL) 检查。
  tags: [counter-example, pointer, wild-pointer, dangling, safety]

- id: ce07
  title: 指针基类型不匹配（把 float 地址赋给 int*）
  type: counter-example
  source_chapter: 第8章 §8.9 有关指针的小结(4)
  source_quote: |
    "并不是任何类型数据的地址都可以存放在同一个指针变量中的，只有与指针变量的基类型相同的数据的地址才能存放在相应的指针变量中。例如：int a,*p; float b; p=&a;（合法）p=&b;（类型不匹配）"
  trap: |
    认为「指针就是存地址，随便什么地址都能存」。但 C 的地址是「带类型的地址」，
    指针的基类型决定了解引用时读几个字节、按什么格式解释。
    用 int* 指向 float，会按整型方式解读浮点数的字节，得到完全错误的数值。
  warning_sign: 通过指针读出的值与原变量不符；编译器给出类型不匹配警告。
  correct: 指针基类型必须与所指向对象的类型一致；确实需要跨类型时用强制类型转换并明确理由。
  tags: [counter-example, pointer, type-mismatch, base-type]

- id: ce08
  title: 把整数直接赋给指针变量
  type: counter-example
  source_chapter: 第8章 §8.2.2 怎样定义指针变量(4)
  source_quote: |
    "指针变量中只能存放地址（指针），不要将一个整数赋给一个指针变量。如：*pointer_1=100;（pointer_1是指针变量，100是整数，不合法）……在程序中是不能用一个数值代表地址的，地址只能用地址符'&'得到并赋给一个指针变量。"
  trap: |
    想「把地址 100 存进指针」，于是写 *p=100 或 p=100。前者是给 p 所指向的变量赋 100，
    后者是把整常数当地址——编译器无法把数值当地址，判为非法（或语义完全不是本意）。
  warning_sign: 编译报错/警告；或写 *p=100 后原变量变成 100 而 p 的指向没变。
  correct: 地址只能由 & 取到：p=&a;。要得到某对象的地址就取地址，不要手写数字。
  tags: [counter-example, pointer, address, illegal-assignment]

- id: ce09
  title: switch 的 case 漏写 break——连续穿透执行
  type: counter-example
  source_chapter: 第4章 §4.7 说明(6)
  source_quote: |
    "case标号只起标记的作用。……在执行完一个case标号后面的语句后，就从此标号开始执行下去，不再进行判断。例如在例4.6中，如果在各case子句中没有break语句，将连续输出：Your score:85～100 / 70～84 / 60～69 / ≤60 / enter data error!"
  trap: |
    switch 匹配到某个 case 后，只是「跳转到该标号」，之后会一路往下执行，
    不再逐个比较 case。漏写 break 就会把后面所有分支的语句都执行一遍。
  warning_sign: 输入一个等级却输出多行结果；输出内容比预期多出后面几个分支的内容。
  correct: 每个 case 语句末尾加 break;（最后一个 default 可不加，因为已到结构末尾）。
  tags: [counter-example, switch, break, fall-through]

- id: ce10
  title: scanf 忘记加取地址符 &
  type: counter-example
  source_chapter: 第3章 §3.5.4 使用 scanf 函数时应注意的问题(1)
  source_quote: |
    "scanf 函数中的格式控制后面应当是变量地址，而不是变量名。例如……如果写成 scanf(\"%f%f%f\",a,b,c); 是不对的。应将'a,b,c'改为'&a,&b,&c'。许多初学者常犯此错误。"
  trap: |
    scanf 需要知道「把数据送到哪里」，因此要的是地址（&a）而不是变量的值（a）。
    漏掉 & 时，scanf 把变量的当前值当地址用，写入随机内存。
  warning_sign: 输入后变量值不变（仍是初值）；程序崩溃；编译能过但行为异常。
  correct: scanf 的每个数值/字符参数前加 &（字符串数组名本身是地址，不用加 &）。
  tags: [counter-example, scanf, address-of, input]

- id: ce11
  title: 输入 double 却用 %f 格式
  type: counter-example
  source_chapter: 第4章 §4.1 例4.1 程序分析(2)
  source_quote: |
    "在用scanf函数输入双精度实型数据时，不能用'%f'格式声明，而应当用'%1f'格式声明。即在格式符f的前面加修饰符l（小写字母），表示是'长浮点型'，即双精度型。"
    （注：原文此处的 %1f 为扫描件把 %lf 识别成 %1f，按上下文应为 %lf。）
  trap: |
    float 与 double 都用 %f 的直觉是错的：scanf 输入时 double 必须用 %lf。
    用 %f 读 double 只写入 4 字节，高 4 字节保留垃圾，得到的值完全不对。
    （输出时 %f 可用于 double，这是另一个易混淆点。）
  warning_sign: 输入的浮点数读出来是天文数字或 0；同一数值输出与输入不一致。
  correct: double 输入用 %lf；float 输入用 %f；输出两者都可用 %f 或 %m.nf。
  tags: [counter-example, scanf, format-specifier, double]

- id: ce12
  title: 不关闭文件——缓冲区数据丢失
  type: counter-example
  source_chapter: 第10章 §10.2.2 用 fclose 函数关闭数据文件
  source_quote: |
    "如果不关闭文件就结束程序运行将会丢失数据。因为，在向文件写数据时，是先将数据输出到缓冲区，待缓冲区充满后才正式输出给文件。如果当数据未充满缓冲区时程序结束运行，就有可能使缓冲区中的数据丢失。"
  trap: |
    以为「写了 fputc/fprintf 就等于写进磁盘」。实际是先写内存缓冲区，
    缓冲区未满时程序结束，这批数据就没落盘。
  warning_sign: 文件内容比预期少；程序运行「成功」但文件末尾缺数据；小数据量时尤其明显。
  correct: 每个打开的文件在程序结束前都 fclose；或用 exit 前确保已关闭。
  tags: [counter-example, file-io, fclose, data-loss, buffer]

- id: ce13
  title: 字符串常量误用单撇号
  type: counter-example
  source_chapter: 第3章 §3.2.1 常量（字符串常量）
  source_quote: |
    "如'boy','123'等，用双撇号把若干个字符括起来，字符串常量是双撇号中的全部字符（但不包括双撇号本身）。注意不能错写成'CHINA','boy','123'。单撇号内只能包含一个字符，双撇号内可以包含一个字符串。"
  trap: |
    单撇号是「字符常量」，只能装一个字符；双撇号是「字符串常量」，可装多个字符。
    把 "boy" 写成 'boy' 属于多字符常量，值是实现定义的，几乎肯定不是你想要的结果。
  warning_sign: 涉及字符串的判断/输出出现奇怪数值；printf 输出成乱码或单个字符。
  correct: 字符用单撇号 'a'；字符串用双撇号 "boy"。
  tags: [counter-example, literal, char-vs-string, quotes]

- id: ce14
  title: 混淆「指针」与「指针变量」
  type: counter-example
  source_chapter: 第8章 §8.9 有关指针的小结(3)
  source_quote: |
    "要区别指针和指针变量。指针就是地址，而指针变量是用来存放地址的变量。有人认为指针是类型名，指针的值是地址。这是不对的。类型是没有值的，只有变量才有值，正确的说法是指针变量的值是一个地址。不要杜撰出'地址的值'这样莫须有的名词。"
  trap: |
    把「指针」当成一种变量、把「指针的值」当成额外概念，越说越乱。
    正确的层次是：指针＝地址（一个值）；指针变量＝存放地址的变量（它的值就是那个地址）。
    同理 §8.1 强调：可以说「变量 i 的指针是 2000」，不能说「i 的指针变量是 2000」。
  warning_sign: 描述指针时用词混乱、说不清 &p 和 p 分别是什么。
  correct: 严格区分三者：地址（值）、指针变量（存地址的变量）、基类型（指向什么类型）。
  tags: [counter-example, pointer, terminology, concept-confusion]

- id: ce15
  title: else 的悬空配对（与最近的 if 配对）
  type: counter-example
  source_chapter: 第4章 §4.6 选择结构的嵌套
  source_quote: |
    "编程序者把else写在与第1个if（外层if）同一列上，意图是使else与第1个if对应，但实际上else是与第2个if配对，因为它们相距最近。为了避免二义性的混淆，最好使内嵌if语句也包含else部分……这样if的数目和else的数目相同，从内层到外层一一对应，不致出错。"
  trap: |
    C 规定 else 与「离它最近且尚未配对的 if」配对，与缩进无关。
    想让 else 属于外层 if，却因为内层 if 没有 else 而被它抢走，逻辑悄悄改变。
  warning_sign: 分支走向与缩进显示的意图不符；某个条件分支永远不执行。
  correct: 内层 if 补上 else（哪怕空 else），或给内层 if 加花括号明确范围；保持 if/else 数量一一对应。
  tags: [counter-example, if-else, dangling-else, nesting]

- id: ce16
  title: 数组长度用变量定义（变长数组的误用）
  type: counter-example
  source_chapter: 第6章 §6.1.1 怎样定义一维数组(3)
  source_quote: |
    "常量表达式中可以包括常量和符号常量，如'int a[3+5];'是合法的。不能包含变量，如'int a[n];'是不合法的。也就是说，C 语言不允许对数组的大小作动态定义，即数组的大小不依赖于程序运行过程中变量的值。"
  trap: |
    想按运行期输入的大小开数组，写 int n; scanf("%d",&n); int a[n]; ——在本书所依据的
    经典 C（C89/C99 之前常见编译环境）里不合法。
  warning_sign: 编译报「数组长度不是常量」类错误；换编译环境后行为不一致。
  correct: 数组长度用常量或符号常量（#define N 100）；需要运行期决定大小用动态内存分配（malloc）。
  tags: [counter-example, array, constant-expression, vla]

- id: ce17
  title: 递归缺少终止条件——无限递归
  type: counter-example
  source_chapter: 第7章 §7.6 函数的递归调用
  source_quote: |
    "这两种递归调用都是无终止的自身调用。显然，程序中不应出现这种无终止的递归调用，而只应出现有限次数的、有终止的递归调用，这可以用if语句来控制，只有在某一条件成立时才继续执行递归调用；否则就不再继续。"
  trap: |
    只写了「n 的问题化为 n-1 的问题」，却没写「n 到什么值就直接返回」。
    递归会一直展开，直到栈溢出（崩溃）。
  warning_sign: 程序运行时崩溃/栈溢出；递归函数里只有递归调用没有 if 出口。
  correct: 递归函数必须有两部分：①终止条件（基例，如 n==1 直接给值）；②向基例收敛的递归调用。
  tags: [counter-example, recursion, base-case, stack-overflow]

- id: ce18
  title: 混淆「结构体类型」与「结构体变量」
  type: counter-example
  source_chapter: 第9章 §9.1 定义和使用结构体变量
  source_quote: |
    "结构体类型与结构体变量是不同的概念，不要混淆。只能对变量赋值、存取或运算，而不能对一个类型赋值、存取或运算。在编译时，对类型是不分配空间的，只对变量分配空间。"
  trap: |
    struct Student 是「类型」（模板，不占空间），struct Student s1 才是「变量」（占空间、能存取）。
    对类型赋值/取成员是非法的；类型只是用来定义变量的样板。
  warning_sign: 编译报「expected expression」类错误；试图给 struct Student 直接赋值。
  correct: 先用 struct 声明类型，再用该类型名定义变量；一切赋值与成员访问都针对变量。
  tags: [counter-example, struct, type-vs-variable, declaration]
```
