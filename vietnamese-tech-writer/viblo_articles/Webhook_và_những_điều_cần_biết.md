# Webhook và những điều cần biết

## Tình huống
Chắc mọi người ai đã từng tích hợp các chức năng thanh toán vào hệ thống của mình thì đều đã biết đến **WEBHOOK** rồi nhỉ, giả sử:

Trong quy trình xử lý đơn hàng của một website thương mại điện tử, khi khách hàng đặt hàng, dữ liệu sẽ được gửi từ  **API Gateway** đến **Order Service**. Sau đó chuyển tiếp đến **Payment Service** để thực hiện thanh toán.  Đây là lúc **Payment Service Provider (PSP)**  (ví dụ: Stripe, PayPal, Adyen, GMO) bắt đầu tham gia.

![image.png](https://images.viblo.asia/c70f1f7e-7843-4125-8358-fccd20dd6c0e.png)

**Vậy có những cách nào để Stripe, giao tiếp được với website của mình để xác nhận thanh toán, gửi thông báo trạng thái giao dịch ?**

### 1. Short polling:
Hiểu đơn giản là **Payment Service** (hệ thống của mình) sẽ hỏi liên tục **STRIPE** là giao dịch này sao rồi, xong chưa e ey, giờ sao...
**Payment service** sẽ kiểm tra liên tục cho đến khi nhận được kết quả xác nhận.

![image.png](https://images.viblo.asia/f422b5b7-7c1d-4f5f-a51c-d814de0b430d.png)

Tuy nhiên, mọi người có thể thấy rằng, short polling tiêu tốn tài nguyên vì phải gửi request liên tục.

### 2. Long polling
Long polling là phiên bản kiên nhẫn hơn của short polling. Thay vì hỏi liên tục, server giữ yêu cầu mở kết nối và chỉ phản hồi khi có thông tin mới. 
![image.png](https://images.viblo.asia/acbfca0f-2766-4adb-9101-096b2ed0225b.png)

Long polling giúp giảm số lần request liên tục như short polling, nhưng vẫn có nhược điểm là server phải giữ kết nối mở, dẫn đến tốn tài nguyên, đặc biệt khi có nhiều client kết nối cùng lúc.

### 3. Webhooks
Thay vì yêu cầu Stripe liên tục để hỏi kết quả như short polling hay long polling, thì chúng ta sẽ cung cấp cho Stripe 1 URL và nói nó " gửi kết quả qua cái URL này cho tôi khi có kết quả nhé !!!"
Khi thanh toán hoàn tất, Stripe sẽ tự động gửi dữ liệu về cái URL này cho hệ thống bên mình để xử lý kết quả thanh toán. 
![image.png](https://images.viblo.asia/524c4438-6fea-4cb3-87ed-02ee0f238a82.png)

Yeah, giờ thì không còn lãng phí tài nguyên nữa rồi.

### 4. Webhooks kết hợp với polling (Failover):
Trong 1 hệ thống để đảm bảo an toàn, thì làm gì cũng cần và nên có cơ chế Failover (dự phòng). Trong trường hợp server webhook không phản hồi, sử dụng polling định kỳ để đảm bảo không bỏ lỡ các cập nhật quan trọng.

![image.png](https://images.viblo.asia/18ea9d0c-cfda-4c76-a2aa-e3afb836e853.png)

### 5. Một số kinh nghiệm khi sử dụng webhook:


#### Tính Idempotency:
Tự đặt câu hỏi: Khi webhook được gọi nhiều lần cho cùng 1 giao dịch thì có ảnh hưởng gì đến dữ liệu của hệ thống không ?

Đây được gọi là tính **Idempotency**, Webhook có thể được gửi nhiều lần do lỗi mạng, retry từ phía sender hoặc mất kết nối. Do đó, cần đảm bảo rằng:

- Chỉ xử lý một lần duy nhất hoặc dù được gọi nhiều lần thì kết quả vẫn không thay đổi.
- Sử dụng ID/token để phân biệt từng request.

![image.png](https://images.viblo.asia/c56169d4-610d-474c-8edd-e33e57001048.png)

Đây là kỹ thuật khá quan trọng, thông thường các Payment Gateway thường dùng để tránh việc **Duplicate Payment**

Mọi người có thể tham khảo [bài viết này](https://medium.com/@sahintalha1/the-way-psps-such-as-paypal-stripe-and-adyen-prevent-duplicate-payment-idempotency-keys-615845c185bf), mình thấy khá hay 💯

**BÀI HỌC KINH NGHIỆM:**

Mình cũng đã từng làm việc với [GMO PAYMENT GATEWAY](https://www.gmo-pg.com/en/) VÀ [PAIDY](https://paidy.com/), cũng sử dụng webhook nhận kết quả giao dịch để xử lý, đã gặp trường hợp webhook được gọi duplicate nhiều lần và bùm... 
Không may là bên mình đặt logic gửi mail cho người dùng ở trong webhook nên xảy ra hiện tưởng gửi mail duplicate nhiều lần (sad) và còn có một số issue khác về lưu lượng lớn nên các bạn chú ý xử lý logic cho hợp lý ở trong webhook này nhé.


#### Bảo mật 

- Chỉ chấp nhận các request có token xác thực hoặc chữ ký bí mật (HMAC) để đảm bảo request đến từ nguồn hợp lệ.
- Sử dụng HTTPS để mã hóa dữ liệu truyền tải, tránh bị tấn công trung gian (MITM).
- Chỉ cho phép IP đến từ Payment Gateway access vào WEBHOOK URL

![image.png](https://images.viblo.asia/4f97cd6b-77fc-44cc-85bd-7daa4dfd08c9.png)


#### Xử lý lưu lượng lớn:
Nếu trang web của bạn có lượng truy cập cao, hãy chuẩn bị hạ tầng để đối phó với đợt tăng đột biến lưu lượng webhook bằng cách:

- Sử dụng Queue để tách biệt việc nhận và xử lý sự kiện
- Ghi lại tất cả request webhook để dễ dàng debug khi có lỗi xảy ra.

![image.png](https://images.viblo.asia/843b073e-5483-496b-be17-816598153ec6.png)

**Nguồn:**  https://www.youtube.com/watch?v=x_jjhcDrISk