#!/usr/bin/env bash
# 卸载 C程序设计（第五版）C 语言学习技能包
# 只删除本包安装的目录，不碰其他 skill。
set -euo pipefail

SCOPE=""
PROJECT_PATH=""
DRY=0

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
ok()   { printf '%s✓%s %s\n' "$c_g" "$c_reset" "$*"; }
warn() { printf '%s!%s %s\n' "$c_y" "$c_reset" "$*"; }
die()  { printf '%s✗%s %s\n' "$c_r" "$c_reset" "$*" >&2; exit 1; }

usage() {
  cat <<'EOF'
用法:
  uninstall.sh --project <工作目录>    # 从该目录下 .workbuddy-ai/skills/ 卸载
  uninstall.sh --user                  # 从 ~/.workbuddy-ai/skills/ 卸载

选项:
  --project <路径>  要卸载的工作目录
  --user            卸载用户级安装
  --dry-run         只显示会删什么，不真删
  -h, --help        显示本帮助

说明: 自动识别装的是 pack 还是 single 形态，只删本包的目录。
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) SCOPE="project"; PROJECT_PATH="${2:-}"; shift 2 ;;
    --user)    SCOPE="user"; shift ;;
    --dry-run) DRY=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "未知参数: $1（用 --help 看用法）" ;;
  esac
done

[[ -n "$SCOPE" ]] || die "必须指定 --project <路径> 或 --user"

if [[ "$SCOPE" == "project" ]]; then
  [[ -n "$PROJECT_PATH" ]] || die "--project 后面要跟工作目录路径"
  [[ -d "$PROJECT_PATH" ]] || die "目录不存在: $PROJECT_PATH"
  DEST="$(cd "$PROJECT_PATH" && pwd)/.workbuddy-ai/skills"
else
  DEST="$HOME/.workbuddy-ai/skills"
fi

[[ -d "$DEST" ]] || { warn "目录不存在，无需卸载: $DEST"; exit 0; }

FOUND=()
for n in "${PACK_SKILLS[@]}" "${SINGLE_SKILLS[@]}"; do
  [[ -e "$DEST/$n" ]] && FOUND+=("$n")
done

if [[ ${#FOUND[@]} -eq 0 ]]; then
  warn "没有找到本包安装的 skill（目标: $DEST）"
  exit 0
fi

echo ""
echo "${c_b}即将卸载 ${#FOUND[@]} 个目录${c_reset}  (目标: $DEST)"
printf '  %s\n' "${FOUND[@]}"
echo ""

if [[ $DRY -eq 1 ]]; then
  warn "--dry-run 模式，未实际删除"
  exit 0
fi

for n in "${FOUND[@]}"; do
  rm -rf "$DEST/$n"
  ok "已删除 $n"
done

# 若目录空了，顺手提示（不自动删，避免误删别人的东西）
REMAIN=$(find "$DEST" -mindepth 1 -maxdepth 1 | wc -l | tr -d ' ')
echo ""
if [[ "$REMAIN" -eq 0 ]]; then
  warn "$DEST 现在为空，可以手动删除该目录"
else
  ok "卸载完成。该目录下还留有 $REMAIN 个其他 skill，未受影响"
fi
echo ""
echo "${c_y}新开一个会话后，这些技能才会从列表消失。${c_reset}"
