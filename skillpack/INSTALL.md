# 安装说明

三种装法，按你的情况选一种。**装完必须新开一个会话才生效**——技能列表是会话启动时加载的。

---

## 先搞清楚：装到哪

WorkBuddy AI 有两个技能目录：

| 位置 | 路径 | 作用范围 |
|---|---|---|
| **项目级**（推荐） | `<你的工作目录>/.workbuddy-ai/skills/` | 只在这个目录打开的会话里生效 |
| **用户级** | `~/.workbuddy-ai/skills/` | 所有项目都能用 |

**推荐项目级**，理由：

1. 不污染全局技能列表——别人看你的技能列表不会看到一堆 `program-skeleton`、`control-flow` 这种通用名字
2. C 语言学习是有边界的（比如你只在某个课程/某个项目里用），项目级正好隔离
3. 想删的时候直接删目录，没有残留

---

## 方式一：脚本安装（推荐）

```bash
cd c-programming-tan5-skillpack
chmod +x scripts/*.sh

# 装 pack 形态到项目级（最常用）
./scripts/install.sh --pack --project "/Users/you/my-c-course"

# 装 single 形态到项目级
./scripts/install.sh --single --project "/Users/you/my-c-course"

# 装到用户级
./scripts/install.sh --pack --user
```

脚本会做这些事：

1. 检查目标目录是否存在（不存在会问你要不要创建）
2. 检查是否已有同名 skill（有则提示，加 `--force` 才覆盖）
3. 复制对应形态的全部文件
4. 校验每个入口的 `SKILL.md` 是否完整
5. 打印安装结果和新开会话的提示

### 参数说明

| 参数 | 说明 |
|---|---|
| `--pack` | 装 7 入口形态（最优命中 91.7%） |
| `--single` | 装 1 入口形态（最优命中 80%，但只占 1 个技能位） |
| `--project <路径>` | 装到该路径下的 `.workbuddy-ai/skills/` |
| `--user` | 装到 `~/.workbuddy-ai/skills/` |
| `--force` | 覆盖已存在的同名 skill |

`--pack` 和 `--single` 必选其一，`--project` 和 `--user` 必选其一。

---

## 方式二：手动安装

不想跑脚本就手动复制。

### pack 形态

```bash
TARGET="/你的/工作目录/.workbuddy-ai/skills"
mkdir -p "$TARGET"

cp -R pack/program-skeleton            "$TARGET/"
cp -R pack/algorithm-design            "$TARGET/"
cp -R pack/control-flow                "$TARGET/"
cp -R pack/array-and-string            "$TARGET/"
cp -R pack/function-and-recursion      "$TARGET/"
cp -R pack/pointer-model               "$TARGET/"
cp -R pack/c-programming-tan5-reference "$TARGET/"
```

### single 形态

```bash
TARGET="/你的/工作目录/.workbuddy-ai/skills"
mkdir -p "$TARGET"
cp -R single/c-programming-tan5 "$TARGET/"
```

### 目录应该长这样

```
<工作目录>/.workbuddy-ai/skills/
├── program-skeleton/
│   └── SKILL.md
├── algorithm-design/
│   └── SKILL.md
├── ...
└── c-programming-tan5-reference/
    ├── SKILL.md
    └── references/
        ├── capabilities/*.md
        ├── capability-index.md
        ├── cheatsheet.md
        ├── glossary.md
        └── overview.md
```

**关键**：每个入口目录下必须有 `SKILL.md`，且 `SKILL.md` 顶部有 `---` 包起来的 frontmatter（含 `name` 和 `description`）。少了这个就加载不了。

---

## 方式三：压成 zip 传给同事

```bash
# 你这边
cd dist
zip -r c-programming-tan5-skillpack-v1.0.0.zip c-programming-tan5-skillpack \
    -x "*.DS_Store" -x "__pycache__/*"

# 同事那边
unzip c-programming-tan5-skillpack-v1.0.0.zip
cd c-programming-tan5-skillpack
chmod +x scripts/*.sh
./scripts/install.sh --pack --project "/他的/工作目录"
```

---

## 验证安装

```bash
./scripts/verify.sh --project "/你的/工作目录"
# 或
./scripts/verify.sh --user
```

正常输出：

```
[1/3] 检查安装目录 ... OK
[2/3] 检查入口完整性 ... 7/7 OK
[3/3] 检查文件校验和 ... 24/24 OK
✓ 安装完整（pack 形态，7 个入口）
```

如果报错，看下一节。

---

## 故障排查

### 装完了但 AI 不触发

**最常见原因：没新开会话。** 技能列表在会话启动时加载，当前会话看不到新装的技能。

### 技能列表里看不到

检查三件事：

1. 路径对不对 —— `.workbuddy-ai/skills/` 是**带点**的隐藏目录
2. 是不是装到了错误的位置 —— 项目级要装到你**实际打开的工作目录**下
3. `SKILL.md` 有没有 frontmatter —— 打开看看前几行是不是 `---` 开头

### 触发到了错误的卡

这是真实存在的边界模糊。实测 20 条问题里有 2 条会因语义灰区被送到相邻卡（都是"崩溃/偶发错误"类问题，同时符合 `pointer-model` 和 `program-skeleton`）。可达率仍是 100%，因为相邻卡的 `also_read` 会带出正确内容。

### 装了 pack 又想换 single

```bash
./scripts/uninstall.sh --project "/你的/工作目录"
./scripts/install.sh --single --project "/你的/工作目录"
```

**不要两个形态同时装**——会有 7+1 套 description 抢同一个意图，反而更乱。

### 想彻底删掉

```bash
./scripts/uninstall.sh --project "/你的/工作目录"
# 或者直接
rm -rf "/你的/工作目录/.workbuddy-ai/skills/program-skeleton" \
       "/你的/工作目录/.workbuddy-ai/skills/algorithm-design" \
       "/你的/工作目录/.workbuddy-ai/skills/control-flow" \
       "/你的/工作目录/.workbuddy-ai/skills/array-and-string" \
       "/你的/工作目录/.workbuddy-ai/skills/function-and-recursion" \
       "/你的/工作目录/.workbuddy-ai/skills/pointer-model" \
       "/你的/工作目录/.workbuddy-ai/skills/c-programming-tan5-reference"
```

注意 `uninstall.sh` **只删本包安装的 7 个（或 1 个）目录**，不会碰你的其他 skill。
