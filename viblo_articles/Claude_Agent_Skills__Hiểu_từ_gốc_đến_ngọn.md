# Claude Agent Skills — Hiểu từ gốc đến ngọn

![image.png](https://images.viblo.asia/dbbcc583-118e-46e2-bb1b-c75b4a6a133e.png)

# Tản mạn:
![image.png](https://images.viblo.asia/0ea2109a-48d3-4218-b8b0-1bed94e42dc7.png)

Có những hôm đang code ngon lành, tự nhiên gặp một yêu cầu… “viết email nội bộ chuẩn format công ty”, “tạo skill mới để parse PDF”, “audit codebase rồi sinh report”…

Anh em dev bình thường sẽ thở dài:
“**Làm gì mà phải lặp lại quy trình y chang nhau hoài vậy trời?**”

Nhưng kể từ khi Claude tung ra thứ gọi là Agent Skills, cuộc đời nhẹ nhàng hơn rất nhiều. Nó không phải API, không phải function calling, không phải script backend… mà là một kiểu mở rộng não LLM rất tinh tế, rất “Anthropic style”:

**Biến hiểu biết của con người thành bối cảnh – rồi tiêm vào não model đúng lúc cần.**

Bài này mình sẽ đi sâu từ first principles, đọc xong, hi vọng mọi người sẽ hiểu:

 **1. Agent Skills là gì?**

 **2. Nó vận hành như thế nào trong nội bộ Claude?**

 **3. Tại sao nó KHÔNG phải tool, KHÔNG phải code?**

 **4. Tại sao toàn bộ việc chọn skill lại dựa vào reasoning của model?**

### Và vì sao đây là một hướng RẤT hay → phù hợp với tư duy “compound AI systems”.

# 1. Ý tưởng ban đầu — Khi prompt không còn đủ “dài hơi”
Thao tác với AI nhiều, anh em biết rồi:
Cứ gặp task hơi phức tạp, muốn guide để có output tốt là mình phải đưa một cái prompt dài ngoằng, nào là:
- mô tả role
- mô tả workflow
- quy tắc
- format output
- boundary case
- các bước cần hỏi lại

Mệt, rất mệt 😆

Và tệ nhất là Claude không nhớ mãi, chuyển sang request khác là mất role

**Agent Skills xuất hiện để giải quyết đúng điểm đau này:
Một cơ chế “đóng gói vai trò + workflow + tool permission” vào 1 package có thể kích hoạt on-demand.**

Không cần viết code.
Không cần backend.
Không cần API definition.

Chỉ bằng prompt.


# 2. Skill ≠ Tool
### Skill = Instruction Injection
### Tool = Execution

Đây là điểm quan trọng nhất.

**Tools là gì?**

Tools là code có thể chạy:
- Read file
- Write file
- Bash
- Python script

Nó chạy → trả kết quả → xong.

**Còn Skills?**

Skills không chạy gì.

Skills chỉ tiêm prompt vào conversation context và thay đổi execution permissions.
- Nó như một “gói não mở rộng”:
- hướng dẫn Claude cách suy nghĩ
- bật một chế độ chuyên gia
- định nghĩa những quy tắc workflow
- pre-approve tool cho task này
- (nếu cần) đổi model luôn

Rồi Claude mới sử dụng tool để thực thi.
Nói kiểu cho dễ nhớ:

“**Skills là thứ làm Claude thông minh hơn. Tools là thứ Claude dùng để hành động.”**

# 3. Kiến trúc thật sự bên trong: Meta-Tool
Claude có một tool đặc biệt tên là **Skill**

Đây không phải skill cụ thể, mà là **meta-tool quản lý toàn bộ skill.**

Khi Claude nhận input từ user, API gửi luôn:
- danh sách tools truyền thống
- danh sách tất cả skill dưới dạng text description
- Skill meta-tool để invoke

**Điều đáng chú ý:**

Skill descriptions không chèn vào system prompt. Tất cả nằm trong tools[].

Khi Claude cần chọn skill, nó sẽ đọc text dạng:
```
"pdf": Extract text from PDF documents...
"internal-comms": Write internal announcements...
"skill-creator": Guide to create skills...
```

**Không embedding.**

**Không matching.**

**Không thuật toán.**

Chỉ đơn thuần… model reasoning.
Đây là triết lý “**LLM reasoning > algorithmic orchestration**”.


# 4. Quy trình 3 phase — hiểu để vận dụng như build agent thật
![mermaid-diagram-2025-11-24T15-06-30.png](https://images.viblo.asia/bb018906-c8d1-46b4-a551-cd928c6175ce.png)


### Phase 1 — Discovery
Claude nhìn vào các skill description.
Match bằng… hiểu ngôn ngữ tự nhiên.

Nếu thấy description giống yêu cầu → nó invoke skill.

Ví dụ:
```
tool_use: {
  name: "Skill",
  input: { "command": "skill-creator" }
}
```

Cực kỳ elegant.

### Phase 2 — Context Injection

Khi Skill Tool chạy, nó không chạy code thuật toán.
Nó inject 2 message:

**1) Message visible (cho người dùng)**

```
<command-message>The "pdf" skill is loading</command-message>
<command-name>pdf</command-name>
```

**2) Message hidden (cho model)**
Một prompt 500–5000 chữ từ SKILL.md:
 - định nghĩa role
 - chi tiết workflow
 - step-by-step
 - tool allowed
- model override
- examples
- error handling

Claude nhận prompt, nhưng người dùng không thấy.
**→ Đây là bí quyết khiến Claude “trở thành expert tạm thời”.**


**Đồng thời:**
- Allowed-tools được override
- Model override nếu cần
- BaseDir để đọc files trong /scripts, /assets, /references

### Phase 3 — Execution
Khi đã nhận skill prompt + execution context mới:

Claude → làm theo workflow đã được đóng gói.

Ví dụ PDF skill:
- dùng Bash(pdftotext)
- đọc file
- parse nội dung
- trình bày kết quả

**Skill không làm - Skill chỉ hướng dẫn - Claude mới là người thực thi.**

# 5. SKILL.md – “Trái tim” của Agent Skills# 
![image.png](https://images.viblo.asia/99b2e42b-e45d-4789-9478-df0eaff35780.png)

**Cấu trúc chuẩn của 1 skill:**
```
my-skill/
 ├─ SKILL.md
 ├─ scripts/
 ├─ references/
 └─ assets/
```


### SKILL.md có 2 phần:

**1. YAML frontmatter**

Quy định:
- name
- description
- allowed-tools
- model
- version
- disable-model-invocation
- mode

Đây là meta-information để Skill Tool biết cách xử lý skill.

**2. Markdown content**

Đây là instruction template để tiêm vào Claude:
- Purpose
- Overview
- Step-by-step
- Output format
- Error handling
- Examples
- References
- Hướng dẫn dùng scripts

**Claude sẽ đọc trọn bộ này mỗi lần skill bật.**

# 6. Cách Claude gọi tool sau khi có skill
Một skill như pdf không làm gì trực tiếp.
Nó chỉ hướng Claude cách nghĩ như:

1. Kiểm tra PDF có tồn tại
2. Run pdftotext
3. Read output
4. Trích nội dung
5. Format cực sạch

Lúc đó Claude sẽ tự dùng:

```
tool_use: Bash(pdftotext ...)
```

Rồi tiếp tục:

```
tool_use: Read(...)
```

→ Đây chính là **agent workflow.**

# 7. Skills vs Tools — Tư duy hệ thống
### Tools
- chạy code
- cho kết quả ngay
- deterministic
- đơn nhiệm

### Skills
- biến đổi não LLM
- guiding workflow
- không chạy code
- không trả về kết quả
- overhead tokens lớn
- không concurrency-safe (Claude reasoning only)
- CLAUDE trở thành agent thông minh nhờ:

**Skills mở rộng não → Tools thực thi → Model reasoning điều phối**


# 8. Tại sao kiến trúc này đáng được khen?
- Không bloat system prompt
- Không ghép skill vào system context cố định
- Không ép LLM phải ghi nhớ dài hạn
- Skills là “tạm thời” → cực linh hoạt
- Có thể tạo skill mới, chia sẻ, đóng gói
- Không đòi backend
- Không đòi DNS, server, API
- Một hệ thống agent “no-code” đúng nghĩa.
- Nếu GPT Actions là “API-based agent”, thì Claude Skills là “prompt-based meta-agent”.


# 9. Tại sao dev như anh mình cần quan tâm?
Bởi vì Agent Skills chính là key để:

- xây compound system
- build assistant cho doanh nghiệp
- đóng gói domain knowledge của team
- giảm lặp lại
- chuẩn hoá workflow
- tạo “specialized mode” nhanh như bấm nút

Nó giống như:

### Tạo một “cơ quan chức năng trong não Claude”.
### Muốn bật bộ phận nào → dùng skill đó.

- Không phải hướng dẫn lại từ đầu.
- Không phải copy/paste prompt cũ.
- Không lo quên role.
- Không lệ thuộc vào session.

# Kết luận:
Claude Agent Skills thực chất không phải framework, không phải argument system, mà là:

**Một cơ chế meta-programming bằng prompt.
Nó tiêm workflow của con người vào não LLM, tạm thời, có ranh giới, có permission, có toolset.
Claude reasoning sẽ lo phần còn lại.**

**Thiết kế này:**
- đẹp
- tinh tế
- dễ mở rộng
- phù hợp enterprise
- phù hợp engineer thích build hệ thống

Nếu GPT Agents đang thiên về “function calling”,
thì Claude Skills thiên về “context specialization”.