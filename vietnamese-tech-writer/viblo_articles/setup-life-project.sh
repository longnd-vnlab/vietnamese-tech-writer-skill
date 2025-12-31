#!/bin/bash

echo "🚀 Setting up Life 2026 GitHub Project..."
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "Please install it first:"
    echo "  macOS: brew install gh"
    echo "  Ubuntu: sudo apt install gh"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub."
    echo "Please run: gh auth login"
    exit 1
fi

USERNAME=$(gh api user -q .login)
REPO_NAME="life"

echo "📦 Creating private repo '$REPO_NAME' for user '$USERNAME'..."

# Check if repo already exists
if gh repo view "$USERNAME/$REPO_NAME" &> /dev/null; then
    echo "⚠️  Repo '$REPO_NAME' already exists."
    read -p "Do you want to delete and recreate it? (yes/no): " CONFIRM
    if [ "$CONFIRM" = "yes" ]; then
        echo "Deleting existing repo..."
        gh repo delete "$USERNAME/$REPO_NAME" --yes
    else
        echo "Aborting."
        exit 1
    fi
fi

# 1. Create private repo
gh repo create "$REPO_NAME" --private --description "Personal life planning & tracking"

# 2. Clone repo
TEMP_DIR="/tmp/$REPO_NAME-setup"
rm -rf "$TEMP_DIR"
git clone "https://github.com/$USERNAME/$REPO_NAME" "$TEMP_DIR"
cd "$TEMP_DIR"

# 3. Create README
cat > README.md << 'EOF'
# Life 2026

Personal life planning & tracking system.

## Categories
- Finance (tài chính)
- Health (sức khỏe)
- Family (gia đình)
- Learning (học tập)
- Career (sự nghiệp)
- Hobbies (sở thích)

## Priority Levels
- P0: Urgent & Important
- P1: Important, not urgent
- P2: Nice to have
- P3: Someday/maybe

## Workflow
```
Backlog → Todo → In Progress → Done
```

## Setup
1. Create GitHub Project (Board template)
2. Link issues to project
3. Start planning!
EOF

git add README.md
git commit -m "Initial commit: Add README"
git push

echo ""
echo "✅ Repo created and README committed"
echo ""

# 4. Create labels
echo "🏷️  Creating labels..."

gh label create "urgent" --color "d73a4a" --description "Việc gấp cần làm ngay" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - urgent already exists"
gh label create "recurring" --color "0075ca" --description "Việc lặp lại định kỳ" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - recurring already exists"
gh label create "waiting" --color "fbca04" --description "Đang chờ điều kiện" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - waiting already exists"
gh label create "goal-2026" --color "7057ff" --description "Mục tiêu lớn của năm" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - goal-2026 already exists"
gh label create "quick-win" --color "0e8a16" --description "Việc nhanh, tạo động lực" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - quick-win already exists"

# Categories
gh label create "finance" --color "d4c5f9" --description "Tài chính" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - finance already exists"
gh label create "health" --color "c5def5" --description "Sức khỏe" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - health already exists"
gh label create "family" --color "fef2c0" --description "Gia đình" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - family already exists"
gh label create "learning" --color "bfdadc" --description "Học tập" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - learning already exists"
gh label create "career" --color "d93f0b" --description "Sự nghiệp" --repo "$USERNAME/$REPO_NAME" 2>/dev/null || echo "  - career already exists"

echo "✅ Labels created"
echo ""

# 5. Create sample issues
echo "📝 Creating sample issues..."

gh issue create --repo "$USERNAME/$REPO_NAME" \
  --title "Setup GitHub Projects workflow" \
  --body "- [ ] Tạo GitHub Project với Board template
- [ ] Tạo custom fields (Priority, Category, Status)
- [ ] Setup automation rules
- [ ] Tạo roadmap Q1 2026
- [ ] Review workflow hằng tuần" \
  --label "goal-2026,quick-win"

gh issue create --repo "$USERNAME/$REPO_NAME" \
  --title "Thiết lập auto-saving 10 triệu/tháng" \
  --body "Setup tự động chuyển tiền từ tài khoản chính sang tài khoản tiết kiệm

**Action items:**
- [ ] Mở tài khoản tiết kiệm
- [ ] Setup auto-transfer trên banking app
- [ ] Monitor first month" \
  --label "finance,urgent"

gh issue create --repo "$USERNAME/$REPO_NAME" \
  --title "Đăng ký khám sức khỏe định kỳ" \
  --body "Book lịch khám tổng quát 6 tháng/lần

**Next appointment:** Q2 2026" \
  --label "health,recurring"

echo "✅ Sample issues created"
echo ""
echo "================================================"
echo "✅ Setup completed successfully!"
echo "================================================"
echo ""
echo "📍 Repo URL: https://github.com/$USERNAME/$REPO_NAME"
echo ""
echo "🎯 Next steps:"
echo "   1. Open: https://github.com/$USERNAME/$REPO_NAME"
echo "   2. Click 'Projects' tab → 'New project'"
echo "   3. Choose 'Board' template"
echo "   4. Name it 'Life 2026'"
echo "   5. Link issues to project"
echo ""
echo "💡 Tips:"
echo "   - View issues: gh issue list --repo $USERNAME/$REPO_NAME"
echo "   - Create new issue: gh issue create --repo $USERNAME/$REPO_NAME"
echo "   - View repo: gh repo view $USERNAME/$REPO_NAME --web"
echo ""
echo "Happy planning! 🚀"
