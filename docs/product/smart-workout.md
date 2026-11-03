# Cấp thể lực và Smart Workout

Trạng thái: bản nháp chờ duyệt (M0). Thuật toán bên dưới là đề xuất; cấu trúc mẫu lấy từ dữ liệu chức năng của app gốc.

## Cấp thể lực

Có 5 cấp:

| Cấp | Tên | Mô tả hiện cho người dùng |
|---|---|---|
| 1 | Người mới | Mới bắt đầu tập đều đặn |
| 2 | Người mới+ | Đã có chút sức bền, muốn tiến bộ nhanh hơn |
| 3 | Trung bình | Tập thường xuyên, muốn tăng cường độ |
| 4 | Trung bình+ | Sẵn sàng cho bài cường độ cao và động tác khó |
| 5 | Nâng cao | Muốn bài khó nhất, cường độ cao nhất |

Lần đầu mở app, sau màn hình khuyến cáo an toàn, người dùng chọn cấp. Cấp 1 được chọn sẵn. Người dùng đổi cấp được bất cứ lúc nào trong cài đặt.

## Mẫu Smart Workout

Catalog có 19 mẫu ([catalog.md](catalog.md)). Mỗi mẫu thuộc một cấp và quy định số vòng, thời gian nghỉ và số bài dễ, vừa, khó trong 12 bài:

| Cấp | Dễ / vừa / khó | Số mẫu |
|---|---|---|
| 1 | 9 / 3 / 0 | 4 |
| 2 | 6 / 6 / 0 | 3 |
| 3 | 4 / 4 / 4 | 3 |
| 4 | 0 / 6 / 6 | 5 |
| 5 | 0 / 3 / 9 | 4 |

## Cách sinh một Smart Workout

1. **Chọn mẫu.** Lần lượt xoay vòng qua các mẫu của cấp hiện tại theo thứ tự id. Đổi cấp thì bắt đầu lại từ mẫu đầu tiên của cấp mới.
2. **Xếp 12 vị trí** theo thứ tự nhóm cơ toàn thân, thân dưới, thân trên, core, lặp 3 lần.
3. **Gán mức khó.** Lập danh sách mức khó theo số lượng của mẫu, sắp từ dễ đến khó, rồi gán lần lượt cho vị trí 1 đến 12. Nhờ vậy buổi tập nặng dần về cuối.
4. **Chọn bài cho từng vị trí.** Ứng viên là các bài cùng nhóm cơ và cùng mức khó, trừ:
   - bài bị đánh dấu không thích;
   - bài đã có trong workout đang sinh;
   - bài có trong Smart Workout gần nhất, nếu vẫn còn ứng viên khác.

   Bài được đánh dấu thích có trọng số 3, các bài khác có trọng số 1. Chọn ngẫu nhiên theo trọng số.
5. **Khi thiếu ứng viên**, nới ràng buộc theo thứ tự:
   1. cho phép bài của Smart Workout gần nhất;
   2. cho phép bài lệch một mức khó, ưu tiên mức dễ hơn.

   Nới hết vẫn thiếu thì không tạo workout. App báo rằng danh sách không thích đang loại quá nhiều bài và mở màn hình chỉnh danh sách đó.
6. **Ngẫu nhiên có seed.** Hai nền tảng dùng cùng một thuật toán sinh số ngẫu nhiên, để cùng dữ liệu đầu vào và cùng seed thì ra cùng workout. Bộ fixture test dùng chung kiểm tra điều này.

Smart Workout sinh ra được giữ nguyên cho tới khi người dùng tập xong, bấm "tạo bài khác", hoặc đổi cấp.

## Phản hồi sau buổi tập

Sau mỗi buổi hoàn thành, app hỏi "Buổi tập thế nào?" với 5 lựa chọn: Quá nhẹ, Hơi nhẹ, Vừa sức, Hơi nặng, Quá sức. Người dùng có thể bỏ qua.

## Gợi ý đổi cấp

Chỉ các buổi phù hợp với cấp hiện tại mới được tính:
- Smart Workout;
- workout soạn sẵn có mức khó tương ứng: cấp 1–2 ứng với mức dễ, cấp 3 ứng với mức vừa, cấp 4–5 ứng với mức khó.

Luật (đề xuất):
- Chấm "Quá sức": gợi ý giảm một cấp ngay.
- Chấm "Quá nhẹ" ở hai buổi được tính liên tiếp: gợi ý tăng một cấp.
- Chấm "Hơi nhẹ" ba buổi liên tiếp: gợi ý tăng một cấp. Chấm "Hơi nặng" ba buổi liên tiếp: gợi ý giảm một cấp.
- Cấp luôn nằm trong khoảng 1 đến 5. Không có gợi ý vượt ra ngoài khoảng này.

App chỉ gợi ý. Người dùng bấm đồng ý thì cấp mới đổi. Dù người dùng đồng ý hay từ chối, bộ đếm đều được đặt lại. Mọi lần đổi cấp, kể cả đổi thủ công, đều được ghi lại thời điểm, cấp cũ, cấp mới và lý do.
