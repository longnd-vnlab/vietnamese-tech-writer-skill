# Hiểu về Process vs Thread

# Process vs. Thread: Câu hỏi đến từ vị trí nhà tuyển dụng
Câu hỏi mà không riêng bản thân mình, đây chắc chắn là câu hỏi "quốc dân" trong các buổi phỏng vấn kỹ thuật, vậy bạn đã thực sự hiểu về **process** và **thread** để giải thích cho mọi người một cách dễ hiểu dễ hình dung hơn chưa ? 
Trong bài viết này, chúng ta sẽ cùng tìm hiểu sâu về hai khái niệm này để có câu trả lời chính xác nhất.
# Mọi thứ bắt đầu từ "Chương trình" (Program)
![Screenshot from 2025-10-23 22-35-28.png](https://images.viblo.asia/8f46fbeb-b3ad-44a9-99cb-640ca57216e8.png)

Trước khi nói về Process, ta cần hiểu Program là gì.

```
Một chương trình (program) là một file thực thi (executable file). Nó chứa mã (code) hoặc một tập hợp các hướng dẫn xử lý được lưu trữ dưới dạng một file trên ổ cứng.
```

Khi code trong chương trình đó được tải vào bộ nhớ memory và được CPU thực thi, nó sẽ trở thành một **process**  

Hay nói ví von dễ hiểu hãy tưởng tượng Program (Chương trình) giống như một công thức nấu ăn được cất kỹ trong ngăn kéo, nó chỉ là một file thực thi (<code>.exe</code>, <code>.app</code>,...) chứa một loạt các chỉ dẫn, nằm im lìm trên ổ cứng của bạn và khi bạn quyết định "nấu món ăn" (ví dụ: nhấp đúp vào icon Chrome), hệ điều hành sẽ mang công thức đó ra, chuẩn bị nguyên liệu (bộ nhớ, tài nguyên) và bắt đầu thực thi. Khoảnh khắc "việc nấu ăn" bắt đầu, chương trình đó trở thành một **Process**.

Một **process** đang hoạt động không chỉ chứa code, mà còn bao gồm tất cả các tài nguyên mà chương trình cần để chạy. Các tài nguyên này được quản lý bởi hệ điều hành. Một số ví dụ bao gồm:
![Screenshot from 2025-10-23 22-51-35.png](https://images.viblo.asia/b07446a3-a26a-4108-a0d7-7186738b52d0.png)

-  **Registers (Thanh ghi)**: Các ô nhớ tốc độ cao bên trong CPU dùng để lưu tạm dữ liệu hoặc địa chỉ trong quá trình xử lý.
-  **Bộ đếm chương trình (program counters):** Thanh ghi đặc biệt lưu địa chỉ lệnh kế tiếp sẽ được thực thi.
-  **Con trỏ ngăn xếp (stack pointers)**: Thanh ghi đặc biệt trỏ đến đỉnh của ngăn xếp (stack) trong bộ nhớ.
-  **Các trang bộ nhớ (Memory pages assigned to the process)**: Các trang (pages) trong không gian địa chỉ ảo được hệ điều hành cấp cho tiến trình thường chứa heap, stack, và segment code/dữ liệu.

**Process: Một "Ngôi Nhà" Độc Lập**
- Một Process là một chương trình đang chạy. Khi hệ điều hành tạo ra một process, nó giống như xây một ngôi nhà độc lập cho chương trình đó vậy.
- Nếu mọi người đã học qua môn Kiến trúc máy tính thì có thể xem lại các thành phần này để hiểu rõ hơn nhé, à mà kiến thức này mình nghĩ cũng nên biết...

- Khi một process được tạo ra, hệ điều hành sẽ cấp cho nó một không gian địa chỉ ảo (virtual address space) riêng. Không gian này được chia nhỏ thành các khối có kích thước cố định gọi là (memory pages) — thường là 4KB hoặc 8KB mỗi trang.
- Mỗi page là một phần nhỏ trong không gian bộ nhớ ảo của tiến trình.


**Ví dụ:**
Giả sử process A được cấp không gian địa chỉ ảo 4 GB.
Hệ điều hành sẽ chia nó ra như sau:
- **Code Segment (Text Segment)**: Chứa mã của chương trình (công thức nấu ăn).
- **Data Segment**	Chứa biến toàn cục, biến tĩnh, dữ liệu khởi tạo sẵn (những đồ đạc có sẵn trong nhà).
- **Heap**	Dùng để cấp phát động (malloc, new)  (Nơi bạn "xin" thêm không gian khi cần (ví dụ: new một đối tượng). Giống như một cái kho bạn có thể cơi nới.)
- **Stack**	Dùng cho lời gọi hàm, biến cục bộ (Giống như tờ giấy nháp, bạn dùng xong rồi vứt đi.)
- **Memory-mapped files / shared libs**	các thư viện, file mmap, dùng chung giữa tiến trình
![Screenshot from 2025-10-23 22-52-17.png](https://images.viblo.asia/d591b56d-8e8d-4e63-8579-76f6614a2202.png)
# Tính Cốt lõi của Process (Isolation)
- Như mình đã đề cập phía trên thì mỗi tiến trình có "không gian địa chỉ bộ nhớ (memory address space) riêng của nó.
- Điều này có nghĩa là một tiến trình không thể truy cập hoặc làm hỏng không gian bộ nhớ của một tiến trình khác. Nhờ vậy, khi một tiến trình gặp sự cố các tiến trình khác vẫn tiếp tục chạy bình thường. 
- Trình duyệt Chrome là một ví dụ nổi tiếng về việc tận dụng sự cách ly này. Chrome chạy mỗi tab trong một tiến trình riêng. Khi một tab hoạt động sai—do lỗi hoặc một cuộc tấn công độc hại—các tab khác không bị ảnh hưởng.
![image.png](https://images.viblo.asia/5a7975d0-4a81-4e04-9364-861161e70059.png)
#  Thread là gì?
![Screenshot from 2025-10-23 22-55-54.png](https://images.viblo.asia/2c31ac25-4cb9-439e-8259-bd49dc6c0467.png)
Vậy,  thread là gì? Một thread là đơn vị thực thi (unit of execution) bên trong một process.

```
Nếu Process là "ngôi nhà", thì Thread chính là "người" thực hiện công việc bên trong ngôi nhà đó.
```

Một process luôn có ít nhất một thread (được gọi là main thread). Việc một process có nhiều thread là rất phổ biến.

Mỗi thread đều có ngăn xếp (stack) riêng của mình. Thực tế, khi chúng ta nói về các tài nguyên như thanh ghi, bộ đếm chương trình và con trỏ ngăn xếp, chính xác hơn thì chúng thuộc về một thread.

#  Tính Cốt lõi của Thread: (Sharing)
![Screenshot from 2025-10-23 22-56-49.png](https://images.viblo.asia/c389f737-c4cb-424b-abe8-df4ff617e25a.png)
![image.png](https://images.viblo.asia/5e24e6f9-536d-4295-ab2d-82ad9676eda0.png)
Đây là điểm khác biệt mấu chốt: Các thread bên trong một process chia sẻ chung một không gian địa chỉ bộ nhớ.

- Ưu điểm: Điều này cho phép các thread giao tiếp với nhau một cách dễ dàng bằng cách sử dụng không gian bộ nhớ dùng chung đó.
- Nhược điểm: Một thread hoạt động sai có thể làm sập toàn bộ process.
# Context Switching
![image.png](https://images.viblo.asia/af9244f0-2e97-4a8b-b8d1-6725056c3fef.png)
Nói một cách dễ hiểu về Context Switching:
- CPU của bạn (trên mỗi core) thực ra chỉ làm được một việc tại một thời điểm. Để tạo ra ảo giác "đa nhiệm" (làm nhiều việc cùng lúc), nó phải liên tục "chuyển đổi ngữ cảnh" (Context Switching) – tức là nhảy từ việc này sang việc khác với tốc độ chóng mặt.

**1. Process Context Switch**
Đây là gì: Chuyển từ việc thực thi process A sang process B.
- Tưởng tượng: Bạn phải dọn toàn bộ đồ đạc từ nhà A, đóng gói, lưu vào kho (lưu trạng thái process A). Sau đó, bạn chuyển toàn bộ đồ đạc của nhà B từ kho vào (tải trạng thái process B), bao gồm cả việc thay đổi toàn bộ "bản đồ" (virtual memory pages).
- Chi phí: Cực kỳ tốn kém (expensive) và chậm chạp!

![image.png](https://images.viblo.asia/895f7a6f-f070-4dbe-b3a2-dd037a19215d.png)
![image.png](https://images.viblo.asia/b0073b70-42aa-4c8f-a8ff-a36881a26b07.png)

**2. Thread Context Switch**
- Đây là gì: Chuyển từ thread 1 sang thread 2 bên trong cùng một process.
- Tưởng tượng: Bạn đang ở trong cùng một ngôi nhà. Bạn chỉ cần ngưng nấu ăn (lưu lại giấy nháp/stack của thread 1) và quay sang xem TV (tải giấy nháp/stack của thread 2). Ngôi nhà (không gian bộ nhớ) vẫn y nguyên.
- Chi phí: Nhanh và nhẹ nhàng hơn rất nhiều!
![image.png](https://images.viblo.asia/67558f76-79d6-4d3e-8e85-8d415a55ea6e.png)
![image.png](https://images.viblo.asia/100cb776-27c0-4a31-9e32-c55ca250bc36.png)

# Fibers và Coroutines
**Context Switch** vẫn tốn kém, vì vậy đã có những cơ chế khác được tạo ra để cố gắng giảm thiểu chi phí này, ví dụ như **fibers và coroutines**.

Ngay cả việc chuyển đổi thread (**Thread Context Switch**) vẫn còn chi phí, vì nó cần sự can thiệp của "sếp tổng" là Hệ Điều Hành.
Vì vậy, người ta đã tạo ra các khái niệm "nhẹ" hơn nữa như Fibers và Coroutines. Chúng giống như những "kế hoạch công việc" mà các thread tự thỏa thuận với nhau ("lập lịch hợp tác" - cooperatively scheduled) mà không cần "sếp" chỉ đạo. Chúng tự "nhường" (yield) quyền kiểm soát cho nhau, giúp giảm chi phí chuyển đổi xuống mức tối thiểu.

![image.png](https://images.viblo.asia/1390549c-132b-48b7-bf66-c502b349d82f.png)
![image.png](https://images.viblo.asia/161e91ad-d803-4768-bd41-4994d40300c6.png)

Hy vọng bài viết này đã giúp bạn phân biệt rõ ràng giữa process và thread, còn một khái niệm mà bạn cũng nên cần phải hiểu là **Concurrent và Parallel** trong Programming nữa (nhớ tìm hiểu thêm nhé !)

Source: https://www.youtube.com/watch?v=4rLW7zg21gI