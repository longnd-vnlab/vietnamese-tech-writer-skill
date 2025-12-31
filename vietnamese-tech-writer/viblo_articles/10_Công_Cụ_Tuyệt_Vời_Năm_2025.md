# 10 Công Cụ Tuyệt Vời Mình Bắt Đầu Sử Dụng Năm 2025

## Tản mạn dev năm 2025

Năm 2025 thật sự là một năm đặc biệt với anh em dev chúng mình. Có những hôm ngồi code, tự nhiên nhận ra "ơ, mình đang làm việc hoàn toàn khác so với năm ngoái". Không phải vì công nghệ thay đổi chậm, mà là vì nó thay đổi... quá nhanh (haha).

AI agents ngày càng thông minh hơn, các công cụ backend ngày càng nhẹ hơn, observability ngày càng dễ setup hơn. Thậm chí cả việc viết code cũng có editor mới nhanh đến mức khó tin.

Bài viết này mình sẽ chia sẻ 10 công cụ mà cá nhân mình đã bắt đầu dùng trong năm 2025 và cảm thấy trải nghiệm phát triển phần mềm tốt hơn hẳn. Một số công cụ có thể mọi người đã biết, một số thì khá mới mẻ.

Let's go!

## 1. Claude Code — AI Agent Thống Trị Năm 2025

![Claude Code](https://images.viblo.asia/dbbcc583-118e-46e2-bb1b-c75b4a6a133e.png)

Phải nói ngay về Claude Code trước, không thì không trung thực được (hehe).

Như mọi người đã biết, Claude Code là AI coding agent "bá chủ" năm 2025 với hai lợi thế cực kỳ quan trọng:

**Opus 4.5 trong gói subscription**
- Đây là model coding mạnh nhất thời điểm hiện tại
- Trước đây phải trả theo từng request với Cline/RooCode
- Giờ fixed monthly fee → tiết kiệm cực nhiều tiền
- Đây chính là lý do migration wave từ các tool khác sang Claude Code

**Tính năng tiên tiến nhất**
- Sub-agents để xử lý các task phức tạp
- Agent Skills để đóng gói workflow
- Extended Thinking Mode (think hard, ultrathink)
- LSP integration để hiểu code tốt hơn

Mình thấy các tool khác như Antigravity tuy có tính năng hay nhưng model Gemini 3.0 Pro (vẫn đang Preview) chưa thể so với Opus 4.5 về khả năng giải quyết vấn đề. Còn Cursor thì ngược lại - cũng có Opus 4.5 và nhiều feature độc quyền từ v2 trở đi, nhưng chi phí cao hơn nên mình chưa có điều kiện thử nghiệm sâu.

**Năm 2025 = Năm của Claude Code** (ít nhất với cá nhân mình là vậy)

## 2. TrailBase — Supabase Alternative Siêu Nhẹ

![TrailBase](https://images.viblo.asia/f8de2326-b8ea-4c8d-aeae-a9d093d63e10.png)

Một ngày đẹp trời, mình cần deploy một app fullstack nhưng không muốn setup cả Supabase stack nặng nề. Thế là tìm thấy TrailBase.

**TrailBase là gì?**
- Backend-as-a-Service platform self-hosted
- Viết bằng Rust → cực kỳ nhanh
- Benchmark claim nhanh hơn Supabase **40 lần**
- Memory usage chỉ **~100MB** (Supabase ~6GB)

**Điểm hay nhất:**
- Build React/Vue app → chỉ vào build directory
- TrailBase serve luôn static files trong cùng 1 process
- Containerize → 1 container chạy cả backend + frontend
- Deploy lên VPS, Fargate, Cloud Run đều được → rẻ cực kỳ

**So sánh với PocketBase**
- PocketBase cũng tương tự TrailBase
- TrailBase hơn: WASM cho custom endpoints, performance cao hơn khi load nặng
- PocketBase hơn: authentication features phong phú hơn

Tuy nhiên cả hai đều follow chuẩn SQL và Web standards, nên kiến thức học được khá portable.

**Lời khuyên:**
Nếu đang build side project hoặc startup giai đoạn đầu, thử TrailBase xem. Setup nhanh, tài nguyên tiêu tốn ít, chi phí thấp.

## 3. marimo — Python Notebook Theo Kiểu Reactive

![marimo Notebook](https://images.viblo.asia/99b2e42b-e45d-4789-9478-df0eaff35780.png)

Ai làm data science hoặc ML chắc đều quen với Jupyter Notebook. Nhưng marimo thì khác.

**Sự khác biệt cốt lõi:**

Jupyter: Imperative (bạn phải nhớ thứ tự chạy cells)
- Cell A chạy trước
- Cell B chạy sau
- Chạy lại Cell A → Cell B không tự update → **hidden state hell**

marimo: Reactive (như React/Vue)
- marimo quản lý dependency graph giữa các cells
- Khi cell A thay đổi → tất cả cells phụ thuộc vào A tự động re-run
- Không còn out-of-order execution issues

**Tưởng tượng đơn giản:**
> Nếu Jupyter là jQuery (imperative), thì marimo là React (declarative).

**Tính năng khác:**
- Lưu dưới dạng pure Python file → Git-friendly
- Có thể run như script hoặc deploy thành web app
- AI assistant tích hợp sẵn, hiểu context của variables

Cá nhân mình rất thích paradigm này. Nếu có Julia version thì càng tuyệt (hehe).

## 4. ClickStack — Observability Stack Cực Đơn Giản

![ClickStack Architecture](https://images.viblo.asia/843b073e-5483-496b-be17-816598153ec6.png)

Mình từng setup LGTM stack (Loki/Grafana/Tempo/Mimir) cho monitoring. Nói thẳng: đau đầu vì phải quản lý nhiều stateful systems.

**ClickStack xuất hiện như cứu tinh:**
- All-in-one observability platform từ ClickHouse
- Tích hợp OpenTelemetry Collector + ClickHouse + HyperDX UI
- Logs, Metrics, Traces, Session Replay trong một nơi

**So với LGTM stack:**
- Không cần quản lý nhiều databases riêng lẻ
- Cross-signal correlation native (không cần plugin)
- Hỗ trợ cả SQL và Lucene query syntax

**Thực tế:**
Tất nhiên ClickStack vẫn thiếu một số features so với mature stack như Grafana. Nhưng với startup hoặc mid-size project, setup nhanh và chi phí thấp là điều quan trọng hơn.

Nếu team bạn không đủ budget cho DataDog/NewRelic, hãy thử ClickStack.

## 5. Aurora DSQL — Serverless Database Thực Sự

![Aurora DSQL](https://images.viblo.asia/2e782497-d235-4f56-b973-31c1d6cb6a99.png)

Trước giờ "serverless database" thường là:
- Database có auto-scaling
- Hoặc có base cost hằng tháng dù không dùng

**Aurora DSQL khác:**
- PostgreSQL-compatible
- Truly serverless → pay per request (như DynamoDB)
- Multi-region, active-active, strongly consistent
- 99.99% SLA (single region), 99.999% (multi-region)

**Trade-offs:**
- Không có foreign key constraints (distributed system)
- Không dùng được PostgreSQL extensions
- Nhưng 90% apps không cần những thứ này

**Lý do mình thích:**
Zero cost khi không dùng. Với các bạn sinh viên, freelancer, hoặc startup giai đoạn đầu, đây là điều cực kỳ quan trọng.

Thay vì phải trả base cost hằng tháng cho database "chờ" request, giờ chỉ trả khi có traffic thật.

## 6. byethrow — Result Type Cho TypeScript

Ai làm backend chắc biết Result type pattern (Rust, Go đều có). Nhưng TypeScript thì sao?

**Các libraries hiện có:**
- `effect-ts`, `fp-ts` → quá phức tạp, như học ngôn ngữ mới
- Phải học nhiều concept: Effect, Task, Reader, IO...

**byethrow giải quyết:**
```typescript
// Simple, clear API
import { R } from '@praha/byethrow';

function divide(a: number, b: number) {
  if (b === 0) return R.err('Division by zero');
  return R.ok(a / b);
}

const result = divide(10, 2);
if (R.isOk(result)) {
  console.log(result.value); // 5
}
```

**Điểm hay:**
- Plain objects (không phải classes) → JSON serializable
- Tree-shakable → bundle size nhỏ
- Syntax đơn giản nhưng đủ mạnh
- Tương thích tốt với React Server Components

> "Ngọt vừa đủ giữa simple và powerful"

Nếu bạn cần Result type cho TypeScript backend nhưng không muốn học cả fp-ts ecosystem, byethrow là lựa chọn tốt.

## 7. Connect (ConnectRPC) — gRPC Cho Web Hiện Đại

![ConnectRPC](https://images.viblo.asia/18ea9d0c-cfda-4c76-a2aa-e3afb836e853.png)

Khi làm fullstack với React Server Components, đôi khi bạn cần:
- Client component gọi trực tiếp backend (bypass BFF)
- Type-safe communication
- Không muốn setup phức tạp

**Các lựa chọn truyền thống:**
- OpenAPI/GraphQL → overkill cho nhiều cases
- gRPC thuần → cần Envoy proxy cho browser
- Mixing nhiều thứ → architecture phức tạp

**Connect giải quyết:**
- gRPC-compatible
- Browser gọi trực tiếp (không cần proxy)
- Protobuf-based → type safety
- TypeScript và Go support tốt

**Use case điển hình:**
```
Browser Client → Connect → Backend
      ↓
React Server Component (BFF) → Connect → Backend
```

Một protocol duy nhất cho cả client-direct và BFF calls.

**Nhược điểm:**
- Hỗ trợ ít ngôn ngữ (chỉ TypeScript, Go chủ yếu)

Nhưng nếu stack của bạn là TypeScript + Go, Connect là lựa chọn tối ưu cho type-safe RPC.

## 8. Zed — Editor Nhanh Như Chớp

![Zed Editor](https://images.viblo.asia/7cb72b7b-9096-4de6-b852-f811391cdf86.png)

**Lý do mình tìm Zed:**
- Dùng Claude Code trong VS Code terminal → UI đôi khi bị vỡ
- Muốn thử editor không phải VS Code fork
- Thử qua Neovim nhưng config curve hơi steep

**Zed là gì:**
- Code editor viết bằng Rust
- GPU-accelerated rendering
- Từ creators của Atom và Tree-sitter
- Native collaboration (như Google Docs)

**Trải nghiệm:**
- Startup gần như instant
- Preview markdown trong bài này → cực mượt
- Gõ Vietnamese input ổn định (trước đây hay bị lỗi)
- AI integration với Claude built-in

**So với VS Code:**
- VS Code: mature, nhiều extensions
- Zed: nhanh hơn rõ rệt, nhẹ hơn, đơn giản hơn

Nếu bạn đang tìm một editor mới, nhẹ, nhanh, và có collaborative features, Zed đáng thử.

## 9. CodeRabbit — AI Code Review Với AST Analysis

![CodeRabbit](https://images.viblo.asia/4263e279-1599-44d5-838f-f03f8dd9c901.png)

Hầu hết AI code review tools đọc code như đọc text. CodeRabbit khác.

**Cách hoạt động:**
- Phân tích Abstract Syntax Tree (AST)
- Kết hợp SAST (Static Application Security Testing)
- Hiểu code structure, không chỉ text

**Tại sao quan trọng:**
- Claude Code viết code bằng LLM reasoning
- CodeRabbit review bằng AST analysis
- Hai cơ chế khác nhau → bắt được nhiều bugs hơn

**Workflow hiện đại:**
```
Claude Code viết code
    ↓
CodeRabbit review AST
    ↓
Suggest fixes
    ↓
Claude Code fix
```

Gần như không cần human intervention cho các bugs phổ biến.

**Metrics thực tế:**
- 46% accuracy trong việc detect runtime bugs
- Học được từ repository history
- Customizable rules qua AST templates

Một nghiên cứu năm 2025 của CodeRabbit cho thấy: **AI-generated code có gấp 1.7x bugs so với human code**. Đây chính là lý do cần tool review tốt.

## 10. DeepSeek API — LLM API Rẻ Nhất Thị Trường

![DeepSeek Pricing](https://images.viblo.asia/f8a06371-8482-4ca6-a7f5-be2dc23e94a0.png)

Khi tích hợp LLM vào product, cost là vấn đề lớn. DeepSeek V3.2 là solution.

**So sánh giá (per 1M tokens):**

| Model | Input | Output |
|-------|-------|--------|
| DeepSeek V3.2 | $0.28 | $0.42 |
| GPT-5 mini | $0.25 | $2.00 |
| Claude 4.5 Haiku | $1.00 | $5.00 |

**Điểm mạnh:**
- Input cost tương đương GPT-5 mini
- **Output cost chỉ 1/5** → tiết kiệm cực nhiều
- Performance ngang hàng với budget models khác

**Trade-offs:**
- Công ty Trung Quốc → không nên dùng cho sensitive data
- Nhưng với public-facing features, educational content → OK

**Use cases phù hợp:**
- Chatbot customer support
- Content generation
- Code explanation (non-sensitive)
- Educational tools

Nếu cần tích hợp LLM với budget hạn chế, DeepSeek là lựa chọn đáng cân nhắc.

## Những Công Cụ Mình Dùng Rồi... Bỏ

Không phải công cụ nào cũng "stick" được (hehe).

**Spec-driven development tools:**
- Các tool yêu cầu viết spec trước, rồi generate code
- Vấn đề: thời gian sửa spec có khi lâu hơn code
- Claude Code Plan Mode quá tốt → không cần nữa

**Convex:**
- TypeScript-first Supabase alternative
- DX tốt cho TypeScript devs
- Nhưng cuối cùng vẫn phải viết business logic
- Không khác nhiều so với Next.js fullstack

## Kết Luận

Năm 2025 có quá nhiều công cụ hay, mình còn nhiều thứ chưa kịp thử (như S3 Vectors).

**Trend chung mình thấy:**
- AI agents ngày càng mạnh (Claude Code, CodeRabbit)
- Backend tools ngày càng lightweight (TrailBase)
- Developer experience được ưu tiên (marimo, Zed)
- Cost optimization quan trọng hơn (Aurora DSQL, DeepSeek)

Mỗi công cụ trên giải quyết một pain point cụ thể. Không có silver bullet, nhưng biết chọn đúng tool cho đúng use case sẽ tăng productivity rất nhiều.

Nếu mọi người có công cụ hay năm 2025, comment chia sẻ nhé!

---

**Nguồn tham khảo:**

- [Claude Code Official](https://www.anthropic.com/claude-code)
- [TrailBase Documentation](https://trailbase.io/)
- [marimo Official Site](https://marimo.io/)
- [ClickStack Blog](https://clickhouse.com/blog/clickstack-a-high-performance-oss-observability-stack-on-clickhouse)
- [Aurora DSQL on AWS](https://aws.amazon.com/rds/aurora/dsql/)
- [byethrow on GitHub](https://github.com/praha-inc/byethrow)
- [ConnectRPC Official](https://connectrpc.com/)
- [Zed Editor](https://zed.dev/)
- [CodeRabbit](https://www.coderabbit.ai/)
- [DeepSeek API Pricing](https://api-docs.deepseek.com/quick_start/pricing)
