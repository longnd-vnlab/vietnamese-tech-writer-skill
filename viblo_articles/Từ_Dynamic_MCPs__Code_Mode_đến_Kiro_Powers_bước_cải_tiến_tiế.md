# Từ Dynamic MCPs & Code Mode đến Kiro Powers: bước cải tiến tiếp theo của AI Agent

# Góc hype:
Mình đã thử **Design to code with figma của Kiro powers**, một power chuyên để chuyển Figma design to code và output thật sự khá ấn tượng, matching >= 99.99% nhìn bằng mắt thường :v 

Mọi người có thể kiểm chứng:

**Design:** https://www.figma.com/design/QGe7OfHvzG8Pj7Ts8Yszd7/Untitled?node-id=0-1&t=LbaYUmQSLUlsJb8C-1

**Design to code:** https://landing-page-demo-1765869696.netlify.app/ 

![Screenshot from 2025-12-16 00-07-41.png](https://images.viblo.asia/859b2bea-6b84-453d-bc7a-69ac48f0e31f.png)

# Tổng quan
Ở bài trước, mình đã chia sẻ khá chi tiết về Dynamic MCPs và Code Mode và cũng có 1 bài viết về Agent Skills – cách giúp AI Agent thoát khỏi cảnh token bloat, context overload và chi phí tăng theo cấp số nhân. Nếu tóm gọn lại bằng một câu thì là:

> Chúng ta đã dùng MCP sai cách. LLM giỏi viết code để gọi tool hơn là bị nhồi hàng trăm tool vào context.

Sau khi vọc vạch thêm **Kiro Powers**, mình nhận ra: **Dynamic MCPs + Code Mode** chưa phải điểm kết thúc. Nó mới giải quyết cách agent gọi tool hiệu quả hơn, nhưng vẫn còn một bài toán lớn hơn:

> Làm sao để agent có sẵn framework expertise (Stripe, Supabase, Figma, Netlify, CDK AWS…) mà không phải nạp toàn bộ context ngay từ đầu?

Câu trả lời chính là Kiro Powers.

**Nhắc lại nhanh bài toán cũ**
Anh em nào build AI Agent thực tế chắc đều đã gặp:
- Agent kết nối 10–20 MCP server
- Mỗi MCP có hàng chục tool
- Toàn bộ tool definitions + schema JSON bị nhét vào context ngay khi start

Mọi người có thể thấy:
- Context window bị chiếm sạch
- Token tăng khủng khiếp
- Response chậm
- Chất lượng suy luận giảm (context rot)

Dynamic MCPs giúp **"cần gì lấy nấy"**, **Code Mode** giúp không đẩy dữ liệu trung gian qua LLM. Nhưng vẫn còn một vấn đề:

> Agent có tool, nhưng không có kiến thức sử dụng tool cho đúng.

# Vấn đề mới: Tool có rồi, nhưng expertise thì chưa
**Ví dụ rất đời:**

- Agent biết gọi Stripe API
- Nhưng không biết:
> Khi nào cần idempotency key
> Pattern xử lý webhook retry
> Best practice cho checkout flow

**Hay:**
- Agent gọi được Supabase
- Nhưng không hiểu:
> **Row Level Security** nên thiết kế thế nào
> Anti-pattern phổ biến
> Khi nào nên dùng Edge Function

=> Không có **framework context**, agent vẫn phải đoán mò, thử-sai y như con người.

# MCP giải quyết tool, nhưng không giải quyết knowledge
MCP rất tốt ở một điểm: **chuẩn hóa giao tiếp tool**.
Nhưng MCP:
- Không định nghĩa khi nào nên dùng tool
- Không gói kèm best practices
- Không nói cho agent biết workflow chuẩn của framework

**Thế là dev phải tự ghép:**
>MCP server

>Rules (.cursorrules)

> Agent Skill

> Dynamic loading

**Và mỗi IDE lại cấu hình một kiểu.**

**Fragmentation** – không thiếu capability, chỉ thiếu một gói thống nhất.

# Introducing Kiro Powers
**Kiro Powers** như là bước tiếp theo sau Dynamic MCPs.

**Nếu Dynamic MCPs trả lời câu hỏi:**
> Khi nào thì load tool?

**Thì Powers trả lời:**
> Load tool + đúng kiến thức đi kèm, chỉ khi cần.

Hiểu đơn giản:

> MCP = công cụ
> Power = công cụ + sách hướng dẫn + workflow chuẩn

![Screenshot from 2025-12-15 23-27-38.png](https://images.viblo.asia/d1aed939-b58f-4ac2-8552-aa91b63d9d15.png)


### Power là gì?
Một **Power** là một bundle gồm:
**1. POWER.md**

- File “steering” cho agent
- **Nói rõ:**
> Có tool nào
> Dùng trong trường hợp nào
> Best practices & anti-pattern

**2. MCP server configuration**
> Tool definitions
> Connection details: làm thế nào để kết nối !!

**3. Hooks / workflow bổ trợ (optional)**
- Review hook
- Slash command
- Automation nhỏ

**Điểm mấu chốt**: Power chỉ được load khi trong prompt có liên quan 


### Dynamic context loading – linh hồn của Powers

![image.png](https://images.viblo.asia/d00499a2-8d70-459e-b81c-bb657af1b081.png)

**Khác với MCP truyền thống:**
> MCP cũ: load tất cả tool upfront
> Power: load on-demand ( sẽ load khi thật sự cần)

**Ví dụ:**

- Bạn nói: "build checkout with stripe" → **Stripe Power activate**
- Bạn nói: "setup database with suppabase" → **Supabase Power activate**
- Chuyển sang deploy → Netlify Power activate, Stripe deactivate

> Baseline context gần như 0 token.

![Screenshot from 2025-12-15 23-37-30.png](https://images.viblo.asia/948060c3-068a-4272-857d-00e5fee8d7ef.png)


# Power ecosystem – không chỉ là lý thuyết
**Kiro đã có sẵn hệ sinh thái Power, mình đã thử một số power như Design to code with figma, Deploy web apps with Netlify, Build infrastructure on AWS thật sự khá bất ngờ với output, nhắc lại là output thật sự tốt**

*Ngoài ra còn có:*

- Backend: Stripe, Supabase, Neon, Postman
- UI: Figma
- Deploy: Netlify, Amazon Aurora
- Observability: Datadog, Dynatrace
- Import Power từ GitHub
- Power nội bộ cho team
- Chia sẻ Power cho cộng đồng

**Build một lần, dùng mọi nơi.**