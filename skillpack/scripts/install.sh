#!/usr/bin/env bash
# 安装 C程序设计（第五版）C 语言学习技能包
set -euo pipefail

PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

MODE=""
SCOPE=""
PROJECT_PATH=""
FORCE=0

PACK_SKILLS=(
  program-skeleton
  algorithm-design
  control-flow
  array-and-string
  function-and-recursion
  pointer-model
  c-programming-tan5-reference
)
SINGLE_SKILLS=(c-programming-tan5)

c_reset=$'\033[0m'; c_b=$'\033[1m'; c_g=$'\033[32m'; c_y=$'\033[33m'; c_r=$'\033[31m'; c_d=$'\033[2m'
say()  { printf '%s\n' "$*"; }
ok()   { printf '%s✓%s %s\n' "$c_g" "$c_reset" "$*"; }
warn() { printf '%s!%s %s\n' "$c_y" "$c_reset" "$*"; }
die()  { printf '%s✗%s %s\n' "$c_r" "$c_reset" "$*" >&2; exit 1; }

usage() {
  cat <<'EOF'
用法:
  install.sh --pack   --project <工作目录>   # 装 7 入口形态到该目录下 .workbuddy-ai/skills/
  install.sh --single --project <工作目录>   # 装 1 入口形态
  install.sh --pack   --user                 # 装到 ~/.workbuddy-ai/skills/

选项:
  --pack           7 入口形态（最优命中 91.7%，占 7 个技能位）
  --single         1 入口形态（最优命中 80%，占 1 个技能位）
  --project <路径>  装到 <路径>/.workbuddy-ai/skills/
  --user           装到 ~/.workbuddy-ai/skills/
  --force          覆盖已存在的同名 skill
  -h, --help       显示本帮助

注意: --pack 与 --single 只能选一个；--project 与 --user 只能选一个。
      装完请新开一个会话，技能列表才会刷新。
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pack)    MODE="pack"; shift ;;
    --single)  MODE="single"; shift ;;
    --project) SCOPE="project"; PROJECT_PATH="${2:-}"; shift 2 ;;
    --user)    SCOPE="user"; shift ;;
    --force)   FORCE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "未知参数: $1（用 --help 看用法）" ;;
  esac
done

[[ -n "$MODE"  ]] || die "必须指定 --pack 或 --single"
[[ -n "$SCOPE" ]] || die "必须指定 --project <路径> 或 --user"

if [[ "$SCOPE" == "project" ]]; then
  [[ -n "$PROJECT_PATH" ]] || die "--project 后面要跟工作目录路径"
  [[ -d "$PROJECT_PATH" ]] || die "目录不存在: $PROJECT_PATH"
  DEST="$(cd "$PROJECT_PATH" && pwd)/.workbuddy-ai/skills"
else
  DEST="$HOME/.workbuddy-ai/skills"
fi

if [[ "$MODE" == "pack" ]]; then
  SRC="$PKG_DIR/pack"; NAMES=("${PACK_SKILLS[@]}")
else
  SRC="$PKG_DIR/single"; NAMES=("${SINGLE_SKILLS[@]}")
fi

say ""
say "${c_b}C程序设计（第五版）C 语言学习技能包 · 安装${c_reset}"
say "${c_d}形态: $MODE   目标: $DEST${c_reset}"
say ""

# 源检查
[[ -d "$SRC" ]] || die "包内缺少 $MODE 目录，包可能不完整（先跑 scripts/verify.sh）"
for n in "${NAMES[@]}"; do
  [[ -f "$SRC/$n/SKILL.md" ]] || die "包内缺少 $SRC/$n/SKILL.md"
done

# 冲突检查（含跨形态冲突）
mkdir -p "$DEST"
CONFLICT=()
for n in "${NAMES[@]}"; do
  [[ -e "$DEST/$n" ]] && CONFLICT+=("$n")
done
# 跨形态互斥：装 pack 时看 single 在不在，反之亦然
if [[ "$MODE" == "pack" && -e "$DEST/c-programming-tan5" ]]; then
  warn "检测到已安装 single 形态（c-programming-tan5）"
  if [[ $FORCE -eq 1 ]]; then
    rm -rf "$DEST/c-programming-tan5"; ok "已移除 single 形态（避免两套 description 抢意图）"
  else
    die "请先卸载 single 形态，或加 --force 自动处理"
  fi
fi
if [[ "$MODE" == "single" ]]; then
  OTHER=()
  for n in "${PACK_SKILLS[@]}"; do [[ -e "$DEST/$n" ]] && OTHER+=("$n"); done
  if [[ ${#OTHER[@]} -gt 0 ]]; then
    warn "检测到已安装 pack 形态（${#OTHER[@]} 个入口）"
    if [[ $FORCE -eq 1 ]]; then
      for n in "${OTHER[@]}"; do rm -rf "$DEST/$n"; done
      ok "已移除 pack 形态"
    else
      die "请先卸载 pack 形态，或加 --force 自动处理"
    fi
  fi
fi

if [[ ${#CONFLICT[@]} -gt 0 && $FORCE -eq 0 ]]; then
  warn "以下同名 skill 已存在:"
  printf '    %s\n' "${CONFLICT[@]}"
  die "加 --force 覆盖"
fi

# 复制
say "复制文件 ..."
for n in "${NAMES[@]}"; do
  rm -rf "$DEST/$n"
  cp -R "$SRC/$n" "$DEST/$n"
  ok "$n"
done

# 校验
say ""
say "校验 ..."
FAIL=0
for n in "${NAMES[@]}"; do
  f="$DEST/$n/SKILL.md"
  if [[ ! -f "$f" ]]; then
    warn "$n: 缺少 SKILL.md"; FAIL=1; continue
  fi
  if ! head -1 "$f" | grep -q '^---$'; then
    warn "$n: SKILL.md 缺少 frontmatter"; FAIL=1; continue
  fi
done
# pack 形态额外检查路由入口的 references
if [[ "$MODE" == "pack" ]]; then
  REF="$DEST/c-programming-tan5-reference/references"
  if [[ -d "$REF" ]]; then
    cnt=$(find "$REF" -type f -name '*.md' | wc -l | tr -d ' ')
    [[ "$cnt" -ge 14 ]] && ok "路由入口 references 完整（$cnt 个文档）" || { warn "references 只有 $cnt 个文档，少于预期 14"; FAIL=1; }
  else
    warn "路由入口缺少 references/ 目录"; FAIL=1
  fi
fi

say ""
if [[ $FAIL -eq 0 ]]; then
  ok "${c_b}安装完成${c_reset} —— $MODE 形态，${#NAMES[@]} 个入口"
  say ""
  say "${c_y}下一步：新开一个会话${c_reset}，技能列表是会话启动时加载的，当前会话看不到。"
  say "${c_d}然后正常提问即可，例如「指针到底是什么，我一直没搞懂」。${c_reset}"
  say ""
  say "阅读材料在 $PKG_DIR/docs/ —— 建议从 DIGEST.md 开始。"
  say "卸载: $PKG_DIR/scripts/uninstall.sh $([[ "$SCOPE" == "project" ]] && echo "--project \"$PROJECT_PATH\"" || echo "--user")"
else
  die "安装完成但有校验警告，请检查上面提示"
fi
