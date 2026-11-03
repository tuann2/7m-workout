# Workout tự tạo, lịch sử và dữ liệu cá nhân

Trạng thái: bản nháp chờ duyệt (M0). Các giới hạn đánh dấu "(đề xuất)" cần được duyệt.

Mọi dữ liệu trong tài liệu này chỉ nằm trên máy ([quyết định 0002](../decisions/0002-offline-no-accounts.md)).

## Thích và không thích

- Mỗi bài tập ở một trong ba trạng thái: thích, không thích, bình thường. Mặc định là bình thường.
- Người dùng đặt trạng thái ngay trong lúc tập, hoặc trong thư viện bài tập.
- Có một màn hình liệt kê các bài đang được thích hoặc không thích để đổi lại.
- Trạng thái này ảnh hưởng tới Smart Workout ([smart-workout.md](smart-workout.md)). Nó không thay đổi các workout soạn sẵn hay workout tự tạo.

## Workout tự tạo

- Tạo mới từ đầu, hoặc nhân bản từ một workout soạn sẵn rồi sửa.
- Chọn bài từ thư viện, có lọc theo nhóm cơ và mức khó. Một bài được xuất hiện nhiều lần.
- Sắp lại thứ tự bằng cách kéo thả.
- Giới hạn: 1–36 bài, 1–3 vòng, nghỉ 5, 10 hoặc 15 giây, tên dài 1–40 ký tự (đề xuất).
- Màn hình tạo workout hiện thời lượng tính theo công thức ở [workout-player.md](workout-player.md).
- Sửa và xoá được. Xoá có hỏi lại. Lịch sử các buổi đã tập với workout đó vẫn giữ nguyên.
- Nếu bản cập nhật app gỡ một bài khỏi catalog, workout tự tạo chứa bài đó được đánh dấu cần sửa và không chạy được cho tới khi người dùng sửa.

## Lịch sử

- Danh sách buổi tập, mới nhất ở trên, gồm tên workout, ngày giờ, thời gian tập, số hiệp đã xong trên tổng số, trạng thái hoàn thành hay bỏ dở.
- Lịch tháng đánh dấu những ngày có ít nhất một buổi hoàn thành.
- Chuỗi ngày tập: số ngày liên tiếp có ít nhất một buổi hoàn thành, tính theo ngày lịch ở múi giờ hiện tại của máy. Hôm nay chưa tập thì chuỗi vẫn giữ tới hết ngày.
- Tổng số buổi và tổng số phút tập trong tuần hiện tại.
- Lịch sử cấp thể lực: các lần đổi cấp với thời điểm và lý do.
- Xoá được từng buổi khỏi lịch sử, có hỏi lại.

## Sao lưu, xuất và nhập

- Dữ liệu được đưa vào bản sao lưu tự động của hệ điều hành: Android Auto Backup và bản sao lưu iCloud của thiết bị.
- Xuất toàn bộ dữ liệu ra một file JSON. Định dạng file giống nhau trên hai nền tảng và có trường `formatVersion`, nhờ đó chuyển được dữ liệu giữa Android và iPhone.
- Nhập từ file: gộp vào dữ liệu đang có, bỏ qua các bản ghi đã tồn tại (so theo id) (đề xuất).
- Định dạng chi tiết của file được viết ở M5.

## Cài đặt

| Cài đặt | Mặc định |
|---|---|
| Ngôn ngữ: theo hệ thống, Tiếng Việt, English | Theo hệ thống |
| Giọng đọc | Bật |
| Câu cổ vũ | Bật |
| Tiếng bíp | Bật |
| Giữ màn hình sáng khi tập | Bật |
| Thời gian nghỉ mặc định cho workout tự tạo | 10 giây |
| Cấp thể lực | Cấp đã chọn lần đầu |
| Nhắc lịch | Tắt ([reminders.md](reminders.md)) |
| Xuất và nhập dữ liệu | — |
| Giới thiệu: phiên bản, nguồn phương pháp, giấy phép, khuyến cáo an toàn | — |
