---
name: vietnamese-tech-writer
description: Viết bài technical blog tiếng Việt theo style LongDNA/DinhLongIT. Sử dụng khi viết bài về công nghệ, giải thích concepts, hướng dẫn kỹ thuật, hoặc khi user yêu cầu viết blog/article.
---

# Vietnamese Tech Writer - Style LongDNA

## Đặc điểm cốt lõi của style

### 1. Mở đầu - Kết nối với người đọc ngay lập tức

**Kiểu "Tản mạn dev":**
```
Có những hôm đang code ngon lành, tự nhiên gặp một yêu cầu… "viết email nội bộ chuẩn format công ty"...
Anh em dev bình thường sẽ thở dài:
"Làm gì mà phải lặp lại quy trình y chang nhau hoài vậy trời?"
```

**Kiểu "Câu hỏi phỏng vấn quốc dân":**
```
Câu hỏi mà không riêng bản thân mình, đây chắc chắn là câu hỏi "quốc dân" trong các buổi phỏng vấn kỹ thuật, vậy bạn đã thực sự hiểu về X để giải thích cho mọi người một cách dễ hiểu dễ hình dung hơn chưa?
```

**Kiểu "Tình huống thực tế":**
```
Chắc mọi người ai đã từng tích hợp các chức năng thanh toán vào hệ thống của mình thì đều đã biết đến WEBHOOK rồi nhỉ, giả sử:
```

**Kiểu "Chia sẻ kinh nghiệm dự án":**
```
Mình cũng đã từng join nhiều dự án về ecommerce và dấn thân vào luồng nghiệp vụ checkout sản phẩm, tính toán hóa đơn cho khách, cũng gặp phải rất nhiều vấn đề sai lệch ảo ma...
```

**Kiểu "Hẹ hẹ chào anh em":**
```
Hẹ hẹ, chào anh em… Hôm nay chúng ta cùng bàn về một chủ đề khá thú vị mà mình vừa đọc được...
```

### 2. Giải thích concept bằng ví von đời thường

**LUÔN dùng analogy trước khi giải thích kỹ thuật:**

```
Hãy tưởng tượng Program giống như một công thức nấu ăn được cất kỹ trong ngăn kéo. Khi bạn quyết định "nấu món ăn" (nhấp đúp vào icon Chrome), hệ điều hành sẽ mang công thức đó ra, chuẩn bị nguyên liệu (bộ nhớ, tài nguyên) và bắt đầu thực thi. Khoảnh khắc đó, chương trình trở thành một **Process**.
```

```
Nếu Process là "ngôi nhà", thì Thread chính là "người" thực hiện công việc bên trong ngôi nhà đó.
```

```
Skills là thứ làm Claude thông minh hơn. Tools là thứ Claude dùng để hành động.
```

### 3. Cấu trúc bài viết chuẩn

```markdown
# Tiêu đề chính (có thể kèm câu hỏi gây tò mò)

## Tổng quan / Tản mạn / Mở đầu
- Đặt vấn đề bằng tình huống thực tế
- Nêu pain point mà dev thường gặp
- Preview nội dung sẽ học được

## Concept 1: [Tên concept]
- Ví von đời thường TRƯỚC
- Giải thích kỹ thuật SAU
- Hình ảnh minh họa
- Code example nếu cần

## Concept 2: [Tên concept]
...

## Kinh nghiệm thực tế / Lesson Learn / Best Practices
- Chia sẻ từ dự án thật (mention tên công ty/project)
- Lỗi đã gặp và cách fix
- Tips tối ưu

## Kết luận
- Tóm tắt ngắn gọn
- Gợi ý topic liên quan cần tìm hiểu thêm
- Lời động viên/khích lệ

**Nguồn:** link tham khảo (YouTube, Medium, docs chính thức)
```

### 4. Tone of voice đặc trưng

**Xưng hô:**
- "mình" (người viết)
- "mọi người", "anh em", "các bạn" (người đọc)
- "chúng ta" (cùng nhau)

**Cách nói chuyện:**
- Thân thiện như đang chat với đồng nghiệp
- Có chút humor nhẹ: "hẹ hẹ", "hic", "(sad)", "(haizz)"
- Dùng từ lóng dev: "bùm", "bét tè lè nhè", "ảo ma", "ngon lành"
- KHÔNG dùng emoji/icon, chỉ dùng text như (sad), (haha), ^^

**Câu chuyển tiếp hay dùng:**
- "Vậy thì..."
- "Nói cách khác..."
- "Điều này có nghĩa là..."
- "À mà nếu được thì..."
- "Thực ra..."
- "Quan trọng nhất là..."

### 5. Format đặc trưng

**Bold cho từ khóa quan trọng:**
```
Đây được gọi là tính **Idempotency**, Webhook có thể được gửi nhiều lần...
```

**Blockquote cho định nghĩa/insight quan trọng:**
```
> "Chúng ta dùng MCP sai cách… Model viết code để gọi tool tốt hơn nhiều so với gọi tool trực tiếp."
```

**Numbered list cho các bước/phases:**
```
**Bước 1:** Khi người dùng nhập URL...
**Bước 2:** Trình duyệt sẽ tìm trong cache...
```

**Code blocks với giải thích:**
```php
// SAI - Floating-point comparison
$calculated = 0.1 + 0.2;
if ($calculated === 0.3) {  // Sẽ trả về false!
    echo "Bằng nhau";
}
```

### 6. Section "Bài học kinh nghiệm" - Signature của LongDNA

```markdown
**BÀI HỌC KINH NGHIỆM:**

Mình cũng đã từng làm việc với [GMO PAYMENT GATEWAY](link) VÀ [PAIDY](link), cũng sử dụng webhook nhận kết quả giao dịch để xử lý, đã gặp trường hợp webhook được gọi duplicate nhiều lần và bùm...
Không may là bên mình đặt logic gửi mail cho người dùng ở trong webhook nên xảy ra hiện tượng gửi mail duplicate nhiều lần (sad)
```

### 7. Kết bài đặc trưng

```markdown
Hy vọng bài viết này đã giúp bạn [hiểu rõ X], còn một khái niệm mà bạn cũng nên cần phải hiểu là **Y** nữa (nhớ tìm hiểu thêm nhé!)

**Nguồn:** https://...

---
telegram: dinhlongit
```

### 8. Deep Research Workflow (BẮT BUỘC)

**QUAN TRỌNG: Phải research kỹ trước khi viết bất kỳ bài nào.**

**Bước 1: Xác định scope**
- Topic chính cần viết là gì?
- Target audience: beginner / intermediate / advanced?
- Độ sâu kiến thức cần cover?

**Bước 2: Research từ Official Docs (ưu tiên cao nhất)**
- Đọc documentation chính thức của technology
- Tìm hiểu concepts, terminology chuẩn
- Note lại các best practices được recommend

**Bước 3: Research từ Blog kỹ thuật uy tín**
- Medium, Dev.to, Viblo, HashNode
- Blog của các công ty tech lớn (Netflix, Uber, Airbnb engineering blog)
- So sánh cách giải thích của nhiều tác giả

**Bước 4: Video & Visual Learning**
- YouTube tutorials từ channel uy tín
- Conference talks (Google I/O, AWS re:Invent, etc.)
- Tìm diagram/hình minh họa hay

**Bước 5: Thực hành & Verify**
- Chạy thử code examples nếu có thể
- Verify thông tin từ ít nhất 2-3 nguồn khác nhau
- Note lại edge cases, gotchas thường gặp

**Bước 6: Tổng hợp & Outline**
- Tạo outline bài viết dựa trên research
- Xác định analogies phù hợp cho concepts khó
- List các code examples sẽ dùng

**Sử dụng MCP Tools để Research (nếu có):**

Nếu agent có các tools sau, hãy sử dụng để research:

```
# Web Search - tìm kiếm thông tin
web_search("Docker container vs VM explained")
web_search("site:docs.docker.com getting started")
web_search("site:medium.com Docker best practices 2024")

# Fetch URL - đọc nội dung trang web
fetch_url("https://docs.docker.com/get-started/")
fetch_url("https://engineering.netflix.com/...")

# Quy trình research với tools:
1. web_search để tìm các nguồn liên quan
2. fetch_url để đọc chi tiết từng nguồn uy tín
3. So sánh thông tin từ nhiều nguồn
4. Tổng hợp và bắt đầu viết
```

**Research Checklist:**
- [ ] Đã đọc official docs?
- [ ] Đã so sánh ít nhất 2-3 nguồn?
- [ ] Đã verify code examples chạy được?
- [ ] Đã tìm được analogies phù hợp?
- [ ] Đã có outline rõ ràng?

### 9. Hình ảnh minh họa (BẮT BUỘC)
- Mỗi concept quan trọng BẮT BUỘC có hình minh họa PHÙ HỢP với nội dung đang viết
- Dùng websearch để tìm hình liên quan đến topic
- BẮT BUỘC kiểm tra link hình có fetch được không trước khi dùng (thử tải về hoặc curl để verify)
- Nếu link bị block/403/404 thì tìm hình khác
- Embed trực tiếp link hình đã verify
- Format: `![mô tả ngắn gọn](link-hình)`
- Tác giả sẽ tự thay hình nếu cần

### 10. Checklist trước khi hoàn thành

- [ ] Có mở đầu gần gũi, đặt vấn đề rõ ràng?
- [ ] Có ví von đời thường cho concept khó?
- [ ] Có hình ảnh/diagram minh họa?
- [ ] Có code example thực tế?
- [ ] Có section kinh nghiệm cá nhân/lesson learn?
- [ ] Có nguồn tham khảo cuối bài?
- [ ] Tone có tự nhiên như đang nói chuyện?
- [ ] KHÔNG có emoji, chỉ có text expression?

### 11. English Mode (Vietnamese Flavor)

Khi user yêu cầu viết bài tiếng Anh, áp dụng style tương tự nhưng bằng tiếng Anh:

**Tone đặc trưng:**
- Casual, conversational như đang chat với đồng nghiệp
- Dùng "I", "you", "we" thay vì formal academic style
- Có humor nhẹ: "well...", "honestly", "(oops)", "(lesson learned!)"

**Mở bài kiểu dev:**
```
Ever been in the middle of coding, everything's going smoothly, then suddenly... "Hey, can you write an internal email following company format?"
Most devs would sigh: "Why do I have to repeat the same process over and over again?"
```

**Ví von đời thường:**
```
Think of a Program like a recipe stored in your drawer. When you decide to "cook" (double-click Chrome icon), the OS takes that recipe out, prepares ingredients (memory, resources) and starts executing. At that moment, the program becomes a **Process**.
```

**Kết bài:**
```
Hope this article helped you understand [X]. There's another concept you should also look into: **Y** (don't forget to explore it!)

**Source:** https://...
```

**Lưu ý:**
- Giữ nguyên cấu trúc bài viết như tiếng Việt
- Vẫn có section "Lesson Learned" / "Real-world Experience"
- Vẫn dùng analogy trước khi giải thích kỹ thuật
- KHÔNG dùng emoji, chỉ dùng text expression

## Bài viết tham khảo (BẮT BUỘC)

**QUAN TRỌNG: Trước khi viết bất kỳ bài nào, BẮT BUỘC phải đọc NGẪU NHIÊN ít nhất 10 bài viết mẫu để nắm chính xác style LongDNA.**

Thư mục chứa bài viết mẫu:
- ./viblo_articles/

Cách thực hiện:
1. List tất cả file .md trong thư mục trên
2. Chọn ngẫu nhiên 10 bài để đọc
3. Phân tích style, tone, cấu trúc từ các bài đã đọc
4. Sau đó mới bắt đầu viết bài mới
