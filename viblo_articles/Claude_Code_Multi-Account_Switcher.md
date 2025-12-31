# Claude Code Multi-Account Switcher

Chữa cháy khi Claude hết usage giữa chừng (mà không mất context)

## Câu chuyện bắt đầu từ một nỗi bực 
Mình có nhiều tài khoản Claude Code để làm việc.

Lý do thì đơn giản: usage có hạn, task thì dài, context thì sâu.

Vấn đề là thế này:
- Đang code dở
- Đang debug một flow khó
- Đang đi được 70–80% suy nghĩ

**Claude hết usage -> bùm**

**Giải pháp “truyền thống”:**
- Logout
- Login account khác
- Mở lại claude
- Mất context
- Không resume được session cũ
- Mất thời gian, mất cảm xúc, mất mạch suy nghĩ (haha)

## Làm sao để resume session cũ với account mới ?
Claude Code có một feature rất hay:
> claude --resume

- Resume lại conversation history
- Nhưng chỉ hoạt động trong cùng một account

Vậy câu hỏi đặt ra:
> Nếu mình sync được conversation history giữa các account thì sao?

## Ý tưởng giải pháp
**Xây dựng bash script các chức năng này để dùng cho tiện, login 1 lần dùng lâu dài giữa các account**

- Dùng nhiều account Claude Code
- Switch account cực nhanh
- Không mất context
- claude --resume hoạt động ở mọi account
- Không đụng chạm token của nhau (an toàn)


Và mình đã build -> [Claude Code Multi-Account Switcher](https://github.com/longnd-vnlab/claude-code-multi-account-switch)


## Claude Code Multi-Account Switcher là gì?
![image.png](https://images.viblo.asia/f8de2326-b8ea-4c8d-aeae-a9d093d63e10.png)

Một bộ bash + python script giúp bạn:

- Lưu nhiều account Claude Code
- Switch qua lại chỉ bằng 1 lệnh
- Xem usage của tất cả account
- Sync conversation history giữa các account
- Resume session liền mạch, không đứt mạch tư duy


## Cài đặt (1 phút là xong)

Clone source: https://github.com/longnd-vnlab/claude-code-multi-account-switch

```
./init.sh
source ~/.bashrc
```

Script sẽ tự tạo alias cho bạn:

| Alias           | Thực chất là              |
| --------------- | ------------------------- |
| `claude-switch` | `claude-switch.sh`        |
| `claude-sync`   | `claude-sync.sh`          |
| `claude-next`   | `claude-next.sh`          |
| `claude-usage`  | `python3 claude-usage.py` |


**Sau đó có thể chạy ở bất kỳ thư mục nào**

## Cách dùng cơ bản

**Lưu account**

```
claude login
claude-switch save work
```


Sau đó logout ra -> login tài khoản khác rồi lại:

```
claude-switch save research
```

**Switch account**

```
claude-switch work
claude-switch personal
```

Không cần login lại.
Token được quản lý riêng cho từng account.


Các lệnh tiện ích khác
```
claude-switch list      # Danh sách account
claude-switch status    # Account hiện tại
claude-next             # Switch vòng tròn (round-robin)
claude-usage            # Xem usage tất cả account
```
![image.png](https://images.viblo.asia/4263e279-1599-44d5-838f-f03f8dd9c901.png)

## Feature mình thích nhất: Sync session
```
claude-sync
```

- Sync conversation history giữa tất cả account
- Không sync token
- Không ảnh hưởng bảo mật

**Workflow thực tế**

```
# Làm việc với account1
claude-switch account1
claude

# Sync session
claude-sync

# Chuyển sang account2
claude-switch account2
claude --resume
```

- Resume đúng session đang làm
- Claude hiểu toàn bộ context trước đó
- Não không bị reset

## Tổng kết

Đây không phải là tool “cao siêu”, nó chỉ giải quyết usecase sử dụng của mình, hi vọng hữu ích với mọi người !