# Vietnamese Tech Writer Skill

Agent skill để viết bài technical blog tiếng Việt theo style LongDNA/DinhLongIT.

## Tính năng

- Viết bài công nghệ với tone thân thiện, gần gũi
- Giải thích concept kỹ thuật bằng ví von đời thường
- Tự động research và tìm hình minh họa
- Cấu trúc bài viết chuẩn blog kỹ thuật

## Cấu trúc

```
├── vietnamese-tech-writer/
│   ├── SKILL.md          # Định nghĩa skill chính
│   └── EXAMPLES.md       # Ví dụ về style
└── viblo_articles/       # Bài viết mẫu để tham khảo
```

## Tích hợp

### Claude Code

Copy thư mục `vietnamese-tech-writer` vào `~/.claude/skills/`:

```bash
cp -r vietnamese-tech-writer ~/.claude/skills/
```

### Kiro

Copy thư mục `vietnamese-tech-writer` vào `~/.kiro/skills/`:

```bash
cp -r vietnamese-tech-writer ~/.kiro/skills/
```

### Cursor / Windsurf / Other AI IDEs

Thêm nội dung `SKILL.md` vào rules hoặc system prompt của project.

## Sử dụng

Sau khi tích hợp, yêu cầu agent viết bài:

```
Viết bài về Docker cho người mới bắt đầu
```

Agent sẽ tự động áp dụng style LongDNA với:
- Mở đầu gần gũi, đặt vấn đề thực tế
- Ví von đời thường trước khi giải thích kỹ thuật
- Code example thực tế
- Kinh nghiệm và lesson learn

## Tác giả

- Telegram: dinhlongit
- Viblo: [LongDNA](https://viblo.asia/u/LongDNA)
