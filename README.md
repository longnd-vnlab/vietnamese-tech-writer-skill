# Vietnamese Tech Writer Skill

Agent skill để viết bài technical blog tiếng Việt theo style tự nhiên!

## Tính năng

**Core Features:**
- Style LongDNA đặc trưng - tone thân thiện như đang chat với đồng nghiệp
- Ví von đời thường để giải thích concept kỹ thuật
- Quy trình research chuyên nghiệp với MCP tools
- Template chuẩn cho 5 loại bài viết

**Mới trong v2.0:**
- SEO Guidelines: Title, meta, keywords, heading structure
- Image Sourcing: Quy trình tìm và verify hình minh họa
- Code Quality: Verification checklist, security check
- Fact-Checking: Cross-reference từ nhiều nguồn
- Quality Gate: 23 checkpoints bắt buộc trước publish
- Article Templates chi tiết trong `TEMPLATES.md`:
  - Tutorial / How-To Guide
  - Concept Explanation / Deep Dive
  - Listicle / Top N Tools
  - Troubleshooting / Debugging
  - Case Study / Project Breakdown

## Cấu trúc

```
└── vietnamese-tech-writer/
    ├── SKILL.md          # Định nghĩa skill chính với 14 sections
    ├── TEMPLATES.md      # 5 templates chi tiết cho các loại bài viết
    ├── EXAMPLES.md       # Ví dụ về style và patterns
    └── viblo_articles/   # 29 bài viết mẫu thực tế
```

### Files Chi Tiết

**SKILL.md** - 680+ dòng hướng dẫn chi tiết:
- Style guide đặc trưng (mở đầu, ví von, tone of voice)
- Deep research workflow (6 bước với MCP tools)
- SEO guidelines (8 subsections)
- Code quality standards
- Fact-checking workflow
- Quality gate enforcement (23 checkpoints)
- English mode support

**TEMPLATES.md** - 5 templates production-ready:
- Tutorial với step-by-step structure
- Concept explanation với analogies
- Listicle với comparison table
- Troubleshooting với root cause analysis
- Case study với metrics và lessons

**viblo_articles/** - 29 bài mẫu thực tế covering:
- AWS, Docker, Laravel, PHP
- System Design, Networking
- AI/Claude, Automation
- Database, Security

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
- Code example thực tế, đã verify
- Kinh nghiệm và lesson learn
- Hình minh họa phù hợp, đã verify links
- SEO-optimized với keywords và heading structure

## Quality Standards

Skill này có Pre-Publish Quality Gate với 23 checkpoints:

**Content Quality (8 items):**
- Mở đầu gần gũi với pain point thực tế
- Tối thiểu 2 analogies cho concepts khó
- Tối thiểu 3 hình minh họa (đã verify links)
- Code examples đã verify syntax
- Có section "Kinh nghiệm thực tế"
- Có nguồn tham khảo uy tín
- Tone tự nhiên như chat
- Không có emoji, chỉ text expression

**SEO Quality (6 items):**
- H1 chứa keyword, 50-70 ký tự
- Heading structure rõ ràng (H2, H3)
- Primary keyword xuất hiện đúng chỗ
- Alt text cho tất cả hình
- 2-3 external links uy tín
- Meta description ready

**Technical Accuracy (5 items):**
- Facts được verify với 2+ nguồn
- Code đã test hoặc có disclaimer
- Ghi rõ version/timeline
- Không có security vulnerabilities
- Đã check official docs

**Structure Quality (4 items):**
- Flow logic từ basic tới advanced
- Section balance (100-300 từ/section)
- Conclusion với gợi ý next topics
- Có contact info

## Tác giả

- Telegram: dinhlongit
- Viblo: [LongDNA](https://viblo.asia/u/LongDNA)

## Changelog

**v2.0 (2026-01-01):**
- Thêm SEO guidelines đầy đủ
- Thêm image sourcing workflow với verification
- Thêm code quality standards với security checks
- Thêm fact-checking workflow
- Thêm 23-checkpoint quality gate enforcement
- Tạo TEMPLATES.md với 5 article templates
- Nâng cấp research workflow với MCP tools
- Thêm self-check format cho agents

**v1.0 - Initial Release:**
- Style guide với tone LongDNA
- 29 bài viết mẫu từ Viblo
- Deep research workflow
- English mode support
