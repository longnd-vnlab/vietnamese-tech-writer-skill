# Debug Mode — Khi Tư Duy Debug Truyền Thống Được “Nâng Cấp” Bởi Agent

Debug luôn là một trong những công việc tốn thời gian nhất của lập trình viên. Dù anh em có viết code tốt đến đâu thì việc phải phân tích một hành vi bất thường, một flow lạ, hay một lỗi hiếm gặp vẫn là chuyện thường xuyên xảy ra.

Điều thú vị là: dù công cụ thay đổi liên tục, tư duy debug hiệu quả thì gần như không đổi. Và Debug Mode của Cursor lần này chỉ đang làm tự động hoá điều mà ae dev chúng ta vốn đã làm trong đầu từ lâu.

# 1. Thời debug “manual”: chậm nhưng không thể tránh
![image.png](https://images.viblo.asia/5ffb259f-2ce8-4bf7-a4ca-7935a2558870.png)
Nhiều năm làm dev, cách debug phổ biến nhất vẫn là:
1. Thêm vài dòng debug log vào đúng chỗ nghi vấn
2. Chạy lại flow để tái hiện hành vi
3. Đọc log theo thứ tự thời gian để xem hệ thống đã làm gì
4. Suy luận nguyên nhân từ chuỗi log
5. Sửa code → lặp lại tất cả

**Một thay đổi nhỏ đôi khi tốn cả nửa ngày vì:**

> - Lúc đầu log chưa đủ → thêm log → chạy lại
> - Có khi log chưa đúng vị trí → sửa rồi chạy lại
> - Log quá nhiều → đọc mỏi mắt → lọc lại
> - Chạy flow mất thời gian
> - Trong team thì mọi người debug theo mỗi kiểu, thiếu thống nhất

Cách này chậm, nhưng không dev nào tránh được vì log chính là sự thật của runtime - thứ duy nhất cho biết hệ thống thực sự chạy thế nào.

# 2. Khi Agent xuất hiện: tư duy debug không đổi, nhưng người thực thi đã khác
![image.png](https://images.viblo.asia/046af54f-2cbf-4b07-99b9-701905fe5355.png)

Gần một năm nay, anh em dùng AI coding assistant/agent nhiều hơn:
Cursor, Claude Code, Windsurf, Copilot Workspace…

Nhưng tư duy debug không hề thay đổi.
Chỉ khác là người thực thi giờ ** đã là Agent, không còn là mình.**

Cách hiệu quả nhất để debug với AI cũng rất giống debug truyền thống:
Nó biết:
*  Bảo Agent thêm debug log chi tiết vào đúng những điểm nghi vấn.
* Bảo nó tự chạy lại tính năng để thu log thật.
* Bảo nó phân tích log theo timeline, không phân tích code “chay”.

Thực tế, trong nhiều case khó, Agent tìm ra nguyên nhân nhanh hơn cả con người — đơn giản vì nó vừa đọc log, vừa hiểu code, vừa không mệt như anh em mình (con người thay đổi theo tâm trạng).

# 3. Cursor Debug Mode: tự động hoá quá trình debug mà dev luôn làm
![image.png](https://images.viblo.asia/0de1ab90-1ae0-48fb-98b5-03a5f653e89e.png)

Cursor lần này giới thiệu Debug Mode, và điểm hay của nó là tư tưởng rất quen thuộc:
> Agent sẽ trực tiếp thêm log → chạy lại code → đọc log → reason ra nguyên nhân.

Tức là Agent không chỉ đoán bug dựa trên code, mà nó sẽ:
* Inject log vào nơi cần thiết 
* Tự thực thi lại chức năng
* Lấy log runtime về
* Dùng log đó để tìm ra bug một cách logic

Điều này giống như có một “đồng đội debug” luôn sẵn sàng làm những việc nhàm chán và lặp lại mà dev vốn không thích.

Đặc biệt:
### Sau khi fix xong, chỉ cần một nút để xoá toàn bộ log mà Agent đã thêm. Không còn cảnh phải dọn dẹp hàng chục dòng log test khắp codebase.

# 4. Lợi ích thực tế cho team dev
**Giảm thời gian debug nhiều lần**
Thay vì tự thêm – chạy – đọc – xoá từng phần, Agent làm trọn vòng lặp đó.

**Tăng độ chính xác**
Phân tích dựa trên runtime log giúp Agent tránh sai lầm do hiểu sai code.

**Không để lại “rác” trong code**
Debug Mode cleanup khá triệt để.

**Giữ được tư duy debug chuẩn**
Quan trọng nhất: nó không thay đổi tư duy dev.
Chỉ thay đổi công cụ và người thực thi.

# 5. Tương lai của debug với AI
Debug Mode của Cursor là một bước quan trọng:
AI Agent bắt đầu chuyển từ hỗ trợ lập trình sang tham gia trực tiếp vào vòng lặp runtime.

Từ đây về sau, một vòng debug hiệu quả sẽ trông như sau:
1. Dev mô tả issue
2. Agent tự phân tích codebase
3. Agent tự thêm log
4. Agent tự chạy lại
5. Agent tự đọc log
6. Agent đề xuất fix
7. Dev review và approve

Dev giữ vai trò reviewer, còn Agent là người chạy việc.

# 6. Kết luận
**Debug Mode** không phải bước ngoặt lớn về lý thuyết.
Nó đơn giản chỉ mang tư duy debug truyền thống lên một cấp độ tự động hơn, nhanh hơn và thống nhất hơn.

Trong thực tế dự án, đặc biệt là codebase lớn, nhiều service, nhiều flow phức tạp, việc giảm được 30–50% thời gian debug là cực kỳ đáng giá.


Link: https://cursor.com/blog/debug-mode