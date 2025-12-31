# Từ 150k tokens còn 2k tokens: Dynamic MCPs & Code Mode tối ưu hóa chi phí và tốc độ cho AI Agents

# Tổng quan
Hẹ hẹ, chào anh em… Hôm nay chúng ta cùng bàn về một chủ đề khá thú vị mà mình vừa đọc được liên quan đến MCP và cách AI Agent sử dụng tool sao cho hiệu quả nhất.
Hai keyword quan trọng ở đây là **Dynamic MCPs** và **Code Mode**. Đây không chỉ đơn thuần là tối ưu hóa — mà thực sự là “đập đi xây lại” cách AI Agent tương tác với thế giới bên ngoài.

Nếu anh em đang build agent cho doanh nghiệp, build automation SaaS, hay đang nghiên cứu multi-agent orchestration hoặc đang sử dụng rất nhiều AI Agent coding kết hợp với rất nhiều mcp để coding… thì bài này là “món chính” dành cho anh em.

![image.png](https://images.viblo.asia/70118c8f-5dce-46d5-8710-bd87279184f8.png)

**Bài viết này gồm:**

**1. Vì sao cơ chế gọi tool cũ trong MCP không còn hiệu quả?**

**2. Dynamic MCPs & Code Mode thật sự là gì? Hoạt động ra sao?**

**3. Những nâng cấp “đổi đời” cho agent: hiệu năng, bảo mật, mở rộng, automation**

**4. So sánh trực quan để thấy rõ hiệu quả mà không phải tradeoff**

**5. Usecase thực chiến cho dev Backend/DevOps**

Nếu có thể thì mọi người cũng nên đọc:

[Anthropic Code Execution](https://www.anthropic.com/engineering/code-execution-with-mcp)

[Cloudflare Code Mode](https://blog.cloudflare.com/code-mode/)

[Dynamic MCP With Docker](https://www.docker.com/blog/dynamic-mcps-stop-hardcoding-your-agents-world/)

# 1. 2025 - Kỷ nguyên AI Agent kết nối hàng ngàn công cụ (MCP)
Năm 2025, AI Agent có thể kết nối tới hàng ngàn công cụ thông qua giao thức tiêu chuẩn MCP ([Model Context Protocol](https://www.youtube.com/watch?v=_d0duu3dED4)). Chắc anh em IT cũng ít nhiều đã nắm MCP là gì rồi nhỉ? Bài viết này mình sẽ không giải thích lại phần đó nữa…

![image.png](https://images.viblo.asia/f0806f36-daab-448e-8e97-7b4f3fa4ac63.png)

**"À mà nếu được thì anh em nên hiểu bản chất và tự build một MCP server đơn giản bằng fastmcp — như vậy sẽ nắm rất rõ cách mọi thứ vận hành phía sau."**

Điều này mở ra viễn cảnh agent tự động hóa mọi việc:
- Crawl dữ liệu
- Gọi API
- Tương tác các dịch vụ bên ngoài
- Tự build workflows

Nhưng rồi… anh em dev dùng nhiều thì sẽ nhận ra một sự thật đau lòng:
**Agent càng tích hợp nhiều tool → càng tốn token → càng chậm → càng đắt.**

Như ae có thể thấy mình tích hợp serena mcp và nhiều mcp vào claude code, Claude phải nhét toàn bộ tool definitions + schema JSON của từng tool vào context conversation ngay từ đầu.
![Screenshot from 2025-12-04 22-25-14.png](https://images.viblo.asia/dc227228-028d-4d86-bb9b-49d976369014.png)

**Điều này khiến Agent sẽ làm việc kém hiệu quả:**

- **Token bloat** – nạp quá nhiều mô tả tool
- **Context overload** – context window bị chiếm sạch
- **Tốn nhiều tokens:** Chi phí tăng vọt

**Anthropic** chỉ ra một [case thực tế](https://medium.com/m/global-identity-2?redirectUrl=https%3A%2F%2Fdrlee.io%2Fstop-bleeding-tokens-how-code-execution-with-mcp-cuts-your-ai-agent-costs-by-98-ccd7d1c7c15b#:~:text=The%20cost%20compounds%20quickly%3A):

> Một agent load 47 MCP servers → ~150.000 tokens chỉ để load tool definitions

# 2. Vấn đề: Tích hợp tool truyền thống = cách tiếp cận chưa tối ưu
Mình nhận ra rằng mọi thứ luôn được cải tiến dựa trên những gì có trước đó. Nếu thường xuyên cập nhật xu hướng, bạn sẽ thấy vài năm gần đây, AI phát triển với tốc độ cực kỳ nhanh — đặc biệt là bước sang năm 2025. Có thể rồi sẽ đến lúc tốc độ này chững lại, nhưng sự cải tiến và tinh thần học hỏi thì sẽ còn tiếp tục mãi.

![load.png](https://images.viblo.asia/9263ef07-4be1-4686-ac6f-1286f6feaab5.png)

### (1) Toàn bộ tool definitions bị đẩy vào Context Window

**Trong cách tiếp cận MCP truyền thống, khi agent khởi động:**

→ Toàn bộ tên tool, mô tả, schema JSON, tham số… từ tất cả MCP servers, đều bị nhét vào context.

**Kết quả:**
- Mô hình phải “đọc hết sách giáo khoa” trước khi trả lời người dùng
- Token tiêu thụ tăng đột biến
- Response có thể "rùa bò" đến mức mình phải break giữa chừng vì đợi quá lâu. !!!!!!
- Dễ vượt giới hạn context window của llm

**(2) Dữ liệu trung gian phải chảy qua model nhiều lần**

**Ví dụ workflow:**

> “Lấy biên bản họp từ Google Drive → cập nhật vào Salesforce”

**Cách cũ (truyền thống – rất tốn token)**
1. Tool A (Google Drive MCP) trả về 25.000 từ nội dung biên bản họp.
2. LLM phải nhét toàn bộ 25.000 từ vào context window ngay từ đầu.
3. Khi chuyển sang bước tiếp theo:
-  LLM gọi Tool B (Salesforce MCP)
-  Nhưng theo cơ chế cũ, **LLM** phải gửi lại nguyên 25.000 từ thêm một lần nữa, cộng với các ví dụ, khai báo tool, metadata…

4. Trong Claude Code, chỉ cần 2–3 vòng gọi tool như vậy là:
- Token bloat → nổ quota
- Model bị context overload
- Response chậm
- Chi phí tăng cao theo cấp số nhân

```
TOOL CALL: gdrive.getDocument(documentId: "abc123")
    → returns "Nội dung biên bản họp Q3: ... (toàn bộ 25.000 từ)"  (kết quả này được đưa vào context của model)
TOOL CALL: salesforce.updateRecord(objectType: "SalesMeeting", 
    recordId: "00Q5f000001abcXYZ", 
    data: { "Notes": "Nội dung biên bản họp Q3: ... (toàn bộ văn bản 25.000 từ ở trên)" } )
```

Cùng một dữ liệu dài chảy qua context hai lần, tổng cộng ~50.000 token chỉ để chuyển tiếp thông tin, chưa kể 150k token định nghĩa tool ban đầu (haizz)

Một ví dụ nữa mà mình cũng hay dùng Claude code command để review code:

Sẽ phải gọi từng tool để:
> Lấy thông tin pull request (PR)
> Lấy diff
> Lấy lịch sử commit
> Lấy nhận xét review
> Gộp tất cả kết quả vào một phản hồi có cấu trúc duy nhất

→ Giờ đây chỉ cần viết 1 đoạn script duy nhất sử dụng code-mode, gọi tất cả công cụ trên, xử lý logic tập trung trong sandbox (hẹ hẹ quá là tiết kiệm token và có thể sẽ rất nhanh)

Thực ra trước đó mình cũng đã nghĩ tới việc tối ưu flow này bằng cách viết một đoạn code python để làm những việc trên sau đó agent sẽ run đoạn code này nhưng giờ thì  :v

>  !!! Đây chính là nút cổ chai lớn nhất của cách tiếp cận cũ .

Một tác vụ lẽ ra chỉ tốn vài trăm token và hoàn thành trong vài giây thì nay “ngốn” đến hàng trăm nghìn token và kéo dài gần một phút, vậy giải pháp ở đây là gì, ae đọc tiếp nhé !!!

# 3 Dynamic MCPs và Code Mode: Giải pháp tối ưu mới
![image.png](https://images.viblo.asia/4e72df1a-2ac6-45ae-ade3-7efc7e9e1657.png)
**Dynamic MCPs và Code Mode** ra đời nhằm khắc phục triệt để những hạn chế nói trên. 
Tư tưởng dễ theo cách mình dễ hiểu là:
> “Chúng ta dùng MCP sai cách… Model viết code để gọi tool tốt hơn nhiều so với gọi tool trực tiếp.”

Thay vì nạp cả tools và gọi tuần tự từng cái thông qua mô hình, hãy để agent tự động khám phá và chỉ nạp những tool cần thiết, đồng thời viết code để sử dụng các công cụ đó trong một môi trường thực thi như  container. 
Cách tiếp cận này tận dụng điểm mạnh vốn có của LLM (hiểu và sinh code) và loại bỏ được bước trung gian không cần thiết qua context. 

Nói cách khác, LLM đã quen với hàng triệu dòng code TypeScript/Python trong tập training, nên việc yêu cầu nó lập trình sử dụng API sẽ tự nhiên hơn nhiều so với việc bắt nó sử dụng cú pháp gọi “tool” đặc thù mà nó ít được học.

> Hóa ra bấy lâu nay chúng ta dùng MCP sai cách… LLM giỏi viết code để gọi MCP hơn là gọi thẳng MCP, và có thể xâu chuỗi nhiều lệnh tốt hơn, vì khi viết code nó không phải đẩy kết quả trung gian qua lại với llm, mọi người nghĩ sao ???

## 3.1 Code Mode – LLM viết code để gọi tool trong sandbox
![image.png](https://images.viblo.asia/884221a7-e30f-4f18-a913-864874e1b02d.png)

**Code Mode** là “vũ khí bí mật” giúp agent tối ưu luồng xử lý. Ý tưởng rất rõ ràng: thay vì bảo mô hình “hãy gọi tool X với tham số Y”, ta nói “hãy viết đoạn code để làm việc X sử dụng các API đã cho”

**Thay vì:**
> “Gọi tool A → đổ output A vào model → gọi tool B”

**Ta làm:**
> “LLM viết code TypeScript/Python gọi cả A và B → chạy trong sandbox → trả về kết quả cuối.”

**Ví dụ Google Drive → Salesforce (cách mới):**
```
import * as gdrive from './servers/google-drive';
import * as salesforce from './servers/salesforce';

const transcript = (await gdrive.getDocument({ documentId: 'abc123' })).content;

await salesforce.updateRecord({
  objectType: 'SalesMeeting',
  recordId: '00Q5f000001abcXYZ',
  data: { Notes: transcript }
});
```

- Model không thấy 25.000 từ transcript
- Không đẩy dữ liệu qua llm lần 2
- Không lặp token
- Không lấp context

**Lợi ích Code Mode:**

(1) Không còn truyền dữ liệu trung gian qua model
> Tất cả chạy trong sandbox → model chỉ nhìn kết quả cuối.

(2) Sandbox an toàn
> Chạy trong Docker container → không truy cập hệ thống.

(3) Flow phức tạp → dễ viết hơn

Ví dụ: Loop Slack đến khi deploy xong

```
while (true) {
  const logs = await slack.getHistory(...);
  if (logs.includes("deploy completed")) break;
  await sleep(5000);
}
```

Dùng tool call tuần tự? → 10 vòng gọi → bét tè lè nhè luôn context, dùng code thì dễ kiểm soát hơn !!!!

(4) Xử lý Big Data mà không **“làm nghẽn não model”**

> **Ví dụ File excel 10.000 dòng:**
> → Code lọc xuống 5 dòng cần thiết thay vì nhét hết vào llm 
> → Chỉ gửi 5 dòng cuối lên LLM

(6) Lưu trạng thái & tái sử dụng kỹ năng (Skills),
Agent có thể: ghi file, caching, lưu script, tái sử dụng code ở lần chạy sau -> mình cũng có 1 bài chia sẻ về agent skills [ở đây ](https://viblo.asia/p/claude-agent-skills-hieu-tu-goc-den-ngon-AY4qQQwk4Pw)


# 3.2 Dynamic MCPs đến từ vị trí Docker – Agent chỉ nạp tool khi cần (Cần gì lấy nấy)
![image.png](https://images.viblo.asia/b307e957-b98b-4fff-a145-2a3ee44f473d.png)

Thay vì cấu hình cố định danh sách MCP server vào file mcp.json như trước và nạp trước mọi tool, phương pháp mới cho phép agent chủ động tìm kiếm và thêm tool trong lúc chạy. Docker đã tích hợp khả năng này thông qua **Docker MCP Gateway**

### Dynamic Tool Loading
**Docker MCP Gateway** đã tung ra 2 “primordial tools”:
> mcp-find: → Cho phép agent tìm kiếm tool trong catalog 270+ MCP servers (docker list thì mình nghĩ cùng trust rồi)

> mcp-add: Cho phép agent tự kết nối vào bất kỳ MCP server nào ngay trong phiên làm việc, không cần developer cấu hình từ trước (không cần JSON config, không cần .mcp/servers.json). (quá sướng)

Có vẻ cũng nhàn nhỉ, Catalog như App Store cho AI Agent
Agent tự tìm:
- notion mcp
- slack mcp
- github mcp
- google drive mcp
- stripe mcp
…và tự quyết dùng tool nào.

Ví dụ:
Agent: “Tôi cần dùng github mcp để list ra top 10 github trending tuần này”
→ Agent gọi mcp-find để tìm "github"
→ Agent gọi mcp-add để bật GitHub MCP server
→ Bộ công cụ GitHub xuất hiện ngay lập tức và agent có thể dùng luôn để dùng

**Không reload. Không config. Không cần cài trước. Đúng nghĩa dynamic MCP.**

### Progressive Disclosure – chỉ nạp tool khi chắc chắn cần
Khi agent đã thêm một MCP server mới, gateway không tự động đẩy tất cả định nghĩa tool của server đó vào context ngay, Thay vào đó, agent có thể dùng một tool tìm kiếm khác (ví dụ search_tools) để tra cứu trong server đó những chức năng liên quan đến nhiệm vụ hiện tại (tối ưu ghê)... 

Điều này giúp giảm bớt tối đa lượng dữ liệu mô hình phải đọc – tránh trường hợp **“mò kim đáy bể”** khi có quá nhiều tool dư thừa. 
Một bài viết gần đây về Code Mode [Anthropic ghi nhận](https://www.anthropic.com/engineering/code-execution-with-mcp), nhờ chỉ nạp định nghĩa cần thiết, **họ đã giảm từ 150k token định nghĩa xuống còn ~2k token cho tác vụ**, tương đương **tiết kiệm đến 98,7%**

**“Cần gì lấy nấy”.** Agent giờ đây có thể giữ context gọn nhẹ, tránh được tình trạng overload Context Window bởi các tool không dùng tới (quá đã)


### Nhìn chung, sự kết hợp giữa Dynamic MCPs và Code Mode đem lại một bước nhảy vọt về hiệu năng và khả năng tự chủ cho AI agent. Để dễ hình dung, hãy so sánh quy trình trước và sau khi áp dụng các kỹ thuật này:

| Khía cạnh        | Trước: Static MCP   | Sau: Dynamic MCP + Code Mode | Lợi ích                        |
| ---------------- | ------------------- | ---------------------------- | ------------------------------ |
| Khám phá tool    | Dev tự liệt kê      | Agent dùng `mcp-find`        | Tự động hóa hoàn toàn          |
| Thêm tool        | Config cố định      | Agent tự `mcp-add`           | Không cần cấu hình             |
| Xác thực         | Dev setup OAuth     | Agent tự bật OAuth UI        | Mượt mà                        |
| Phối hợp tool    | LLM gọi tuần tự     | Code Mode viết script        | Workflow phức tạp đơn giản hóa |
| Tốc độ & chi phí | Token bloat         | Giảm 98,7% token             | Nhanh & rẻ                     |
| Big data         | Tràn context        | Lọc trong code               | Không overload model           |
| Mở rộng          | Tĩnh                | Linh hoạt                    | Tăng tool vô hạn               |
| Bảo mật          | Dữ liệu qua model   | Dữ liệu xử lý trong sandbox  | Không lộ thông tin             |
| Developer        | Phải cấu hình nhiều | Agent tự phục vụ             | Dev nhàn hơn                   |

# 4. Ứng dụng thực tiễn cho Backend/DevOps
Dynamic MCPs + Code Mode đã được hiện thực hóa, lúc trước mình có đọc bài viết code mode của Anthropic nhưng không biết sao họ vẫn chưa push giải pháp này vào claude code.

Những cải tiến của **Dynamic MCPs và Code Mode** không chỉ mang ý nghĩa lý thuyết, mà đã và đang được triển khai trong các công cụ và nền tảng hiện có. 
- **Docker MCP Gateway** cung cấp hạ tầng chạy MCP server an toàn trong Docker và hỗ trợ sẵn Smart Search và Tool Composition để agent có thể tìm kiếm, thêm tool động và chạy code trong sandbox một cách dễ dàng

- **Cloudflar**e đã tích hợp chế độ **Code Mode trong AI SDK** của họ – chỉ với vài dòng khai báo, bạn có thể biến danh sách tool tĩnh thành một API TypeScript để mô hình sử dụng code

- **Anthropic Claude** cũng đã có tính năng “**Code Interpreter**” tương tự cho phép agent thực thi code Python và tương tác MCP (tương tự như ChatGPT Code Interpreter nhưng mở hơn). 

→ Tất cả đều hướng đến một mục tiêu: giúp các developer xây dựng được những AI agent mạnh mẽ hơn, tự chủ hơn, mà lại an toàn và hiệu quả hơn về chi phí.

Cái này thì đã có rồi nhưng anh em cứ tưởng tượng tới 1 con Agent tự chủ như 1 con người thật, tự động làm các công việc hiệu quả để giảm thiệu các việc lặp đi lặp lại của anh em mình:

> Một DevOps Agent tự tìm MCP server “github”, “pagerduty”, “grafana”, “slack”… rồi phối hợp tạo pipeline tự động. Không cần ae phải cấu hình trước.

> Một Agent tự động sử dụng sử dụng slack mcp, notion mcp để tổng hợp những cuộc thảo luận trong ngày

Rất rất là nhiều ý tưởng cho anh em !!!!
# 5. Kết luận
Tóm lại, Dynamic MCPs và Code Mode đang giải quyết “điểm nghẽn” của các AI agent hiện nay, giúp chúng nhanh hơn, rẻ hơn, an toàn hơn và thông minh hơn. 
Những agent thế hệ mới này không chỉ biết “đọc sách giáo khoa” mà còn biết “tự viết chương trình” để hoàn thành công việc. 
Đây là một bước tiến quan trọng hướng tới tương lai mà AI có thể thật sự tự động hóa nhiều quy trình phức tạp thay con người. 

Mình nghĩ đây đúng là giai đoạn “**vàng**” để anh em mình cùng khám phá và áp dụng những kỹ thuật mới.
Để mạnh dạn gỡ bỏ những bottleneck trong workflow — từ công ty, dự án cho đến cả cuộc sống hằng ngày — và quan trọng nhất là không bị tụt lại phía sau.