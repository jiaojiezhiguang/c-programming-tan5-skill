# 触发评测判分 — array-and-string

- runs: 12（TP 7 / FP 0 / FN 0 / TN 5）
- precision 1.000 / recall 1.000 / **F1 1.000**
- 兄弟混淆率: 0.000（0/2）

| case | expected | selected | 判定 |
|---|---|---|---|
| should-trigger-01#r1 | should_trigger | array-and-string | TP |
| should-trigger-02#r1 | should_trigger | array-and-string | TP |
| should-trigger-03#r1 | should_trigger | array-and-string | TP |
| should-trigger-04#r1 | should_trigger | array-and-string | TP |
| should-trigger-05#r1 | should_trigger | array-and-string | TP |
| should-trigger-06#r1 | should_trigger | array-and-string | TP |
| sibling-01#r1 | sibling | pointer-model | OK |
| sibling-02#r1 | sibling | control-flow | OK |
| should-not-trigger-01#r1 | should_not_trigger | none | TN |
| should-trigger-07#r1 | should_trigger | array-and-string | TP |
| edge-01#r1 | edge_case | none | TN |
| edge-02#r1 | edge_case | none | TN |

> 本报告只给原始配对计数与比率；统计非劣需预注册界值 + McNemar/配对 Bootstrap（§10.3），不在此自动宣布。
