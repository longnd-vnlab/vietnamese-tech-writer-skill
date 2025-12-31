# [AWS Log Insight] Một số patterns và usecase phổ biến sử dụng để filter log hiệu quả trên AWS Log Insight

# Mở đầu:
Khi hệ thống gặp sự cố hoặc cần theo dõi hoạt động, việc truy vết logs là một phần quan trọng trong quá trình điều tra và phân tích. Đặc biệt, nếu hệ thống của bạn đang hoạt động trên nền tảng AWS, việc tích hợp AWS CloudWatch để quản lý logs sẽ là điều cần thiết. Trong bài viết này, chúng ta sẽ tìm hiểu về AWS Log Insights, một tính năng mạnh mẽ của AWS CloudWatch. Cung cấp các công cụ phân tích và filter logs hiệu quả, giúp chúng ta dễ dàng phân tích các issue của hệ thống cũng như nhận định được các issues có thể xảy ra trong tương lai. Trong bài viết này mình sẽ chia sẻ một số patterns và các usecases thường được áp dụng trong quá trình làm việc và điều tra các sự cố trên hệ thống. 

# Một chút kiến thức:
### Cú Pháp Truy Vấn
CloudWatch Logs Insights sử dụng ngôn ngữ truy vấn đặc biệt cho phép ae thực hiện nhiều thao tác như thao tác số học, so sánh, sử dụng regrex và rất nhiều pattern hay ho để filter logs. Cơ bản cú pháp bao gồm:

**Ký tự (|)**: Dùng để kết nối nhiều lệnh trong một truy vấn.

**Chú thích**: Được tiền tố bởi ký tự thăng (#).

### Một số lệnh mà hay dùng:
**filter**: dùng để filter kết quả trả về theo một pattern nào đó.

**limit**: Giới hạn số lượng kết quả trả về.

**sort**: Sort kết quả trả về

Tester vừa vào màn hình homepage thì bị lỗi 5xx không vào được báo cho ông dev check xem lỗi gì, ông cặm cụi vào query thử xem thế nào =))

```
fields @timestamp, @message, @logStream, @log
| filter @message like "ERROR"
| sort @timestamp desc
| limit 10
```

 Truy vấn này được thiết kế để tìm kiếm các logs có chứa từ "ERROR" trong trường @message, sau đó sắp xếp các kết quả theo thời gian giảm dần và giới hạn chỉ hiển thị 10 mục đầu tiên, lựa chọn range time thì có trên màn hình luôn nha hoặc ae có thể dùng.
 
```
 | filter @timestamp between 1627824000000 and 1627910399999
``` 
 ![image.png](https://images.viblo.asia/92ea7d88-3e7a-49b7-a3e5-bbd07baff032.png) 
 
**pattern**: sử dụng để tự động nhóm các log có cấu trúc lặp lại tương tự nhau thành các mẫu (patterns)

Giả sử bạn có các log với nội dung tương tự như sau:
```
ERROR 2024-08-25T12:34:56 Unable to connect to database server at db.example.com
INFO 2024-08-25T12:35:00 User JohnDoe logged in from IP 192.168.1.1
WARN 2024-08-25T12:36:22 Memory usage is at 85% on server web01
INFO 2024-08-25T12:36:45 User JaneDoe logged in from IP 192.168.1.2
ERROR 2024-08-25T12:37:01 Unable to connect to database server at db.example.com
```

Bạn có thể sử dụng lệnh **pattern** để tìm ra các mẫu lặp lại trong những log này như sau:

```
fields @message
| pattern @message /(?<level>[A-Z]+) (?<timestamp>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}) (?<message>.+)/
| display level, timestamp, message
```

  Kết qủa sẽ trả về như sau:
 ![image.png](https://images.viblo.asia/3bd562f2-65d3-4ab2-b7fe-5a209be0e555.png)
 
 **parse**: Trích xuất dữ liệu từ một trường log để tạo trường mới.
 Cái này mình thấy rất hay dùng, ví dụ muốn trích xuất chỉ thông tin nào đó ở trong cái message field dài ngoằng ngèo.
 
 Giả sử bạn có các log như sau:
 ```
INFO 2024-08-25T12:34:56 User JohnDoe logged in from IP 192.168.1.1
ERROR 2024-08-25T12:35:00 Unable to connect to database server at db.example.com
INFO 2024-08-25T12:36:00 User JaneDoe logged in from IP 192.168.1.2
 ```
 
 Bạn muốn truy xuất người dùng nào ứng với ip nào để export ra cho việc điều tra access cho dễ chẳng hạn:
 ```
 fields @message
| parse @message "User * logged in from IP *" as username, ip_address
| display username, ip_address
 ```
 
 Kết quả rất clear đúng không nào:
 ![image.png](https://images.viblo.asia/fa781ca3-17e9-4990-ba29-04e6f6f6c9f5.png)

**stats**: dùng để tính toán, thống kê tổng hợp như count, sum, avg

Lệnh này cũng khá hay dùng nha, phần ở dưới sẽ có 1 usecase dùng lệnh này để ước lượng lưu lượng truy cập của user theo từng giờ chẳng hạn.


### Một số lệnh khác:
**display**: Hiển thị các trường cụ thể trong kết quả truy vấn.

Giả sử bạn có các log với các trường như @timestamp, @message, @logStream, và bạn đã trích xuất được một trường mới username từ @message. Bạn chỉ muốn hiển thị thời gian (@timestamp) và tên người dùng (username).
```
fields @timestamp, @message
| parse @message "User * logged in" as username
| display @timestamp, username
```

**fields**: được sử dụng để chọn và hiển thị các trường cụ thể từ dữ liệu log của bạn.

Giả sử bạn có dữ liệu log bao gồm các trường như @timestamp, @message, @logStream, và bạn chỉ muốn hiển thị thời gian xảy ra sự kiện (@timestamp) và nội dung của thông điệp (@message).
```
fields @timestamp, @message
| sort @timestamp desc
| limit 20
```

**diff** : được sử dụng để so sánh các sự kiện log giữa hai khoảng thời gian khác nhau nhằm tìm ra sự khác biệt hoặc xu hướng thay đổi

Nói nghe khó hiểu quá đi, chỉ có ví dụ mới làm ta mường tượng ra được:

Giả sử bạn có log từ một ứng dụng web và bạn muốn so sánh các lỗi (ERROR) đã xảy ra trong hai khoảng thời gian khác nhau, mỗi khoảng thời gian dài một giờ, để xem có lỗi mới nào xuất hiện trong khoảng thời gian gần đây không. Điều này rất hữu ích khi bạn muốn phát hiện các sự kiện mới xuất hiện hoặc so sánh các log giữa hai thời điểm
```
fields @timestamp, @message
| filter @message like /ERROR/
| diff(@timestamp, 1h)
| sort @timestamp desc
```
Kết quả sẽ hiển thị danh sách các sự kiện log mà chỉ xuất hiện trong khoảng thời gian gần đây mà không xuất hiện trong khoảng thời gian trước đó. Điều này giúp bạn dễ dàng nhận diện các lỗi mới hoặc các sự kiện khác biệt giữa hai khoảng thời gian.

# Một vài usecases:
Trong quá trình làm việc với dự án thực tế, chắc rằng anh em sẽ phải lặn trong đống log để tìm lỗi hoặc dùng log để có thể phân tích một vài issue gì đó, mình cũng vậy, cũng lượm nhặt và đúc kết lại một số query hữu ích để chia sẻ cho mọi người cũng như bookmark lại cho bản thân, để sau cần dùng thì vào lấy dùng cho tiện tay. 

**1. Truy vấn filter theo message lỗi và path (Tìm theo màn hình chứa lỗi):**

```
fields @timestamp, @message
| filter extra.url like /products\/sales/ and @message like /Error/
| sort @timestamp desc
| limit 120
```

**2. Truy vấn tính số request dựa trên path và lấy top 20 path được truy cập nhiều nhất (Dựa trên log group của ELB):**

Query này giúp chúng ta trích xuất được top 20 path được users truy cập nhiều nhất, từ đó đưa ra các chiến lược để marketing cũng như tối ưu tốc độ, UI, UX thu hút users comback lại site.

```
fields @timestamp, @message
| parse @message "request=\"GET *\"" as request
| stats count(*) as num_request by request
| sort num_request desc
| limit 20
```

**3. Truy vấn filter và count request dựa trên path, nhóm theo khoảng thời gian 5 phút (Dựa trên log group của ELB):**

Vào một ngày site của bạn bỗng nhiên bị treo do lượng users truy cập đồng thời vào homepage làm DB tắt thở, bạn muốn xem thời điểm nào users truy cập vào nhiều nhất chẳng hạn, lệnh dưới đây sẽ nhóm số lượng request theo từng giờ, giúp bạn xem được thời điểm nào là request đến site sẽ là cao nhất.

```
filter @message like /homepage/
| stats count(*) as num_request by bin(1h)
| sort num_request desc
```

Chỗ này mọi người có thể count distinct user cho chính xác hơn
```
stats count_distinct(extra.user_id) as num_distinct_user_id by bin(1h)
```

**4. Truy vấn extract slow query từ logs của RDS, tách các parameter rõ ràng và lấy các query SQL có thời gian thực thi > 4 giây:**
Query này để ae extract ra các câu lệnh sql bị slow > 4s

```
parse @message /# Time:\s(?<Time>.*?)\sUser@Host: (?<User>.*)\[.*?\]\s@ \s.(?<Host>.*?). Id: \d*\s# Query_time: (?<Query_time>.*?)\s Lock_time: (?<Lock_time>.*?)\sRows_sent: (?<Rows_sent>.*?)\sRows_examined: (?<Rows_examined>.*?)\s(?<Query>.*)/
| filter User like 'db_user'
| filter Query_time > 4
| sort Query_time desc
```

**5. Truy vấn thống kê số lượng slow query (> 5s) trong mỗi 10 phút:**
Vào một ngày đẹp trời, site bỗng chậm ỳ, bạn loay xem khoảng thời gian nào thì số lượng query bị slow nhiều, đây chính là query sẽ giúp bạn thực hiện điều đó.

```
parse @message /# Time:\s(?<Time>.*?)\sUser@Host: (?<User>.*)\[.*?\]\s@ \s.(?<Host>.*?). Id: \d*\s# Query_time: (?<Query_time>.*?)\s Lock_time: (?<Lock_time>.*?)\sRows_sent: (?<Rows_sent>.*?)\sRows_examined: (?<Rows_examined>.*?)\s(?<Query>.*)/ 
| filter Query_time > 5
| stats count(*) as count_total by bin(10m) as block_time
| sort count_total desc
```

# Tí lưu ý:
Khi filter logs anh em nhớ thu hẹp lại phạm vi thời gian nha, scan càng nhiều logs tốn càng nhiều tiền không đáng có  ạ. Có nhiều anh em chăm chú điều tra logs mà không để ý cái này thì sẽ tốn kha khá xiền không đáng có. Be calm 

# Tổng kết:
AWS CloudWatch Log Insights là một công cụ mạnh mẽ giúp quản lý và phân tích logs một cách hiệu quả. Bằng cách sử dụng các cú pháp và lệnh truy vấn, bạn có thể nhanh chóng phát hiện và xử lý các vấn đề trong hệ thống. Việc nắm vững các pattern và use case sẽ giúp bạn tối ưu hóa quá trình điều tra và giám sát hệ thống. Hi vọng bài viết sẽ có tí hữu ích cho mọi người ạ. Nếu mọi người còn có query nào hay ho thì comment giúp mình để học hỏi thêm nhaaaa <3