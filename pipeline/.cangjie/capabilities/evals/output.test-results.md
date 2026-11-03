# 输出评测机械断言判分 — c-programming-tan5-pack

## o1-leap

| 变体 | 断言通过 | 明细 |
|---|---|---|
| without_skill | 7/7 | ✓contains:main; ✓regex:%\s*4; ✓regex:%\s*100; ✓regex:%\s*400; ✓regex:&&; ✓regex:\|\|; ✓contains:return |
| new_skill | 7/7 | ✓contains:main; ✓regex:%\s*4; ✓regex:%\s*100; ✓regex:%\s*400; ✓regex:&&; ✓regex:\|\|; ✓contains:return |

## o2-bubble

| 变体 | 断言通过 | 明细 |
|---|---|---|
| without_skill | 5/5 | ✓regex:for\s*\(\s*\w+\s*=\s*0\s; ✓regex:<\s*(9\s*-\s*\w+|N\s*-\s; ✓regex:a\[\s*\w+\s*\+\s*1\s*\]; ✓regex:\b\w+\s*=\s*a\[\s*\w+\s*; ✓contains:趟 |
| new_skill | 5/5 | ✓regex:for\s*\(\s*\w+\s*=\s*0\s; ✓regex:<\s*(9\s*-\s*\w+|N\s*-\s; ✓regex:a\[\s*\w+\s*\+\s*1\s*\]; ✓regex:\b\w+\s*=\s*a\[\s*\w+\s*; ✓contains:趟 |

## o3-swap

| 变体 | 断言通过 | 明细 |
|---|---|---|
| new_skill | 4/4 | ✓contains:&a; ✓regex:int\s*\*\s*\w+; ✓contains:*p; ✓regex:值传递|单向 |
| without_skill | 4/4 | ✓contains:&a; ✓regex:int\s*\*\s*\w+; ✓contains:*p; ✓regex:值传递|单向 |

## o4-oob

| 变体 | 断言通过 | 明细 |
|---|---|---|
| without_skill | 4/4 | ✓contains:下标; ✓regex:a\[10\]; ✓regex:i\s*=\s*0; ✓regex:越界|0开始|从0 |
| new_skill | 4/4 | ✓contains:下标; ✓regex:a\[10\]; ✓regex:i\s*=\s*0; ✓regex:越界|0开始|从0 |

## o5-fac

| 变体 | 断言通过 | 明细 |
|---|---|---|
| without_skill | 4/4 | ✓regex:(int|long\s+long|unsigne; ✓regex:n\s*==\s*1|n\s*<=\s*1|n\; ✓contains:return; ✓regex:终止|基例|出口 |
| new_skill | 4/4 | ✓regex:(int|long\s+long|unsigne; ✓regex:n\s*==\s*1|n\s*<=\s*1|n\; ✓contains:return; ✓regex:终止|基例|出口 |

## o6-copy

| 变体 | 断言通过 | 明细 |
|---|---|---|
| without_skill | 5/5 | ✓contains:fopen; ✓contains:fclose; ✓regex:fgetc|fread|fgets; ✓regex:fputc|fwrite|fputs; ✓contains:缓冲区 |
| new_skill | 5/5 | ✓contains:fopen; ✓contains:fclose; ✓regex:fgetc|fread|fgets; ✓regex:fputc|fwrite|fputs; ✓contains:缓冲区 |

## 汇总（全部断言通过的 case 比例）

- new_skill: 6/6；完成 6/6（缺失计入分母）
- without_skill: 6/6；完成 6/6（缺失计入分母）

状态：COMPLETE

> 机械断言先于 LLM judge；A/B 盲评与分歧样本人工复核另行进行，此处不自动宣布非劣。
