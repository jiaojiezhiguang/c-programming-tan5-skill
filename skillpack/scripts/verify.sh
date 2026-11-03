#!/usr/bin/env bash
# 校验 C程序设计（第五版）C 语言学习技能包的完整性
set -uo pipefail

PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCOPE=""
PROJECT_PATH=""

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
bad()  { printf '%s✗%s %s\n' "$c_r" "$c_reset" "$*"; }
warn() { printf '%s!%s %s\n' "$c_y" "$c_reset" "$*"; }
die()  { printf '%s✗%s %s\n' "$c_r" "$c_reset" "$*" >&2; exit 2; }

usage() {
  cat <<'EOF'
用法:
  verify.sh                  # 只校验包本体（不检查安装）
  verify.sh --project <目录>  # 校验包本体 + 该项目下的安装
  verify.sh --user           # 校验包本体 + 用户级安装
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) SCOPE="project"; PROJECT_PATH="${2:-}"; shift 2 ;;
    --user)    SCOPE="user"; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "未知参数: $1" ;;
  esac
done

FAIL=0
say() { :; }

echo ""
echo "${c_b}[1/4] 包本体结构${c_reset}"
for d in pack single docs scripts; do
  [[ -d "$PKG_DIR/$d" ]] && ok "$d/" || { bad "缺少 $d/"; FAIL=1; }
done
for f in README.md INSTALL.md LICENSE-NOTICE.md SKILLPACK.json; do
  [[ -f "$PKG_DIR/$f" ]] && ok "$f" || { bad "缺少 $f"; FAIL=1; }
done

echo ""
echo "${c_b}[2/4] pack 形态入口（7 个）${c_reset}"
for n in "${PACK_SKILLS[@]}"; do
  f="$PKG_DIR/pack/$n/SKILL.md"
  if [[ ! -f "$f" ]]; then bad "$n: 缺 SKILL.md"; FAIL=1; continue; fi
  head -1 "$f" | grep -q '^---$' || { bad "$n: 缺 frontmatter"; FAIL=1; continue; }
  name=$(sed -n 's/^name:[[:space:]]*//p' "$f" | head -1)
  if [[ "$name" != "$n" ]]; then bad "$n: name 字段是 '$name'，与目录名不符"; FAIL=1; continue; fi
  ok "$n"
done
REF_CARDS=$(find "$PKG_DIR/pack/c-programming-tan5-reference/references/capabilities" -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
if [[ "$REF_CARDS" -eq 10 ]]; then ok "路由入口含 10 张能力卡"
else bad "路由入口能力卡数量异常: $REF_CARDS（应为 10）"; FAIL=1; fi

echo ""
echo "${c_b}[3/4] single 形态入口（1 个）${c_reset}"
f="$PKG_DIR/single/c-programming-tan5/SKILL.md"
if [[ -f "$f" ]] && head -1 "$f" | grep -q '^---$'; then
  ok "c-programming-tan5"
else
  bad "single/c-programming-tan5/SKILL.md 缺失或格式错误"; FAIL=1
fi
S_CARDS=$(find "$PKG_DIR/single/c-programming-tan5/references/capabilities" -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
[[ "$S_CARDS" -eq 10 ]] && ok "含 10 张能力卡" || { bad "能力卡数量异常: $S_CARDS"; FAIL=1; }

echo ""
echo "${c_b}[4/4] 文件校验和${c_reset}"
if [[ -f "$PKG_DIR/MANIFEST.sha256" ]]; then
  if ( cd "$PKG_DIR" && shasum -a 256 -c MANIFEST.sha256 --quiet ) 2>/dev/null; then
    N=$(wc -l < "$PKG_DIR/MANIFEST.sha256" | tr -d ' ')
    ok "全部通过（$N 个文件）"
  else
    bad "有文件校验失败（包可能被修改或损坏）"
    ( cd "$PKG_DIR" && shasum -a 256 -c MANIFEST.sha256 2>&1 | grep -E 'FAILED|失败' | head -10 )
    FAIL=1
  fi
else
  warn "无 MANIFEST.sha256，跳过（包可能是开发版）"
fi

# 可选：安装检查
if [[ -n "$SCOPE" ]]; then
  if [[ "$SCOPE" == "project" ]]; then
    [[ -n "$PROJECT_PATH" ]] || die "--project 后面要跟目录"
    DEST="$(cd "$PROJECT_PATH" 2>/dev/null && pwd)/.workbuddy-ai/skills" || die "目录不存在: $PROJECT_PATH"
  else
    DEST="$HOME/.workbuddy-ai/skills"
  fi
  echo ""
  echo "${c_b}[附加] 已安装检查  ($DEST)${c_reset}"
  P=0; S=0
  for n in "${PACK_SKILLS[@]}"; do [[ -f "$DEST/$n/SKILL.md" ]] && P=$((P+1)); done
  for n in "${SINGLE_SKILLS[@]}"; do [[ -f "$DEST/$n/SKILL.md" ]] && S=$((S+1)); done
  if [[ $P -eq 7 && $S -eq 0 ]]; then ok "已安装 pack 形态（7/7）"
  elif [[ $P -eq 0 && $S -eq 1 ]]; then ok "已安装 single 形态（1/1）"
  elif [[ $P -gt 0 && $S -gt 0 ]]; then
    warn "同时装了 pack($P) 和 single($S) —— 两套 description 会抢意图，建议卸掉一个"
    FAIL=1
  else
    warn "未检测到安装（pack $P/7，single $S/1）"
  fi
fi

echo ""
if [[ $FAIL -eq 0 ]]; then
  echo "${c_g}${c_b}✓ 校验通过${c_reset}"
  exit 0
else
  echo "${c_r}${c_b}✗ 发现问题，请按上面提示修复${c_reset}"
  exit 1
fi
