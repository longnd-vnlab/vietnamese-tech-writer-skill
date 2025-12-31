# Claude Code Chrome Extension: Khi Automated Testing Không Còn Là "Ảo Ma"

## Tổng quan

Có những hôm đang test app, tự nhiên gặp một yêu cầu: "kiểm tra visual regression toàn bộ landing page", "verify user flow từ đầu đến cuối", "debug cái lỗi JavaScript này xem nó fail ở đâu"...

Anh em dev bình thường sẽ thở dài:

"**Lại phải mở browser, click từng cái, screenshot từng màn hình, rồi so sánh thủ công à?**"

Thực ra với Playwright MCP hay Puppeteer MCP, chúng ta đã có thể để AI làm automated testing rồi. Nhưng thật sự mà nói, những tool này có **rất nhiều vấn đề** khiến mình không bao giờ là fan cuồng của automated testing bằng AI:

- Context window bị bloat một cách vô lý
- Project folder ngập trong screenshots random
- Phần lớn thời gian nó không complete được actions

Đây là lý do tại sao mình rất excited khi **Claude Code Chrome Extension** chính thức ra mắt vào tháng 12/2025.

## Vấn đề lớn nhất của Playwright/Puppeteer MCP

![Playwright MCP Issues](https://images.viblo.asia/placeholder-playwright-issues.png)
*Hình: Các vấn đề phổ biến khi sử dụng Playwright MCP - connection failures, context bloat*

Trước khi nói về Chrome Extension, mình phải nói về cái đau đầu khi dùng Playwright MCP.

### 1. Connection và Initialization Issues

Theo [GitHub Issues của Claude Code](https://github.com/anthropics/claude-code/issues/1383), Playwright MCP **thất bại liên tục** khi khởi tạo:

- Server shows "Failed to connect" ngay từ đầu
- Phải restart nhiều lần mới nhận tools
- Version mismatch giữa MCP server và dependencies
- Cần sudo privileges để install browser (Claude không tự làm được)

### 2. Context Window Bloat

![Context Window Token Bloat](https://images.viblo.asia/placeholder-context-bloat.png)
*Hình: Context window bị chiếm dụng bởi screenshots và HTML - visualization về token usage*

Đây là vấn đề **nghiêm trọng nhất** mà mình gặp.

Khi test một landing page đơn giản, Playwright MCP sẽ:
- Scroll từng section một
- Capture screenshot mỗi section
- Load toàn bộ HTML của main tag (hàng ngàn dòng code)
- Stitch screenshots lại để analyze

Kết quả? **Context window nhanh chóng bị đầy**, và mỗi task đơn giản cũng tốn hàng chục nghìn tokens.

### 3. Project Folder Clutter

Screenshots được lưu khắp nơi trong project của bạn. Không có cơ chế cleanup, không có organization. Sau một tuần test, folder của bạn sẽ có hàng trăm file `screenshot_1.png`, `screenshot_2.png`...

### 4. Inconsistent Success Rate

[Theo kinh nghiệm từ cộng đồng](https://til.simonwillison.net/claude-code/playwright-mcp-claude-code):

> "Playwright MCP success is inconsistent - sometimes it works great with screenshots and verification, but other times it can't use Playwright properly and reverts to Curl."

Nghĩa là nhiều khi Claude không dùng Playwright mà fallback về curl hoặc bash commands, làm mất đi ý nghĩa của automation.

## Claude Chrome Extension: Native Solution từ Anthropic

![Claude Chrome Extension Architecture](https://images.viblo.asia/placeholder-chrome-extension.png)
*Hình: Kiến trúc của Claude Chrome Extension - Native Messaging API kết nối Claude Code với Chrome*

[Claude in Chrome](https://code.claude.com/docs/en/chrome) được mở rộng cho tất cả paid plans vào ngày 18/12/2025, và nó giải quyết gần như toàn bộ vấn đề của Playwright MCP.

### Điểm khác biệt lớn nhất

**Playwright/Puppeteer MCP:**
- Chạy trong isolated environment
- Không có session persistence
- Phải install và configure riêng
- Screenshots clutter project folder

**Claude Chrome Extension:**
- Native integration với Chrome thật
- Giữ được session và signed-in accounts
- Có thể interact với Google Docs, Sheets, v.v.
- Không tạo file rác trong project

**Native Messaging API** cho phép Claude Code gửi commands trực tiếp đến Chrome, đọc console output, network requests, và DOM state **real-time**.

## Vấn đề thực tế và cách fix

Dù Chrome Extension tốt hơn nhiều, nhưng nó vẫn có một số vấn đề cần giải quyết.

### Vấn đề 1: Sequential Screenshots Bloat Context

**Hiện tượng:**

Khi bạn bảo Claude test landing page, nó sẽ:
1. Scroll đến section đầu → screenshot
2. Scroll đến section 2 → screenshot
3. Scroll đến section 3 → screenshot
4. ...
5. Stitch tất cả lại để analyze

Cách này **lãng phí tokens** và **chậm**.

**Giải pháp:**

Tạo script để chụp **full page screenshot** một lần:

```bash
# fullpage-screenshot.sh
#!/bin/bash
url="$1"
output="${2:-fullpage.png}"

node -e "
const puppeteer = require('puppeteer');
(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('$url', {waitUntil: 'networkidle2'});
  await page.screenshot({path: '$output', fullPage: true});
  await browser.close();
})();
"
```

Sau đó thêm instructions trong `.claude/commands/test-landing.md`:

```markdown
---
description: Test landing page with full screenshot
---

When testing landing pages:
1. Use the fullpage-screenshot.sh script to capture full page
2. Do NOT scroll section by section
3. Analyze the single full screenshot instead of stitching multiple screenshots

Example:
bash fullpage-screenshot.sh https://example.com landing-test.png
```

**Kết quả:** Test nhanh hơn nhiều, tiết kiệm context, accuracy vẫn giữ nguyên.

![Full Page vs Section Screenshot](https://images.viblo.asia/placeholder-screenshot-comparison.png)
*Hình: So sánh full page screenshot (1 lần) vs section-by-section screenshot (nhiều lần)*

### Vấn đề 2: Loading Toàn Bộ HTML → Context Explosion

**Hiện tượng:**

MCP tools thường load **toàn bộ HTML trong main tag** thay vì chỉ load specific divs. Một trang đơn giản cũng có thể có hàng nghìn dòng HTML.

**Giải pháp:**

Thêm instructions trong `claude.md`:

```markdown
# Browser Context Management

When using Claude Chrome extension:

1. **Extract Only Necessary Content**
   - Do NOT load all HTML from `<main>`
   - Target specific divs/sections with selectors
   - Use `document.querySelector()` to limit scope

2. **Example:**
   ```javascript
   // BAD - loads everything
   document.querySelector('main').innerHTML

   // GOOD - loads only what's needed
   document.querySelector('#checkout-form').innerHTML
   ```

3. **Limit Context:**
   - Only extract text content when possible
   - Avoid loading inline styles and scripts
   - Use `textContent` instead of `innerHTML` when appropriate
```

**Kết quả:** Context window usage giảm đáng kể, tasks đơn giản không còn bị bloat.

### Vấn đề 3: Cookie Banners và Popups Waste Time

**Hiện tượng:**

Claude lãng phí thời gian để dismiss cookie banners bằng cách:
- Screenshot → phát hiện popup
- Scroll để tìm nút Accept
- Screenshot lại → click

**Giải pháp:**

Tạo script tự động dismiss cookie banners:

```javascript
// dismiss-cookies.js
// Common cookie banner selectors
const cookieSelectors = [
  'button[id*="accept"]',
  'button[class*="accept"]',
  'button[id*="cookie"]',
  'a[class*="accept"]',
  '#onetrust-accept-btn-handler',
  '.cookie-banner button',
  '[data-testid="cookie-banner-accept"]'
];

function dismissCookieBanners() {
  cookieSelectors.forEach(selector => {
    const button = document.querySelector(selector);
    if (button) {
      button.click();
      console.log(`Dismissed cookie banner: ${selector}`);
    }
  });
}

dismissCookieBanners();
```

Thêm vào `claude.md`:

```markdown
# Auto-dismiss Cookie Banners

Before interacting with any website:
1. Execute dismiss-cookies.js script first
2. Wait 1 second for banners to close
3. Then proceed with main task

This saves tokens and time by avoiding unnecessary screenshot/scroll sequences.
```

**Kết quả:** Không còn lãng phí tokens cho popups, workflow mượt mà hơn.

### Vấn đề 4: Authentication Limitations

**Lưu ý quan trọng:**

Vì lý do bảo mật, Claude **không thể** tự động login hoặc complete CAPTCHA cho bạn.

**Giải pháp:**

- Login manually trước khi bắt đầu test
- Sử dụng Chrome profile đã authenticated
- Claude sẽ giữ session và cookies

```markdown
# Authentication Requirements

For websites requiring login:
1. User must authenticate manually FIRST
2. Claude will use existing session/cookies
3. Do NOT attempt to automate login or CAPTCHA

If authentication is expired, ask user to re-authenticate before proceeding.
```

## Tại sao Chrome Extension tốt hơn Puppeteer MCP?

![Comparison Table](https://images.viblo.asia/placeholder-comparison.png)
*Hình: So sánh giữa Playwright MCP và Claude Chrome Extension*

### 1. Native Tool từ Anthropic

Chrome Extension được build bởi chính **team phát triển Claude Code**, nên integration tốt hơn nhiều so với third-party MCP.

### 2. Real Browser Environment

Puppeteer/Playwright chạy trong **isolated headless environment**:
- Không có session persistence
- Phải setup lại mỗi lần
- Không interact được với logged-in services

Claude Chrome Extension:
- Dùng Chrome thật của bạn
- Giữ toàn bộ sessions
- Có thể làm việc với Google Docs, Sheets, Notion, v.v.

### 3. No Project Clutter

Playwright MCP lưu screenshots vào project folder → mess.

Chrome Extension không tạo file rác, tất cả diễn ra trong browser memory.

### 4. Better Context Efficiency

[Theo Anthropic](https://claude.com/blog/claude-for-chrome):

> "Browser integrations do use a lot of context because they're more compute intensive than regular tool calls."

Nhưng với optimization (như full-page screenshot, targeted DOM extraction), Chrome Extension vẫn efficient hơn MCP nhiều.

## Vấn đề của Chrome Manifest V3: Extension Timeout

![Service Worker Lifecycle](https://images.viblo.asia/placeholder-service-worker.png)
*Hình: Chrome Extension Service Worker Lifecycle - 30s continuous execution, 5 min async work limit*

Đây là limitation **không thể tránh** của Chrome extensions.

### Service Worker Lifetime Limits

[Theo Chrome documentation](https://developer.chrome.com/docs/extensions/develop/concepts/service-workers/lifecycle):

> Service workers are terminated after **30 seconds of continuous execution** or **5 minutes of asynchronous work**.

### Tác động đến Testing

Nếu bạn chạy **end-to-end test** dài từ đầu đến cuối app:
- Session có thể bị Chrome terminate giữa chừng
- Claude sẽ stop unexpectedly
- Phải re-prompt để restart

Nhiều người đang [yêu cầu Anthropic fix issue này](https://bugs.chromium.org/p/chromium/issues/detail?id=1152255).

### Workaround: Test Files Thay Vì End-to-End

Thay vì chạy một test dài, chia nhỏ thành **multiple test files**:

```
tests/
├── auth-flow-test.md
├── checkout-flow-test.md
├── profile-edit-test.md
├── search-functionality-test.md
└── testing-guide.md
```

Mỗi file chứa:
- **Priority levels**: Critical, High, Medium, Low
- **Preconditions**: User must be logged in, database seeded, etc.
- **Test steps**: Step-by-step actions
- **Expected results**: What should happen

Thêm instruction trong `claude.md`:

```markdown
# Testing Workflow

After completing each test file:
1. Create a comprehensive test report document
2. Mark what has been tested
3. Note any failures or issues found
4. This ensures progress is not lost even after context compaction

Before starting any test:
1. Check current context usage
2. Run /compact if needed
3. This prevents mid-test context loss
```

## Workflow Testing Hiệu Quả

![Testing Workflow Diagram](https://images.viblo.asia/placeholder-workflow.png)
*Hình: Workflow testing với Claude Chrome Extension - từ test file đến test report*

Mình tạo một custom command để streamline toàn bộ quy trình:

`.claude/commands/guided-test.md`:

```markdown
---
description: Run guided testing with documentation
allowed-tools: Bash(*), Read(*), Write(test-reports/*)
---

# Guided Testing Command

When user runs `/guided-test <test-file>`:

1. **Check Context First**
   - Monitor context window usage
   - If > 80%, suggest running /compact

2. **Read Test File**
   - Load the specified test file
   - Parse preconditions, steps, expected results

3. **Execute Test**
   - Use Chrome extension to perform actions
   - Monitor console logs for errors
   - Verify expected results

4. **Document Results**
   - Create test report in test-reports/ folder
   - Include:
     - Test file name and timestamp
     - Pass/Fail status for each step
     - Screenshots of failures
     - Console errors found
     - Recommendations

5. **Summary**
   - Report overall test status
   - Suggest next test to run
```

### Cách dùng:

```bash
/guided-test tests/checkout-flow-test.md
```

Claude sẽ:
1. Check context window
2. Read test file
3. Execute từng bước tự động
4. Monitor console logs
5. Detect errors (kể cả errors không visible)
6. Generate test report

**Ưu điểm:**
- Tự động hóa toàn bộ
- Có documentation sau mỗi test
- Không mất progress khi context compact
- Detect được errors từ console logs

## BÀI HỌC KINH NGHIỆM

Mình đã thử automated testing với cả Playwright MCP và Chrome Extension trong dự án thực tế.

**Với Playwright MCP:**
- Setup mất nửa ngày vì dependency issues
- Context window bloat nhanh chóng
- Phải cleanup screenshots thủ công
- Success rate không ổn định

**Với Chrome Extension:**
- Setup 10 phút là xong
- Context efficient hơn nhiều (sau khi optimize)
- Không có file rác
- Reliable hơn vì native integration

**Lesson lớn nhất:**

> Testing automation không phải là "chạy một cái script dài". Đó là chia nhỏ thành từng test case, document kỹ lưỡng, và có strategy để handle context limits.

Và quan trọng nhất: **Claude có thể đọc console logs**. Điều này giúp detect những lỗi mà visual testing không bao giờ catch được:
- JavaScript errors
- Network failures
- Performance warnings
- Memory leaks

## Một số tips bổ sung

### 1. Luôn run /compact trước khi test

```bash
/compact
/guided-test tests/auth-flow-test.md
```

### 2. Monitor context trong quá trình test

Thêm vào test workflow:

```markdown
Before each major test step:
- Check context usage
- If > 90%, pause and compact
- Resume testing after compaction
```

### 3. Chỉ test trên Chrome, không phải Chromium

Chrome Extension **chỉ hoạt động với Chrome**, không work với:
- Brave
- Edge
- Chromium
- Other Chromium-based browsers

### 4. Multiple Chrome Profiles Issue

Nếu bạn dùng nhiều Chrome profiles, extension có thể **mở wrong profile**.

Workaround:
- Đặt default profile cho testing
- Hoặc specify profile path trong script

## So sánh tổng quan

| Feature | Playwright MCP | Chrome Extension |
|---------|----------------|------------------|
| Setup complexity | Cao (dependency issues) | Thấp (1-click install) |
| Context efficiency | Kém (screenshots + HTML bloat) | Tốt (sau optimization) |
| Session persistence | Không | Có |
| Project clutter | Screenshots everywhere | Clean |
| Success rate | Inconsistent | Reliable |
| Console access | Không | Có |
| Logged-in services | Không | Có |
| Timeout issues | Không | Có (Manifest v3) |

## Kết luận

Claude Code Chrome Extension đã thay đổi hoàn toàn cách mình làm automated testing.

**Trước đây:**
- Testing bằng AI = đau đầu với Playwright MCP
- Context bloat liên tục
- Success rate thấp
- Không tin tưởng results

**Bây giờ:**
- Native Chrome integration
- Workflow được optimize kỹ
- Test files có structure rõ ràng
- Console logs access → detect deep bugs
- Documentation tự động

**Điều quan trọng nhất:** Automated testing với AI không phải là magic bullet. Bạn vẫn cần:
- Hiểu cách optimize context
- Chia nhỏ test cases
- Document workflow
- Handle edge cases (timeouts, authentication)

Nhưng với những optimization mình share ở trên, Chrome Extension đã trở thành một công cụ **thực sự hữu ích** thay vì chỉ là "cool demo".

Hy vọng bài viết này giúp mọi người tận dụng tốt Claude Chrome Extension cho testing workflow. Còn nhiều tricks khác mình sẽ update thêm sau khi explore sâu hơn!

---

**Nguồn:**
- [Claude in Chrome Documentation](https://code.claude.com/docs/en/chrome)
- [Playwright MCP Issues on GitHub](https://github.com/anthropics/claude-code/issues/1383)
- [Chrome Manifest v3 Service Worker Lifecycle](https://developer.chrome.com/docs/extensions/develop/concepts/service-workers/lifecycle)
- [Simon Willison's TIL on Playwright MCP](https://til.simonwillison.net/claude-code/playwright-mcp-claude-code)

telegram: dinhlongit
