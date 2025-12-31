# Năm 2026, Mình Sẽ Dùng GitHub Projects Để Lên Kế Hoạch Cuộc Sống

## Tản mạn: Khi nhận ra công cụ đang dùng hằng ngày có thể làm được nhiều hơn thế

Có những hôm đang ngồi planning sprint cho team trên GitHub Projects, tự nhiên nghĩ: "**Ơ, công cụ này ngon vậy sao mình chỉ dùng cho công việc nhỉ?**"

Anh em dev chúng mình thì ai cũng quen với GitHub Projects rồi:
- Sprint planning → Issues + Projects
- Bug tracking → Labels + Milestones
- Feature roadmap → Timeline view
- Daily standup → Board view

Mọi thứ đều rất smooth, đặc biệt trong thời đại **AI-first** này khi GitHub Copilot có thể tự động tạo issues, suggest tasks, thậm chí là auto-assign work.

![GitHub Projects Board](https://images.viblo.asia/843b073e-5483-496b-be17-816598153ec6.png)

**Vậy tại sao không dùng nó để quản lý... cuộc sống?**

Đó là câu hỏi mình tự hỏi mình vào cuối năm 2025, và quyết định **từ năm 2026 sẽ dùng GitHub Projects để lên kế hoạch cuộc sống**.

Bài viết này chia sẻ lý do tại sao, và cách mình setup.

## Tại sao GitHub Projects? Vì mình đang dùng nó hằng ngày

### Ưu điểm khi dùng công cụ quen thuộc

**Không phải học công cụ mới**

Mình đã dùng GitHub Projects cho:
- Dự án công ty (tracking features, bugs, tech debt)
- Side projects (planning releases, managing backlog)
- Open source contributions (organizing issues)

Workflow đã quen rồi, apply vào cuộc sống rất tự nhiên.

**GitHub Projects thực sự mạnh**

Nhiều người nghĩ GitHub Projects chỉ đơn giản, nhưng thực ra nó có đầy đủ features của một công cụ project management chuyên nghiệp:
- Multiple views: Board (Kanban), Table, Timeline (Roadmap)
- Custom fields: Priority, Status, Estimate, Due date...
- Automation: Auto-move cards, auto-assign labels
- Filtering & Grouping: Powerful query syntax
- GitHub integration: Link với repos, PRs, discussions

[GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)

### So sánh với các công cụ khác

| Công cụ | Ưu điểm | Nhược điểm | Chi phí |
|---------|---------|------------|---------|
| **GitHub Projects** | Miễn phí, quen thuộc, AI integration | Mobile app yếu | Free |
| **Notion** | Đẹp, linh hoạt | Chậm, phức tạp setup | $10/mo |
| **Todoist** | Mobile app tốt | Premium features cần trả phí | $5/mo |
| **Linear** | UX tuyệt vời | Quá focus vào software dev | $8/user |
| **Jira** | Enterprise-grade | Quá nặng cho cá nhân | $7.75/mo |

**Với developer đang dùng GitHub hằng ngày → GitHub Projects là lựa chọn tự nhiên nhất.**

## Context 2025-2026: Thời đại AI-first planning

### GitHub Copilot cho Project Management

Đầu năm 2025, GitHub ra mắt [GitHub Copilot for Project Management](https://www.coursera.org/learn/github-copilot-for-project-management), cho phép:

**Auto-generate issues từ natural language:**
```
Prompt: "Tạo một roadmap cho việc học tiếng Nhật JLPT N3 trong 6 tháng"

→ Copilot tự động tạo:
  - Issue: "Học 1500 từ vựng N3" (Milestone: Month 1-3)
  - Issue: "Luyện ngữ pháp 100 patterns" (Milestone: Month 2-4)
  - Issue: "Làm 10 đề thi thử" (Milestone: Month 4-6)
  - Issue: "Đăng ký thi chính thức" (Due: Month 6)
```

**Smart scheduling & dependencies:**
Visual Studio 2026 có [AI Planning Mode](https://visualstudiomagazine.com/articles/2025/10/23/hands-on-with-new-visual-studio-copilot-planning-feature-preview.aspx), tự động phân tích dependencies và suggest timeline hợp lý.

**Auto-assign tasks:**
Trong team có thể auto-assign. Với personal planning, có thể integrate với calendar để suggest "best time to work on this".

### Workflow AI-assisted hiện đại

```
Your idea (natural language)
    ↓
GitHub Copilot generates structured plan
    ↓
GitHub Projects visualizes & tracks
    ↓
AI suggests adjustments based on progress
```

Đây chính là **workflow planning thế hệ mới**, và mình muốn apply nó vào cuộc sống.

## Setup repo "life" cho năm 2026

### Cách 1: Auto Setup bằng Script (Recommended - 2 phút)

Mình đã viết một script tự động setup mọi thứ. Copy paste vào terminal là xong.

**Prerequisites:**
```bash
# Install GitHub CLI nếu chưa có
# macOS
brew install gh

# Ubuntu/Debian
sudo apt install gh

# Login
gh auth login
```

**Script tự động setup:**

Tạo file `setup-life-project.sh`:

```bash
#!/bin/bash

echo "Setting up Life 2026 GitHub Project..."

# 1. Tạo private repo
echo "Creating private repo..."
gh repo create life --private --description "Personal life planning & tracking"

# 2. Clone repo về local
git clone https://github.com/$(gh api user -q .login)/life
cd life

# 3. Tạo README
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
EOF

git add README.md
git commit -m "Initial commit"
git push

# 4. Tạo labels
echo "Creating labels..."
gh label create "urgent" --color "d73a4a" --description "Việc gấp cần làm ngay"
gh label create "recurring" --color "0075ca" --description "Việc lặp lại định kỳ"
gh label create "waiting" --color "fbca04" --description "Đang chờ điều kiện"
gh label create "goal-2026" --color "7057ff" --description "Mục tiêu lớn của năm"
gh label create "quick-win" --color "0e8a16" --description "Việc nhanh, tạo động lực"

# Categories
gh label create "finance" --color "d4c5f9" --description "Tài chính"
gh label create "health" --color "c5def5" --description "Sức khỏe"
gh label create "family" --color "fef2c0" --description "Gia đình"
gh label create "learning" --color "bfdadc" --description "Học tập"
gh label create "career" --color "d93f0b" --description "Sự nghiệp"

# 5. Tạo sample issues
echo "Creating sample issues..."
gh issue create --title "Setup GitHub Projects workflow" \
  --body "- [ ] Tạo custom fields
- [ ] Setup automation rules
- [ ] Tạo roadmap Q1 2026
- [ ] Review workflow hằng tuần" \
  --label "goal-2026,quick-win"

gh issue create --title "Thiết lập auto-saving 10 triệu/tháng" \
  --body "Setup tự động chuyển tiền từ tài khoản chính sang tài khoản tiết kiệm" \
  --label "finance,urgent"

gh issue create --title "Đăng ký khám sức khỏe định kỳ" \
  --body "Book lịch khám tổng quát 6 tháng/lần" \
  --label "health,recurring"

echo "Done! Repo created at: https://github.com/$(gh api user -q .login)/life"
echo ""
echo "Next steps:"
echo "1. Vào repo → Tab 'Projects' → Create new project"
echo "2. Chọn Board template"
echo "3. Link các issues vào project"
echo ""
echo "Hoặc tự động tạo project bằng gh CLI extension (xem phần dưới)"
```

**Chạy script:**

```bash
chmod +x setup-life-project.sh
./setup-life-project.sh
```

**Tạo Project (manual - 1 phút):**

GitHub CLI hiện chưa hỗ trợ tạo Projects v2, nên phải tạo bằng UI:

1. Vào repo vừa tạo
2. Tab "Projects" → "New project"
3. Chọn "Board" template
4. Done!

**Note:** Có thể dùng `gh extension` để tạo project tự động:

```bash
# Install extension
gh extension install github/gh-projects

# Tạo project (beta)
gh project create --owner @me --title "Life 2026" --format board
```

### Cách 2: Setup Manual (nếu không dùng CLI)

**Bước 1:** Tạo private repo "life" trên GitHub

**Bước 2:** Tạo Project
- Vào repo → Tab "Projects" → "New project"
- Chọn template "Board"
- Columns mặc định: Todo / In Progress / Done

**Bước 3:** Tạo labels và issues
- Tab "Issues" → "Labels" → tạo labels như script trên
- Tạo vài issues để test

**Thời gian:** 5-10 phút

## Lên kế hoạch năm 2026 với GitHub Copilot

### Prompt Engineering cho Life Planning

**Ví dụ 1: Mục tiêu tài chính**

Prompt cho Copilot:
```
Tôi muốn tiết kiệm 100 triệu trong năm 2026 để đầu tư.
Thu nhập: 50 triệu/tháng
Chi phí cố định: 30 triệu/tháng
Hãy tạo plan chi tiết để đạt được mục tiêu này.
```

Copilot có thể generate:
```
- Issue: "Thiết lập auto-transfer 10 triệu/tháng vào tài khoản tiết kiệm"
   - Due: 2026-01-15
   - Priority: P0
   - Category: Finance

- Issue: "Review chi tiêu hằng tháng và tìm cách giảm 2-3 triệu"
   - Recurring: Monthly
   - Priority: P1

- Issue: "Học về đầu tư chứng khoán cơ bản"
   - Due: 2026-03-31
   - Category: Learning, Finance

- Issue: "Mở tài khoản chứng khoán và mua ETF đầu tiên"
   - Due: 2026-04-30
   - Priority: P0
```

**Ví dụ 2: Mục tiêu sức khỏe**

```
Prompt: "Tôi muốn giảm 10kg và chạy được 10km trong năm 2026.
Hiện tại: 75kg, chạy được 3km.
Tạo plan hợp lý."

→ Copilot generates:
  Phase 1 (Month 1-2): Build habit
    - Chạy 3km, 3 lần/tuần
    - Giảm 500 calories/ngày

  Phase 2 (Month 3-4): Increase intensity
    - Chạy 5km, 4 lần/tuần
    - Tham gia group chạy bộ

  Phase 3 (Month 5-6): Target goal
    - Chạy 10km, 3 lần/tuần
    - Đăng ký chạy 10km race
```

### Timeline View cho Long-term Planning

GitHub Projects có **Timeline view** (giống Gantt chart), rất hữu ích cho:

**Roadmap năm 2026:**
```
Q1 2026:
  └─ Thiết lập financial foundation
  └─ Build running habit
  └─ Complete online course X

Q2 2026:
  └─ First 10km race
  └─ Launch side project MVP
  └─ Family vacation planning

Q3 2026:
  └─ Achieve savings milestone
  └─ Complete certification Y

Q4 2026:
  └─ Year-end review & 2027 planning
```

Timeline view giúp visualize **dependencies** và **capacity planning** - không overload bản thân.

## Automation Rules cho Personal Life

### GitHub Actions cho recurring tasks

Mình setup một số GitHub Actions đơn giản:

**Auto-create monthly review issue:**
```yaml
# .github/workflows/monthly-review.yml
name: Monthly Review
on:
  schedule:
    - cron: '0 0 1 * *'  # First day of each month

jobs:
  create-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/github-script@v6
        with:
          script: |
            github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: `Monthly Review - ${new Date().toLocaleDateString('vi-VN', {month: 'long', year: 'numeric'})}`,
              body: `## Review tháng này\n\n- [ ] Xem lại goals đã đạt được\n- [ ] Update progress các goals đang làm\n- [ ] Plan cho tháng tiếp theo\n- [ ] Adjust priorities nếu cần`,
              labels: ['recurring', 'review']
            })
```

**Auto-close stale issues:**
```yaml
# .github/workflows/stale.yml
name: Close stale issues
on:
  schedule:
    - cron: '0 0 * * 0'  # Every Sunday

jobs:
  stale:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/stale@v8
        with:
          stale-issue-message: 'Issue này đã không có hoạt động 3 tháng. Có thể bỏ qua?'
          close-issue-message: 'Auto-closed do không còn relevant.'
          days-before-stale: 90
          days-before-close: 7
```

### Project Automation (built-in)

GitHub Projects có automation rules built-in, không cần code:

**Auto-move cards:**
```
When: Issue is closed
Then: Move to "Done" column
```

**Auto-add labels:**
```
When: Issue is added to project
If: Priority is "P0"
Then: Add label "urgent"
```

**Auto-assign:**
```
When: Issue moved to "In Progress"
Then: Assign to @me
```

## Workflow hằng ngày với GitHub Projects

### Morning routine (5 phút)

```
1. Mở GitHub Projects board
2. Review "In Progress" column (việc đang làm)
3. Check "To Do" column, pick 2-3 việc quan trọng nhất
4. Drag vào "In Progress"
```

**Lưu ý:** Không bao giờ để quá 5 items trong "In Progress" - tránh context switching.

### Evening review (5 phút)

```
1. Update progress của các items "In Progress"
2. Move items đã xong sang "Done"
3. Add comments về những gì học được
4. Quick preview plan ngày mai
```

### Weekly review (15 phút - Chủ nhật)

```
1. Review "Done" column - celebrate wins
2. Move items không còn relevant sang "Cancelled"
3. Groom "Backlog" - promote items quan trọng lên "To Do"
4. Check Timeline view - có tasks nào bị delay không?
5. Adjust priorities cho tuần tới
```

### Monthly review (30 phút)

```
1. Review metrics:
   - Bao nhiêu issues completed?
   - Categories nào được focus nhiều nhất?
   - Goals lớn progress thế nào?

2. Reflect & adjust:
   - Có việc gì liên tục bị trì hoãn? Tại sao?
   - Có việc gì quick win nhưng tạo value lớn?
   - Cần thay đổi approach không?

3. Plan tháng tiếp theo:
   - Tạo issues mới
   - Set milestones
   - Update timeline
```

## Integration với ecosystem AI-first

### GitHub Copilot Chat trong VS Code

Mình mở repo "life" trong VS Code, có thể chat với Copilot:

```
Me: "Hôm nay nên focus vào task nào?"

Copilot: "Dựa vào priorities và deadlines,
tôi suggest focus vào:
1. 'Hoàn thành bài tập online course' (Due: today, P0)
2. 'Review tài liệu đầu tư' (P1, blocked task đang chờ)
Quick win: 'Book lịch khám răng' (5 phút, high impact)"
```

### Zapier/Make automation

Connect GitHub với các services khác:

**Gmail → GitHub:**
```
Trigger: Email có subject chứa "TODO:"
Action: Tạo GitHub issue trong repo "life"
```

**Google Calendar → GitHub:**
```
Trigger: Event calendar tagged "personal-goal"
Action: Tạo GitHub issue với due date = event date
```

**GitHub → Notion:**
```
Trigger: Issue được label "reflection"
Action: Sync vào Notion journal
```

## Những insights sau khi dùng GitHub Projects cho công việc

### (1) Visualization thay đổi mindset

**Board view** giúp mình nhìn thấy:
- Mình đang overload "In Progress" không?
- Category nào bị neglect?
- Có tasks nào stuck quá lâu?

**Timeline view** giúp:
- Thấy được "big picture"
- Tránh commit quá nhiều trong cùng một thời điểm
- Balance giữa short-term và long-term goals

### (2) Tracking breeds accountability

Khi mọi thứ được track:
- Không thể tự lừa dối bản thân ("Tháng này mình đã làm gì nhỉ?")
- Thấy rõ pattern (ví dụ: liên tục delay tasks về health)
- Data-driven decisions (ví dụ: category Learning chiếm 40% time → cần balance lại)

### (3) Context switching có cost

Từ workflow công việc, mình học được:
- Focus vào 2-3 việc quan trọng/ngày thôi
- Batch similar tasks (ví dụ: tất cả "finance tasks" làm cùng lúc)
- Deep work blocks không bị disturb

### (4) Automation giải phóng mental load

Khi setup automation cho recurring tasks:
- Không cần nhớ "tháng này phải review gì"
- GitHub tự remind
- Tiết kiệm "decision fatigue"

## BÀI HỌC KINH NGHIỆM

Mình đã thử nhiều công cụ quản lý tasks trước đây:

**Todoist** (2022-2023):
- Ưu điểm: Mobile app tốt, quick capture
- Nhược điểm: Premium features đắt, không có timeline view

**Notion** (2023-2024):
- Ưu điểm: Đẹp, flexible
- Nhược điểm: Quá phức tạp, mất 1 tuần setup, đôi khi chậm

**Linear** (2024 - thử 3 tháng):
- Ưu điểm: UX tuyệt vời, keyboard shortcuts
- Nhược điểm: Quá focus vào software dev, không suitable cho personal life

**GitHub Projects** (2025 → 2026):
- Đã quen workflow từ công việc
- Miễn phí, không giới hạn features
- AI integration với Copilot
- Automation built-in
- Powerful filtering & views
- Mobile app yếu (nhưng dùng web mobile cũng OK)

**Kết luận:** Với developer, dùng công cụ mình đang dùng hằng ngày là best choice.

## Kết nối với xu hướng AI-first

Năm 2026 là năm của **AI-assisted everything**. [Theo GitHub](https://github.blog/open-source/accelerate-developer-productivity-with-these-9-open-source-ai-and-mcp-projects/), developers dùng Copilot có:
- **55% productivity increase** trong coding
- **75% higher job satisfaction**

Mình tin tưởng rằng AI-assisted planning cũng sẽ có impact tương tự cho personal life:

**Thay vì:**
- Ngồi 2 tiếng brainstorm plan cho năm mới
- Viết tay từng task
- Tự estimate thời gian (thường sai)
- Quên review và adjust

**Giờ đây:**
- Prompt với Copilot, có plan chi tiết trong 5 phút
- AI suggest tasks breakdown
- AI predict timeline based on past data
- Auto-remind để review

**Productivity tăng → Thời gian dành cho việc thật sự quan trọng.**

## Roadmap cá nhân cho năm 2026

Mình đã setup xong GitHub Projects và tạo roadmap cho năm 2026:

### Q1 2026: Foundation

**Finance:**
- Thiết lập auto-saving 10 triệu/tháng
- Học xong course "Đầu tư chứng khoán cơ bản"
- Mở tài khoản chứng khoán

**Health:**
- Build habit chạy bộ 3 lần/tuần
- Giảm được 3kg (75kg → 72kg)

**Learning:**
- Hoàn thành course "System Design"
- Đọc xong 3 cuốn sách về productivity

### Q2 2026: Momentum

**Health:**
- Chạy được 5km liên tục
- Tham gia running club

**Career:**
- Launch side project MVP
- Contribute vào 2 open source projects lớn

**Family:**
- Plan family vacation (Japan hoặc Korea)

### Q3 2026: Acceleration

**Finance:**
- Đạt 50% savings goal (50 triệu)
- Portfolio đầu tư đa dạng hóa

**Health:**
- Chạy 10km race đầu tiên

**Learning:**
- Complete AWS Solutions Architect certification

### Q4 2026: Reflection & Planning

**Review:**
- Year-end metrics review
- Lessons learned documentation
- Update personal systems

**Planning 2027:**
- Roadmap năm tiếp theo
- Adjust strategies dựa trên data năm 2026

**Tất cả những thứ này được visualize và track trên GitHub Projects.**

## Tips nếu bạn muốn thử

### (1) Start small

Đừng cố gắng track mọi thứ ngay từ đầu. Bắt đầu với:
- 1-2 categories quan trọng nhất (ví dụ: Health + Career)
- 5-10 tasks để làm quen workflow
- Review sau 2 tuần, adjust

### (2) Leverage Copilot

Nếu có GitHub Copilot subscription:
- Dùng nó để generate plans
- Ask for suggestions khi stuck
- Auto-generate sub-tasks cho tasks lớn

Nếu chưa có Copilot, vẫn OK - manual planning vẫn hiệu quả.

### (3) Setup automation sớm

Automation tiết kiệm rất nhiều thời gian:
- Monthly review auto-create
- Stale issues auto-close
- Recurring tasks auto-remind

### (4) Private repo + careful với sensitive data

- Luôn dùng private repo
- Tránh commit sensitive data (passwords, financial details...)
- Dùng GitHub Secrets nếu cần store credentials

### (5) Review & iterate

GitHub Projects không phải silver bullet. Cần:
- Review workflow định kỳ
- Adjust views, fields, automation nếu không fit
- Đơn giản hóa nếu thấy quá phức tạp

> "Tools serve you, not the other way around."

## Kết luận: 2026 - Năm của AI-assisted life planning

Năm 2026, mình không còn dùng:
- Nhiều công cụ rời rạc (Todoist, Notion, Google Keep...)
- Manual planning mất nhiều thời gian
- Nhớ đâu làm đấy approach

Thay vào đó:
- **Một công cụ duy nhất:** GitHub Projects
- **AI-assisted planning:** GitHub Copilot
- **Data-driven decisions:** Metrics & insights từ tracking
- **Automation:** Giảm mental load

Với developer đang dùng GitHub hằng ngày, đây là **natural evolution** trong cách quản lý cuộc sống.

**2025 → 2026: Từ "nhớ đâu làm đấy" sang "AI-assisted systematic planning"**

Nếu bạn cũng đang dùng GitHub Projects cho công việc và thấy hiệu quả, hãy thử apply nó cho cuộc sống. Có thể bạn sẽ surprised với kết quả ^^.

**Năm 2026, chúng ta cùng leverage công cụ quen thuộc để optimize cuộc sống nào!**

---

**Nguồn tham khảo:**

- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [GitHub Copilot for Project Management](https://www.coursera.org/learn/github-copilot-for-project-management)
- [Planning a project with GitHub Copilot](https://docs.github.com/en/copilot/tutorials/plan-a-project)
- [Visual Studio 2026 Copilot Planning Feature](https://visualstudiomagazine.com/articles/2025/10/23/hands-on-with-new-visual-studio-copilot-planning-feature-preview.aspx)
- [AI-Assisted Coding in 2026](https://www.javacodegeeks.com/2025/12/ai-assisted-coding-in-2026-how-github-copilot-cursor-and-amazon-q-are-reshaping-developer-workflows.html)
- [Accelerate developer productivity with AI and MCP projects](https://github.blog/open-source/accelerate-developer-productivity-with-these-9-open-source-ai-and-mcp-projects/)

---
*telegram: dinhlongit*
