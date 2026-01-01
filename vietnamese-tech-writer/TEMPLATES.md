# Article Templates - Vietnamese Tech Writer

Các template cho các loại bài viết phổ biến theo style tự nhiên của architect viết blog.

---

## Template 1: Tutorial / How-To Guide

**Khi nào dùng:** Hướng dẫn cách làm một việc cụ thể từ A-Z

**Cấu trúc:**

```markdown
# [Tool/Technology]: Hướng dẫn [Action] từ A-Z

![Hero image - Tool logo or screenshot]

## Tản mạn / Mở đầu

[Đặt vấn đề bằng pain point thực tế]

Hôm nay chúng ta sẽ cùng nhau:
- [Outcome 1]
- [Outcome 2]
- [Outcome 3]

## Prerequisites / Chuẩn bị

Trước khi bắt đầu, bạn cần:
- [ ] [Requirement 1]
- [ ] [Requirement 2]
- [ ] [Kiến thức nền: Link bài viết liên quan]

## Bước 1: [Action đầu tiên]

[Ví von đời thường nếu concept phức tạp]

**Thực hiện:**

```[language]
# Code hoặc command
```

**Giải thích:**
- [Point 1]
- [Point 2]

![Screenshot hoặc diagram minh họa]

## Bước 2: [Action tiếp theo]

[Tương tự như bước 1...]

## Bước 3: ...

## Bài học kinh nghiệm

**Một số lưu ý từ kinh nghiệm:**

Mình cũng đã từng [làm dự án X], gặp vấn đề [Y]...
- **Lỗi thường gặp**: [Error message]
  - **Nguyên nhân**: ...
  - **Cách fix**: ...

## Kết luận

[Tóm tắt những gì đã học]

Hy vọng bài viết này đã giúp bạn [outcome chính].
Tiếp theo, bạn nên tìm hiểu thêm về **[related topic]** nhé!

**Nguồn:**
- [Official docs link]
- [Tutorial/blog link]

---
telegram: dinhlongit
```

**Ví dụ thực tế:**
- "Deploy ứng dụng Laravel lên EC2 bằng một cú Enter với Ansible"
- "AWS: Deploy Reactjs App Trên ECS Tích Hợp CI/CD"

---

## Template 2: Concept Explanation / Deep Dive

**Khi nào dùng:** Giải thích sâu về một concept, technology, hoặc pattern

**Cấu trúc:**

```markdown
# [Concept]: Hiểu từ gốc đến ngọn / Câu hỏi phỏng vấn quốc dân

![Concept diagram]

## Câu hỏi / Đặt vấn đề

Câu hỏi mà không riêng bản thân mình, đây chắc chắn là câu hỏi "quốc dân"
trong các buổi phỏng vấn kỹ thuật, vậy bạn đã thực sự hiểu về **[Concept]**
để giải thích cho mọi người một cách dễ hiểu dễ hình dung hơn chưa?

## [Concept] là gì?

### Ví von đời thường

[Analogy giúp hình dung concept]

Hãy tưởng tượng [Concept] giống như [real-world example]...

![Illustration của analogy]

### Định nghĩa kỹ thuật

> [Blockquote với định nghĩa chính xác]

[Giải thích chi tiết dựa trên analogy phía trên]

## Tại sao cần [Concept]?

### Vấn đề trước khi có [Concept]

[Mô tả problem mà concept này giải quyết]

```[language]
// Code example showing the problem
```

### Giải pháp với [Concept]

[Mô tả cách concept này giải quyết problem]

```[language]
// Code example showing the solution
```

![Before/After diagram]

## [Concept] hoạt động như thế nào?

### Thành phần / Components

**1. [Component 1]**
- [Mô tả]
- [Vai trò]

**2. [Component 2]**
...

### Workflow / Quy trình

**Bước 1:** [Action]
**Bước 2:** [Action]
...

![Workflow diagram]

## So sánh [Concept A] vs [Concept B]

| Tiêu chí | [Concept A] | [Concept B] |
|----------|-------------|-------------|
| [Criteria 1] | ... | ... |
| [Criteria 2] | ... | ... |

**Khi nào dùng [Concept A]:**
- [Use case 1]
- [Use case 2]

**Khi nào dùng [Concept B]:**
- [Use case 1]
- [Use case 2]

## Bài học kinh nghiệm

**BÀI HỌC KINH NGHIỆM:**

Mình cũng đã từng làm việc với [company/project],
đã gặp trường hợp [situation] và bùm...

[Chi tiết experience, lesson learned]

## Kết luận

Hy vọng bài viết này đã giúp bạn hiểu rõ **[Concept]**,
còn một khái niệm mà bạn cũng nên cần phải hiểu là **[Related Concept]**
nữa (nhớ tìm hiểu thêm nhé!)

**Nguồn:**
- [Official documentation]
- [Technical blog/video]

---
telegram: dinhlongit
```

**Ví dụ thực tế:**
- "Process vs Thread: Câu hỏi phỏng vấn quốc dân"
- "Claude Agent Skills — Hiểu từ gốc đến ngọn"
- "Webhook và những điều cần biết"

---

## Template 3: Listicle / Top N Tools

**Khi nào dùng:** Tổng hợp danh sách tools, tips, best practices

**Cấu trúc:**

```markdown
# [Number] [Category] Tuyệt Vời [Time Period/Context]

![Hero image with tools logos]

## Mở đầu

[Hook: Tại sao cần những tools/tips này]

Mình đã research và thử nghiệm rất nhiều [category],
hôm nay muốn chia sẻ với mọi người **[number] [items]**
mà mình thấy thực sự hữu ích...

## 1. [Tool/Tip Name]

![Tool screenshot or logo]

**Mô tả:**
[Giải thích ngắn gọn tool này làm gì]

**Tại sao nên dùng:**
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]

**Use case thực tế:**
[Example cụ thể về cách dùng]

```[language]
# Code example nếu cần
```

**Giá:** Free / $XX/month
**Link:** [Official website]

---

## 2. [Tool/Tip Name]

[Tương tự như item 1...]

---

## 3-N. [Remaining items...]

## So sánh nhanh

| Tool | Best For | Price | Difficulty |
|------|----------|-------|------------|
| [Tool 1] | [Use case] | $ | Medium |
| [Tool 2] | [Use case] | Free | Easy |
| ... | ... | ... | ... |

## Kinh nghiệm sử dụng

**Từ kinh nghiệm cá nhân:**

Trong các dự án mình đã làm:
- **[Project 1]**: Dùng [Tool X] cho [purpose], kết quả [outcome]
- **[Project 2]**: Thử [Tool Y] nhưng [issue], chuyển sang [Tool Z]

**Tips khi chọn tool:**
1. [Tip 1]
2. [Tip 2]

## Kết luận

[Number] công cụ trên đều là những lựa chọn tuyệt vời cho [use case].
Tùy vào nhu cầu và budget, bạn có thể chọn:
- **Budget nhỏ**: [Tool recommendations]
- **Enterprise**: [Tool recommendations]
- **Beginner-friendly**: [Tool recommendations]

**Nguồn:**
- [Source 1]
- [Source 2]

---
telegram: dinhlongit
```

**Ví dụ thực tế:**
- "10 Công Cụ Tuyệt Vời Năm 2025"
- "5 Best Practices Khi Làm Việc Với Docker"

---

## Template 4: Troubleshooting / Debugging Guide

**Khi nào dùng:** Hướng dẫn fix lỗi hoặc debug một vấn đề cụ thể

**Cấu trúc:**

```markdown
# [Error/Problem]: Nguyên nhân và cách khắc phục

![Error screenshot]

## Tình huống

[Mô tả khi nào lỗi này xuất hiện]

Chắc mọi người ai đã từng [làm task X] thì đều gặp lỗi này ít nhất một lần...

**Error message:**
```
[Full error message/stack trace]
```

## Hiểu về lỗi

### Lỗi này xuất hiện khi nào?

- [Scenario 1]
- [Scenario 2]
- [Scenario 3]

### Nguyên nhân gốc rễ

[Giải thích tại sao lỗi này lại xảy ra]

[Ví von đời thường nếu concept phức tạp]

![Diagram minh họa nguyên nhân]

## Các cách khắc phục

### Cách 1: [Quick fix] (Khuyên dùng)

**Khi nào dùng:** [Conditions]

**Các bước:**

1. [Step 1]
```[language]
# Code
```

2. [Step 2]
...

**Kết quả mong đợi:**
```
[Output khi thành công]
```

### Cách 2: [Alternative approach]

[Tương tự cách 1...]

### Cách 3: [Last resort]

**Chú ý:** Cách này chỉ nên dùng khi...

## Kinh nghiệm debug

**BÀI HỌC KINH NGHIỆM:**

Mình từng gặp lỗi này ở [project/company], mất [time] để debug
vì [reason]. Sau đó phát hiện ra...

**Tips debug nhanh:**
1. [Tip 1]
2. [Tip 2]
3. [Tip 3]

## Phòng tránh lỗi này

Để tránh gặp lỗi này trong tương lai:

- [ ] [Prevention 1]
- [ ] [Prevention 2]
- [ ] [Prevention 3]

**Code snippet để phòng tránh:**
```[language]
// Best practice code
```

## Kết luận

Hy vọng bài viết này đã giúp bạn giải quyết lỗi **[Error]**.
Nếu vẫn gặp vấn đề, hãy check thêm [related topic] nhé!

**Nguồn:**
- [Official docs về error này]
- [GitHub issue discussions]
- [Stack Overflow answers]

---
telegram: dinhlongit
```

**Ví dụ thực tế:**
- "Khi PHP Gặp Gỡ Thách Thức Tính Toán Tiền Tệ: Tại Sao 0.1 + 0.2 ≠ 0.3"

---

## Template 5: Case Study / Project Breakdown

**Khi nào dùng:** Chia sẻ chi tiết về một project/case study thực tế

**Cấu trúc:**

```markdown
# [Project Name]: [Main Achievement/Learning]

![Project screenshot/architecture]

## Background / Bối cảnh dự án

**Project:** [Tên dự án]
**Company/Team:** [Nếu được phép share]
**Timeline:** [Duration]
**Tech Stack:** [Technologies used]

**Vấn đề cần giải quyết:**
[Mô tả business problem hoặc technical challenge]

## Yêu cầu / Requirements

**Functional Requirements:**
- [Requirement 1]
- [Requirement 2]

**Non-Functional Requirements:**
- Performance: [Metrics]
- Scalability: [Requirements]
- Security: [Requirements]

## Kiến trúc / Architecture

### High-level Overview

[Mô tả overall architecture]

![Architecture diagram]

### Tech Stack Chi Tiết

**Frontend:**
- [Tech 1]: [Why we chose it]
- [Tech 2]: [Why we chose it]

**Backend:**
- [Tech 1]: [Why we chose it]

**Infrastructure:**
- [Platform]: [Why we chose it]

### Design Decisions

**Tại sao chọn [Technology X] thay vì [Technology Y]?**

[Giải thích trade-offs, reasoning]

## Implementation / Triển khai

### Phase 1: [First milestone]

[Chi tiết implementation]

```[language]
// Key code snippet
```

**Challenges faced:**
- [Challenge 1]: [How we solved it]
- [Challenge 2]: [How we solved it]

### Phase 2-N: [Other phases...]

## Kết quả / Results

**Metrics:**
- [Metric 1]: [Before] → [After]
- [Metric 2]: [Before] → [After]
- [Metric 3]: [Before] → [After]

**Business Impact:**
- [Impact 1]
- [Impact 2]

## Bài học kinh nghiệm

**BÀI HỌC KINH NGHIỆM:**

**What went well:**
- [Success 1]
- [Success 2]

**What could be improved:**
- [Lesson 1]
- [Lesson 2]

**If I were to do it again:**
- [Change 1]
- [Change 2]

## Key Takeaways

Nếu bạn đang làm project tương tự, hãy nhớ:

1. **[Takeaway 1]**: [Explanation]
2. **[Takeaway 2]**: [Explanation]
3. **[Takeaway 3]**: [Explanation]

## Kết luận

[Tóm tắt project và main lessons]

**Nguồn:**
- [GitHub repo nếu open source]
- [Blog posts liên quan]
- [Documentation]

---
telegram: dinhlongit
```

**Ví dụ thực tế:**
- "Làm Thế Nào Crawl 1 Triệu Comments Trên Facebook"
- "[BOT]AWS Lambda: Sử dụng Selenium trên Lambda Function để theo dõi giá Shopee"

---

## Chọn Template Nào?

| Loại bài viết | Template | Ví dụ |
|---------------|----------|-------|
| Hướng dẫn từng bước | Tutorial | "Deploy Laravel với Ansible" |
| Giải thích concept | Concept Explanation | "Process vs Thread" |
| Review/recommend tools | Listicle | "10 Công Cụ 2025" |
| Fix lỗi cụ thể | Troubleshooting | "0.1 + 0.2 ≠ 0.3" |
| Chia sẻ dự án | Case Study | "Crawl 1M Comments" |

---

## Tips Chung Cho Mọi Template

1. **Luôn có ví von đời thường** trước khi dive vào technical
2. **Hình ảnh là bắt buộc** - minimum 3 hình/bài
3. **Code phải runnable** hoặc có disclaimer rõ ràng
4. **Section "Kinh nghiệm"** là signature - đừng bỏ qua
5. **Nguồn tham khảo** phải có và uy tín
6. **SEO-friendly** - H1 có keyword, heading structure rõ ràng
7. **Tone tự nhiên** - như đang chat với đồng nghiệp

---

Các template này linh hoạt, có thể mix-match tùy nội dung.
Quan trọng là giữ được **style tự nhiên của architect** đặc trưng!
