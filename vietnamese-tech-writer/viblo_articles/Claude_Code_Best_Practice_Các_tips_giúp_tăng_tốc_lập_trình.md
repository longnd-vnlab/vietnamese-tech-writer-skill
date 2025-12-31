# Claude Code Best Practice: Các tips giúp tăng tốc lập trình

## Mở đầu:
Như mọi người có thể thấy, xu hướng lập trình đang có một bước chuyển dịch lớn: từ việc viết code thủ công như trước đây sang mô hình AI Orchestration. Hầu hết các IDE hiện nay đều dần tích hợp AI-driven development trực tiếp vào trong công cụ của họ. Đây không chỉ là một sự cải tiến nhỏ về năng suất, mà còn là một sự thay đổi mang tính nền tảng trong cách chúng ta xây dựng và vận hành phần mềm.

Người người vibe coding, nhà nhà dùng các công cụ như: Cursor,  Windsurf, Copilot, Claude code...

Mình cũng đang và đã trải nghiệm các công cụ này một thời gian, có tích lũy một chút tips nhỏ share cho mọi người có thể sử dụng các công cụ AI Driven development một cách hiệu quả nhất.

## Best practice khi sử dụng claude code:

### 1. Serena, context7 mcp - Unlock 100% sức mạnh cho AI Coding Agents
Tích hợp Serena MCP vào claude code phải nói là trải nghiệm khá “wow” luôn. Cảm giác như thay vì phải ném cả đống file cho AI “tự mò”, thì giờ nó đọc codebase như một dev kỳ cựu trong team. Share lại để mọi người thử nghịch thử. 

Serena build dựa trên LSP (chuẩn JSON-RPC), nên nó hiểu code theo kiểu symbolic analysis chứ không chỉ text thuần, đây là lý do chính nó đọc hiểu codebase tốt, ngoài ra nó giúp giảm thiểu tiêu thụ tokens rất hiệu quả và tăng độ chính xác khi coding.
Mình có share [ở đây](https://www.linkedin.com/feed/update/urn:li:activity:7368830305090097152/), mọi người có thể tìm hiểu thêm vì sao nó lại hiệu quả như vậy !

```
# Install Serena mcp
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project $(pwd) && uvx --from git+https://github.com/oraios/serena serena project index

# Using:
"Use Serena to analyze the authentication flow and identify potential security vulnerabilities"
"Leverage Serena's LSP analysis to refactor the database access layer for better performance"
```

Ngoài ra có 1 mcp mà mình thấy cũng khá hay là Context7 nó giúp Agent refer document của các library, framework mới nhất để giúp việc code chính xác hơn, best practice hơn

https://github.com/upstash/context7

```
# Install Context7 mcp
claude mcp add -s user context7 -- npx -y @upstash/context7-mcp@latest
```

### 2. SuperClaude Framework  (buff sức mạnh của claude code lên xx lần)
Nếu mọi người đang sử dụng claude code để phục vụ công việc thì đây là một bộ công cụ mở rộng giúp để buff sức mạnh của claude code lên xx lần 
https://github.com/SuperClaude-Org/SuperClaude_Framework

**16 lệnh slash cho các tác vụ phổ biến (implement, build, analyze, v.v.)**

```
Development /sc:implement, /sc:build, /sc:design
Analysis /sc:analyze, /sc:troubleshoot, /sc:explain
Quality /sc:improve, /sc:test, /sc:cleanup
Others /sc:document, /sc:git, /sc:estimate, /sc:task, /sc:index, /sc:load, /sc:spawn
```

**Smart Personas (sử dụng subagent)**
Tự động chọn AI expert phù hợp (architect, frontend, backend, v.v.) Khi cần chuyên môn sâu:

```
architect: Thiết kế hệ thống
frontend: UI/UX và accessibility
backend: API và hạ tầng
analyzer: Gỡ lỗi và phân tích
security: Bảo mật
scribe: Viết tài liệu
```

MCP Integration (Context7, Sequential, Magic, Playwright, Serena,...) thêm khả năng truy xuất tài liệu, tạo UI component và tự động hóa automation test trên browser
![image.png](https://images.viblo.asia/f8a06371-8482-4ca6-a7f5-be2dc23e94a0.png)

### 3. Sử dụng bộ sub agents chuyên biệt:
https://github.com/wshobson/agents

- Đây là một tập hợp gồm 78 subagent chuyên biệt (specialist agents) được thiết kế để tích hợp với Claude Code, nhằm mở rộng khả năng xử lý các bài toán cụ thể theo từng lĩnh vực.
- Mỗi subagent có một vai trò cụ thể, ví dụ như thiết kế kiến trúc backend, phát triển frontend, tối ưu hóa hạ tầng cloud, kiểm thử tự động, ML ops…, và đều được cấu hình sẵn theo “best practices” hiện đại.

```
// Installation
git clone https://github.com/wshobson/agents.git ~/.claude/agents
```

Sau khi cài xong thì bạn có thể sử dụng bằng cách @agent_name như sau:
![image.png](https://images.viblo.asia/860e9181-963f-479e-b60a-845fe37d99f2.png)

### 4. Extended Thinking Modes (Guide claude think sâu hơn)
Claude Code hỗ trợ các chế độ tư duy với mức độ phân tích khác nhau, tùy theo mức độ khó của task thì mình nên prompt thêm các keywork này để claude có thể giải quyết vấn đề tốt hơn

**think**- Cơ bản (4,000 tokens): Các tác vụ refactor cơ bản

**think hard/think deeply** - Chi tiết (10,000 tokens): Thiết kế architecture, tính năng lớn"

**think harder/ultrathink** - Tối đa (31,999 tokens): Tối ưu hóa hệ thống ở mức phức tạp"

### 5. Tạo custom command để reivew pull request:
Dự án của bạn có một số best practice cần tuân theo khi code, bạn là người thường review pull request của team member, một giải pháp nhờ AI pair review giùm bạn để giảm tải công việc, tăng chất lượng code lên nhiều lần:

Install gh CLI để Claude tương tác với GitHub APIs
```
# macOS (Homebrew)
brew install gh


# Ubuntu/Debian

type -p curl >/dev/null || sudo apt-get install -y curl
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y


# Windows (winget)

winget install GitHub.cli

```

**Tạo file**: .claude/commands/review-github-pr.md

```
Please review the GitHub Pull Request: $ARGUMENTS.

Follow these steps:
1. Use `gh pr view $ARGUMENTS --web` or `gh pr view $ARGUMENTS --json title,body,author,files,comments,reviews` to get the PR details.
2. Analyze the changes introduced in the PR (files, code diffs, and commit messages).
3. Check if the PR:
   - Solves the issue it references
   - Separation of responsibilities (single-responsibility processing)
   - Consolidation of common logic
   - Removal of unnecessary code
   - Optimization of API responses
   - Consistency of variable names
   - Following best practice in claude.MD file 

Better error handling
   - Has clear and meaningful commit messages
   - Follows coding standards and conventions
   - Includes necessary tests (unit/integration/e2e if applicable)
   - Updates documentation if required
   - Passes linting and type checks
4. Provide a structured review with:
   - Positives
   - Potential issues / improvements
   - Score x/10
   - Questions for the author
5. Decide whether to **Approve**, **Request Changes**, or **Comment Only** using `gh pr review`:
   - `gh pr review $ARGUMENTS --approve --body "LGTM"`
   - `gh pr review $ARGUMENTS --request-changes --body "Please fix the following issues..."`
   - `gh pr review $ARGUMENTS --comment --body "General feedback..."`
6. Ensure all review comments are constructive and actionable.

Remember: Always use the GitHub CLI (`gh`) for GitHub-related tasks.
```

Cách dùng:
```
/review-github-pr https://github.com/longnd-vnlab/v0-pbh/pull/4
```

![Screenshot from 2025-09-15 09-50-45.png](https://images.viblo.asia/aba943fe-b91b-4c09-bd75-d58831500d67.png)

### 6. Thiết Lập CLAUDE.md cho Các Quy Tắc Global
File `~/.claude/CLAUDE.md` cho phép thiết lập quy tắc áp dụng cho tất cả project.

Giả sử ở **~/.claude/CLAUDE.md** bạn cần thiết
```
# Guidelines

## Top-Level Rules
- **Think exclusively in English** but **respond in Japanese**
- Execute multiple independent processes **concurrently, not sequentially**
- Always use **Context7 MCP** to retrieve latest library information

## Programming Rules
- Avoid hard-coding values unless absolutely necessary
- Do not use `any` or `unknown` types in TypeScript
- You must not use TypeScript `class` unless absolutely necessary
```

Điều này giúp claude code tuân thủ các best practice này khi thực hiện task.

### 7. Cấu Hình Permissions Bảo Mật
File *~/.claude/settings.json* cho phép kiểm soát chi tiết quyền truy cập để tránh Claude vô tình hoặc cố ý làm những thao tác nguy hiểm, thật sự rất quan trọng nhaa.

```
{
  "permissions": {
    "allow": [
      "Read(**)",
      "Write(src/**)",
      "Write(docs/**)",
      "Bash(git status:*)",
      "Bash(npm install:*)",
      "Bash(osascript -e:*)"
    ],
    "deny": [
      "Bash(sudo:*)",
      "Bash(rm -rf:*)",
      "Read(.env.*)",
      "Bash(curl:*)"
    ]
  }
}
```

### 8. Tích Hợp Gemini CLI cho Web Search
Khi chúng ta khai báo trong ~/.claude/commands/search.md như sau:

```
# ~/.claude/commands/search.md
---
allowed-tools: Bash(gemini:*)
description: "Use Gemini CLI for web searches"
---

Use !`gemini -p 'google_web_search:[arguments]'`
```

Nghĩa là Claude Code  sẽ được phép chạy lệnh Gemini CLI (ví dụ gemini -p 'google_web_search:xxx') để thực hiện tìm kiếm trên web để tổng hợp thông tin, research sâu hơn.

### 9. Sử dụng vibe kanban để vibe trên claude code:
https://www.vibekanban.com/
```
// Install vibe kanban
npx vibe-kanban
```

Mình mới sử dụng vibe kanban và thấy kết hợp với claude code để vibe trên nhiều project khá tiện, tool này là một công cụ chuyên dụng để quản lý và điều phối các AI coding agents — như Claude Code, Gemini CLI, Amp, Codex... có thể code và tạo PR cho mình luôn, khá dễ dùng và rât tiện.

**Tính năng:**
Thay vì mở nhiều terminal, IDE... bạn chỉ cần tập trung vào một dashboard duy nhất

Bạn có thể cho chạy các agent song song hoặc nối tiếp, dễ kiểm soát luồng công việc AI code.

Thay vì ngồi đợi agent chạy, mình có thể lập kế hoạch tiếp, review output, hoặc điều chỉnh tiếp
![image.png](https://images.viblo.asia/7cb72b7b-9096-4de6-b852-f811391cdf86.png)

### 10. Theo dõi và tối ưu token usage:
Công cụ này cho phép mình xem lượng token sử dụng mỗi ngày của claude code

```
# Install CC Usage tool
npx ccusage@latest

# Monitor real-time 
/cost   # report usage
```

![Screenshot from 2025-09-12 15-32-55.png](https://images.viblo.asia/f8102cb1-e6ce-4946-bdc8-d4675ad0fb07.png)
### 11 Quản lý context window để tránh token lãng phí:
- Sử dụng /clear thường xuyên giữa các task
- Áp dụng /compact để tóm tắt context dài
- Tách file lớn thành các file nhỏ có mục đích rõ ràng
- Chỉ định rõ file nào Claude nên đọc trong CLAUDE.md
Mọi người có thể đọc thêm nhiều [best practice](https://www.anthropic.com/engineering/claude-code-best-practices) ở đây nha !!!!

### 12. Tận dụng Git Worktree và ccmanager
Git Worktree cho phép ae làm việc trên nhiều branch của cùng một repository trong các thư mục khác nhau cùng lúc. Điều này cực kỳ hữu ích khi bạn phải xử lý nhiều task song song.

**Lợi ích khi kết hợp với Claude Code**
- Có thể chạy nhiều task song song (parallel tasks).
- Không bị mất ngữ cảnh khi chuyển branch, vì mỗi branch nằm ở một thư mục riêng.
- Mỗi worktree giữ được session độc lập, Claude Code không bị “lẫn” giữa các branch.
- Để quản lý worktree hiệu quả, có thể dùng các công cụ như ccmanager.
- 
```
# Install ccmanager (Node >= 18)
npm install -g ccmanager

# Alias
alias ccm='ccmanager'
```

Ví dụ file cấu hình ~/.config/ccmanager/config.json
```
{
  "shortcuts": {
    "returnToMenu": {
      "ctrl": true,
      "key": "e"
    },
    "cancel": {
      "key": "escape"
    }
  },
  "statusHooks": {},
  "worktree": {
    "autoDirectory": true,
    "autoDirectoryPattern": "../{branch}"
  },
  "command": {
    "command": "claude",
    "args": [
      "--resume"
    ]
  }
}
```

Command cho phép bạn chỉ định lệnh mặc định khi khởi chạy Claude Code trong worktree (ở đây là claude --resume).


Khi gõ ccmanager sẽ thấy giao diện menu tương tác như sau: 
![Screenshot from 2025-09-15 10-19-45.png](https://images.viblo.asia/a4371b88-170d-4c4e-8434-56f44b4c0a6d.png)

**Workflow hiệu quả được khuyến nghị bởi Anthropic**
1. Explore: Yêu cầu Claude đọc các file liên quan
2. Plan: Sử dụng "think hard" để kích hoạt extended thinking mode
3. Code: Triển khai solution với verification
4. Commit: Tạo commit và pull request


## Tổng kết:
Nhìn chung, AI Orchestration và các công cụ AI-driven development như Claude Code, Cursor, Copilot hay Vibe Kanban… không chỉ giúp lập trình viên “code nhanh hơn”, mà còn thay đổi hoàn toàn cách chúng ta tư duy và tổ chức công việc phát triển phần mềm.
Thay vì chỉ coi AI như một “code assistant” phụ trợ, giờ đây nó đã trở thành một đồng đội thực thụ: có thể đọc hiểu codebase, phân tích kiến trúc, tối ưu hệ thống, tự động kiểm thử và thậm chí hỗ trợ quản lý dự án.

AI không thay thế hoàn toàn developer, mà nó mở ra một “meta-skill” mới: khả năng điều phối, huấn luyện và tối ưu các coding agents. Đây chính là lợi thế cạnh tranh lớn trong kỷ nguyên mới.

Hy vọng những tips và công cụ mình chia sẻ sẽ giúp mọi người khai thác tối đa sức mạnh của Claude Code và AI Orchestration, biến chúng thành một phần tự nhiên trong quy trình phát triển hằng ngày. Nếu biết kết hợp đúng cách, bạn sẽ thấy hiệu suất làm việc tăng lên gấp nhiều lần, và quan trọng hơn: có thêm nhiều thời gian tập trung vào sáng tạo và giải quyết những vấn đề thực sự khó.

Còn nữa, mình sẽ update tiếp ở phần sau...