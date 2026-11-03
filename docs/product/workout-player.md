# Trình phát buổi tập

Trạng thái: bản nháp chờ duyệt (M0). Các con số đánh dấu "(đề xuất)" cần được duyệt.

## Cấu trúc buổi tập

Một workout gồm danh sách bài theo thứ tự, số vòng (1–3) và thời gian nghỉ (5, 10 hoặc 15 giây). Khi chạy, workout được chia thành các đoạn nối tiếp:

1. Khởi động, nếu người dùng chọn.
2. Chuẩn bị: 10 giây trước hiệp đầu tiên (đề xuất).
3. Hiệp tập và đoạn nghỉ xen kẽ: tập hết danh sách bài, rồi lặp lại theo số vòng. Có đoạn nghỉ sau mọi hiệp, trừ hiệp cuối cùng. Giữa hai vòng cũng chỉ có một đoạn nghỉ bình thường.
4. Giãn cơ, nếu người dùng chọn.

Mỗi hiệp tập dài 30 giây với mọi bài (đề xuất, suy ra từ app gốc).

Thời lượng phần chính, không tính chuẩn bị, khởi động và giãn cơ:

```text
số hiệp = số bài × số vòng
thời lượng = số hiệp × 30 + (số hiệp − 1) × thời gian nghỉ   (giây)
```

Ví dụ: workout gốc có 12 bài, 1 vòng, nghỉ 5 giây (theo dữ liệu app gốc), nên dài 12 × 30 + 11 × 5 = 415 giây, tức 6:55. Nếu nghỉ 10 giây thì dài 470 giây. Màn hình chi tiết workout hiện thời lượng này trước khi bắt đầu.

## Lệnh âm thanh

| Mốc | Nội dung |
|---|---|
| Đầu đoạn chuẩn bị | "Chuẩn bị", rồi tên bài đầu tiên |
| Bắt đầu hiệp | Tên bài |
| Giây thứ 15 của bài một bên | "Đổi bên" |
| Giây thứ 15 của bài không phải một bên | Một câu cổ vũ, nếu cài đặt đang bật. Bài giữ tư thế dùng bộ câu riêng. Chọn ngẫu nhiên, không lặp câu vừa phát |
| Đầu đoạn nghỉ | "Nghỉ", rồi "Tiếp theo" và tên bài kế tiếp |
| 3 giây cuối của hiệp và của đoạn nghỉ | Bíp 3, 2, 1 |
| Kết thúc phần chính | "Hoàn thành" và tiếng chuông |

Các lệnh không được phát chồng lên nhau. Khi hai lệnh trùng thời điểm, lệnh có thứ tự ưu tiên cao hơn được phát: bíp, "đổi bên", tên bài, "tiếp theo", câu cổ vũ. Câu cổ vũ bị bỏ nếu chưa kịp phát trước mốc kế tiếp.

Giọng đọc là file audio tạo sẵn ([content.md](content.md)). Trong lúc app đọc, nhạc của app khác được hạ nhỏ rồi trả lại như cũ. App không tự phát nhạc.

## Điều khiển

- Tạm dừng và tiếp tục.
- Bỏ qua đoạn hiện tại để sang đoạn kế tiếp.
- Thoát. App hỏi lại và cho biết đã xong bao nhiêu hiệp trên tổng số, ví dụ "Đã xong 7/12 hiệp".
- Thích hoặc không thích bài đang tập ([personal-data.md](personal-data.md)).
- Chuyển giữa hai chế độ xem: minh hoạ lớn, hoặc đồng hồ lớn.
- Màn hình luôn sáng trong lúc tập, nếu cài đặt đang bật (mặc định bật).

## Gián đoạn

- Khoá màn hình hoặc chuyển sang app khác: buổi tập vẫn chạy và lệnh âm thanh vẫn phát. Notification và màn hình khoá có nút tạm dừng, tiếp tục và bỏ qua.
- Có cuộc gọi đến: tự tạm dừng. Khi cuộc gọi kết thúc, app không tự chạy tiếp; người dùng bấm tiếp tục (đề xuất).
- Rút tai nghe hoặc ngắt tai nghe Bluetooth: tự tạm dừng.
- Hệ điều hành tắt app giữa buổi: lần mở sau, buổi đó được ghi là bỏ dở với số hiệp đã xong.

Thời gian luôn tính từ đồng hồ hệ thống chỉ chạy tiến, trừ đi thời gian tạm dừng. Sau 30 phút, đồng hồ trong app không được lệch quá 1 giây so với thời gian thật.

## Khởi động và giãn cơ

- Trước buổi tập, app hỏi có khởi động không. Sau phần chính, app hỏi có giãn cơ không. App nhớ lựa chọn gần nhất làm mặc định.
- Khởi động khoảng 2–3 phút, giãn cơ khoảng 3 phút (đề xuất). Mỗi phần là một chuỗi động tác ngắn chạy bằng chính trình phát, không phải một video dài.
- Danh sách động tác khởi động và giãn cơ sẽ được bổ sung vào catalog ở luồng nội dung, trước M2.

## Ghi lại buổi tập

Mỗi buổi tập lưu:
- bản chụp workout lúc tập (danh sách bài, số vòng, thời gian nghỉ), để lịch sử không đổi khi catalog hoặc workout tự tạo thay đổi;
- thời điểm bắt đầu và kết thúc;
- số hiệp đã tập, số hiệp bị bỏ qua, tổng số hiệp;
- thời gian tập thực tế, không tính lúc tạm dừng;
- cấp thể lực lúc tập;
- cảm nhận sau buổi tập, nếu người dùng trả lời ([smart-workout.md](smart-workout.md));
- trạng thái: hoàn thành, hoặc bỏ dở.

Buổi tập được tính là hoàn thành khi trình phát đi hết phần chính, kể cả khi có hiệp bị bỏ qua (đề xuất).
