# Làm thế nào để lưu mật khẩu vào Database một cách an toàn ?

Khi làm việc trên cms ecommerce, mới đầu nhìn vào field salt ở bảng users mình cũng chưa biết mục đích để làm gì, nếu bạn cũng không biết giống mình thì đọc hết bài nha hehe
![image.png](https://images.viblo.asia/e6a710c4-fecc-4727-84d6-d34187225355.png)

# Lưu mật khẩu thế nào cho an toàn:
### Không lưu mật khẩu dưới dạng tường minh

Khi lưu mật khẩu vào database một trong những điều quan trọng nhất là tránh lưu mật khẩu người dùng vào database một cách tường minh tránh việc database bị leak, hacker có thể chiếm quyền sử dụng của người dùng ngay lập tức hoặc bất cứ ai có quyền vào Database đều xem được mật khẩu của người dùng là rất nhạy cảm.
    
Vậy cần làm gì để lưu mật khẩu vào Database một cách an toàn mà cho dù Database có bị leak thì hacker cũng không thể chiếm quyền sử dụng của người dùng được, **Open Web Application Security Project (OWASP)** cung cấp cho chúng ta một số hướng dẫn làm sao để lưu mật khẩu. Một số cách như sau:
    
### Dùng thuật toán hash một chiều để hash mật khẩu rồi lưu vào database

![image.png](https://images.viblo.asia/8fb48a4d-56c9-47dc-acd3-744a123b5d9d.png)

Hash là hàm một chiều. Nghĩa là cho dù hacker có chiếm được mật khẩu đã hash thì cũng khó có thể giải mã ra được mật khẩu gốc.

Quan trọng là phải dùng các thuật toán hash hiện đại, nhưng sẽ tốn nhiều tài nguyên hơn để tính giá trị hash, gây khó khăn cho việc giải mã ra được mật khẩu gốc, điển hình là **bcrypt**

Mọi người thường hay thấy các thuật toán mã hóa một chiều nhanh, phổ biến nhưng dễ bị hacker giải mã ra mật khẩu gốc như **md5, SHA-1**

### Tại sao cần kết hợp thêm chuỗi Salt khi hash mật khẩu cho an toàn hơn ?

![image.png](https://images.viblo.asia/30f157cf-2383-4b35-91c4-08d550b6fcf4.png)

**Salt** là một chuỗi được sinh ngẫu nhiên và được kết hợp với mật khẩu trong quá trình hash giúp mã hash riêng biệt và bảo mật hơn nhiều, vì lưu mật khẩu theo dạng hash là điều kiện cần, nhưng chưa phải điều kiện đủ. Kẻ tấn công có thể bẻ được hash một chiều với các giá trị tính trước **(Rainbow Table)**, tấn công Brute Force. Cụ thể:

**Chống tấn công Rainbow Table**

**Rainbow Table** là một bảng băm chứa hàng triệu giá trị hash được tính trước tương ứng với nhiều mật khẩu phổ biến, hacker sẽ lợi dụng để tra ra mật khẩu gốc, khi thêm **salt** thì mật khẩu sẽ hash ra một giá trị hash riêng biệt, bảo mật hơn rất nhiều khó có thể tồn tại trong **Rainbow Table**.

![image.png](https://images.viblo.asia/f6fe4fd3-3b03-44a6-8d6b-cdbf2a50decd.png)


**Chống tấn công Bruteforce:**

Nếu không dùng Salt, kẻ tấn công có thể dùng cùng một bảng hash để thử nghiệm trên nhiều tài khoản nếu như 2 tài khoản có cùng mật khẩu chẳng hạn.

Giả 2 user có cùng mật khẩu rất yếu, hệ thống chỉ dùng hash 1 chiều mà không kết hợp salt, hacker đã bruteforce trước mã hash này thuộc về mật khẩu 123456
```
user1 password: e10adc3949ba59abbe56e057f20f883e <- hash(123456)
user2 password: e10adc3949ba59abbe56e057f20f883e <- hash(123456)
```

Từ đó hacker có thể dễ dàng phát hiện ra mật khẩu gốc.

**Nếu kết hợp thêm salt để hash thì sao ?**

Nếu kết hợp thêm Salt, giá trị hash của mật khẩu sẽ khác nhau ngay cả khi mật khẩu gốc giống nhau. Điều này khiến hacker không thể dùng cùng một bảng hash để dò tìm mật khẩu trên nhiều tài khoản.

```
Salt: abc987
Hash: md5(abc987123456) -> 5b82c88e4e79527ec6e7b63e3f33d84a

Salt: 123xxx
Hash: md5(123xxx123456) -> b2efa66d6c51eb05d5183fec2e7e6a42
```

Cùng 1 password **123456** nhưng khi kết hợp thêm chuỗi **salt** thì mã hash sẽ khác nhau, hacker khó có thể tìm ra mật khẩu gốc.

**Kết luận**

Thêm Salt giúp bảo mật hơn vì mỗi mật khẩu sẽ có một hash duy nhất, khiến hacker không thể tái sử dụng bảng hash có sẵn hoặc tấn công hàng loạt.

Kết hợp với thuật toán hash mạnh như bcrypt hoặc Argon2 sẽ càng làm cho brute-force khó khăn hơn. 
## Lưu mật khẩu với salt vào database thế nào ?
![image.png](https://images.viblo.asia/fad07559-28f9-49c4-96e4-33180a6e2e69.png)

Đầu tiên thì cần tạo ra 1 chuỗi salt random, càng bảo mật càng tốt.

Sau đó hash password với mã salt này.

Cái hash này sẽ được lưu vào database cùng với salt. Lưu ý rằng salt được dùng để tạo hash duy nhất. Nó không phải là xâu bí mật gì cả và có thể lưu dưới dạng tường minh trong database.

## Xác nhận mật khẩu khi user login thế nào ?
![image.png](https://images.viblo.asia/4da433b0-c097-437b-84e8-068831397c83.png)

Khi user nhập mật khẩu, nhấn đăng nhập, ta sẽ lấy salt từ database của user. Sau đó ta thêm salt vào sau mật khẩu mà user nhập vào, sau đó hash xâu kết quả. So sánh kết quả này với hash lưu trong database. Nếu giống nhau thì mật khẩu nhập vào là chính xác.

Nguồn: https://www.youtube.com/watch?v=zt8Cocdy15c