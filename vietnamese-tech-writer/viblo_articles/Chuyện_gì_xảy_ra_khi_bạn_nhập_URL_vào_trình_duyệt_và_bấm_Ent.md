# Chuyện gì xảy ra khi bạn nhập URL vào trình duyệt và bấm Enter

## URL là gì?

URL, hay tên đầy đủ là Universal Resources Locator, bao gồm 4 phần. Ví dụ với URL sau:

![image.png](https://images.viblo.asia/00d78745-60a4-415d-8b3f-841e671124e5.png)

**Ở đây:**

🔹 **scheme** - http://. cho browser biết rằng ta sẽ kết nối tới server bằng bằng giao thức trong scheme. Một scheme phổ biến khác là HTTPS, kết nối đến server sẽ được mã hóa.

🔹 **domain** - example.com.  Tên miền của website

🔹 **path** - product/electric.  Đây là path trên server để chúng ta muốn lấy resource nào đó

🔹 **resource** - phone. Tên của resource mà chúng ta muốn lấy.

**Path và Resource** thường không có sự khác biệt rõ ràng. Chúng ta có thể xem chúng lần lượt là thư mục và tập tin trong một ổ cứng. Chúng kết hợp với nhau tạo thành tài nguyên và ta muốn tải về trình duyệt.

## DNS là gì?

**Domain Name System** 

Là hệ thống phân giải tên miền được xem như là cuốn danh bạ trên internet, DNS đơn giản là giúp trình duyệt phân giải từ tên miền thành địa chỉ IP để trình duyệt request đến đúng server cần lấy tài nguyên.

Thường thì tên miền và địa chỉ ip sẽ được cached trên trình duyệt hoặc hệ điều hành một khoảng thời gian sau khi chúng ta truy cập thành công vào URL, để khi chúng ta nhập URL trên trình duyệt sẽ lấy được ip nhanh hơn nhiều.
 
 À thêm một cái nữa mà chắc anh em cũng từng thấy khi trỏ domain về server là một số DNS RECORD TYPES, có thể một số anh em sẽ chưa hiểu rõ ý nghĩa nên mình note lại luôn:
 ![image.png](https://images.viblo.asia/9cb28c9d-42c0-4ba1-9a54-f5b9797f6031.png)
 
🔹 **A (Address) Record**
 Ánh xạ một tên miền tới một địa chỉ IPv4.

🔹 **CNAME (Canonical Name) Record**
Alias một tên miền này tới một tên miền khác, thường được sử dụng cho các tên miền phụ (subdomains), trỏ chúng đến tên miền chính mà không để lộ tên miền thực.

🔹**AAAA Record**
Tương tự bản ghi A, nhưng ánh xạ một tên miền tới một địa chỉ IPv6.

🔹**PTR Record**
Cung cấp tra cứu DNS ngược (reverse DNS lookup), ánh xạ một địa chỉ IP về một tên miền được sử dụng để xác minh tính xác thực của server.

🔹**MX (Mail Exchange) Record**: 
Chuyển hướng lưu lượng email tới đúng máy chủ thư điện tử (mail server) để đảm bảo email được gửi đến đúng nơi nói ngắn gọn là xác định server nhận email.

🔹**NS (Name Server) Record**
Chỉ định các máy chủ DNS có thẩm quyền cho tên miền, giúp định tuyến các truy vấn DNS đến đúng máy chủ DNS để tra cứu.

🔹**TXT (Text) Record**
Cho phép quản trị viên thêm văn bản dễ đọc vào các bản ghi DNS được sử dụng để thêm các bản ghi xác minh, như SPF, để tăng cường bảo mật email.

## Vậy chuyện gì sẽ xảy ra khi truy cập vào một đường dẫn (URL) trên trình duyệt?
![image.png](https://images.viblo.asia/2e782497-d235-4f56-b973-31c1d6cb6a99.png)

**Bước 1:** 
Khi người dùng nhập 1 URL vào trình duyệt vào nhấn ENTER

**Bước 2:** 
Sau đó trình duyệt sẽ tìm trong cache của nó xem địa chỉ này đã có chưa để lấy IP nếu chưa thì bước tiếp theo trình duyệt tiếp tục hỏi cache của hệ điều hành để tìm IP của địa chỉ này, nếu vẫn chưa có thì:

Trình duyệt sẽ gửi truy vấn lên DNS Resolver để tìm ra địa chỉ IP. 
DNS Resolver sẽ tìm trong các DNS Server trên internet để giúp trình duyệt tìm IP. 
Lưu ý là mỗi yêu cầu trong chuỗi các yêu cầu đều được cached lại nhằm giúp cho DNS Resolver cũng như các DNS Server thuận tiện hơn cho những lần tìm kiếm tiếp theo.

**Bước 3:** 
Sau bước 2, giờ ta đã có địa chỉ IP của URL. 
Trình duyệt lúc này sẽ tạo ra một kết nối TCP đến server ứng với địa chỉ IP này. 
Quá trình bắt tay giữa trình duyệt và server cũng sẽ xảy ra ở đây (thường là bắt tay 3 bước). 
Để giúp cho việc kết nối diễn ra nhanh hơn, các trình duyệt ngày nay dùng một thứ gọi là kết nối keep-alive để sử dụng lại kết nối TCP đã được tạo nhiều nhất có thể.

**Bước 4:** 
Trình duyệt gửi HTTP request lên server với kết nối TCP trước đó. HTTP là một giao thức khá đơn giản. Server xử lý request và trả về response.

**Bước 5:** 
Trình duyệt nhận response và render HTML content cho chúng ta.

Nguồn: https://www.youtube.com/watch?v=AlkDbnbv7dk