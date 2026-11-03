# Tổng quan sản phẩm

Trạng thái: bản nháp chờ chủ repo duyệt (M0). Luật trong `docs/product/` chỉ có hiệu lực sau khi được duyệt.

## Sản phẩm

7M Workout Nt0 là app tập thể dục tại nhà, thay thế cho J&J Official 7 Minute Workout, app đã ngừng hỗ trợ từ năm 2024. Người dùng tập theo các bài circuit ngắn dùng trọng lượng cơ thể: mỗi hiệp 30 giây, nghỉ ngắn giữa các hiệp, có giọng đọc và hình minh hoạ dẫn dắt.

Sản phẩm gồm hai app native trong cùng repo ([quyết định 0001](../decisions/0001-native-ios-and-android-apps.md)). Hai app phải hành xử giống nhau theo các tài liệu trong thư mục này.

## Nguyên tắc

- **Chạy hoàn toàn offline.** App Android không xin quyền `INTERNET`. App iOS không có code gọi mạng. Mọi nội dung đều đóng gói sẵn trong app ([quyết định 0002](../decisions/0002-offline-no-accounts.md)).
- **Không tài khoản, không thu dữ liệu.** Không có đăng nhập, analytics hay quảng cáo. Dữ liệu người dùng chỉ nằm trên máy và trong bản sao lưu của hệ điều hành.
- **Miễn phí.** Không bán gì trong app.
- **Hai ngôn ngữ.** Giao diện và giọng đọc có tiếng Việt và tiếng Anh. Mặc định theo ngôn ngữ hệ thống: máy đặt tiếng Việt thì dùng tiếng Việt, còn lại dùng tiếng Anh. Người dùng đổi được trong cài đặt.
- **Tên hiển thị** là "7M Workout Nt0". Bundle id là `vn.io.nt0.sevenminworkout` trên cả hai nền tảng.
- **An toàn.** Lần đầu mở app, người dùng thấy khuyến cáo nên hỏi ý kiến bác sĩ trước khi bắt đầu tập. Người dùng phải bấm xác nhận thì mới vào được app. Bài nào cũng có mô tả kỹ thuật.
- **Mã nguồn mở.** Giấy phép Apache 2.0, phát hành qua GitHub ([quyết định 0005](../decisions/0005-public-github-releases.md)).

## Chức năng v1

| Chức năng | Tài liệu |
|---|---|
| 22 workout soạn sẵn, 72 bài tập, mẫu Smart Workout | [catalog.md](catalog.md) |
| Trình phát: đếm giờ, minh hoạ, giọng đọc, bíp, đổi bên, khởi động, giãn cơ | [workout-player.md](workout-player.md) |
| Cấp thể lực, Smart Workout, phản hồi sau buổi tập, gợi ý đổi cấp | [smart-workout.md](smart-workout.md) |
| Workout tự tạo, lịch sử, thích/không thích, sao lưu, cài đặt | [personal-data.md](personal-data.md) |
| Nhắc lịch tập, nhắc khi lâu không tập | [reminders.md](reminders.md) |
| Minh hoạ 3D, giọng đọc, nguồn gốc nội dung | [content.md](content.md) |

## Ngoài phạm vi v1

- Google Play và App Store. Sẽ làm khi có tài khoản.
- Health Connect, HealthKit, Wear OS, Apple Watch, Live Activity.
- Chế độ không nhảy và tuỳ chỉnh độ dài hiệp. Hai tính năng này để v1.1; catalog đã có sẵn cờ `impact` cho việc này.
- Trình phát nhạc trong app, tài khoản, đồng bộ qua server, mức động lực.
- Chuyển dữ liệu từ app J&J cũ.

## Nguồn nội dung

Không dùng lại tài sản nào của J&J ([quyết định 0003](../decisions/0003-content-sources-and-copyright.md)). Phương pháp 7 Minute Workout và 12 động tác gốc lấy từ bài báo của Klika và Jordan trên ACSM's Health & Fitness Journal (2013); app ghi nguồn này trong màn hình giới thiệu.
