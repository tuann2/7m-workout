# Nội dung: minh hoạ, giọng đọc và văn bản

Trạng thái: bản nháp chờ duyệt (M0). Thông số kỹ thuật có thể đổi sau spike 3D.

Nguồn nội dung và ranh giới bản quyền theo [quyết định 0003](../decisions/0003-content-sources-and-copyright.md).

## Minh hoạ bài tập

- Mỗi bài có một video lặp do một nhân vật 3D nam trông giống người thật thực hiện. Video được dựng và render bằng Blender qua script.
- Mọi clip dùng cùng một nhân vật, cùng cảnh, cùng ánh sáng. Góc máy cố định cho từng bài.
- Vòng lặp liền mạch: tư thế ở khung cuối nối được với khung đầu.
- Thông số (đề xuất): 960×540, 30 fps, H.264, không tiếng, khoảng 300 KB mỗi clip, kèm một ảnh đại diện.
- Bài tập từng bên có thêm bản đối xứng, được chiếu sau lệnh "đổi bên".
- Khởi động và giãn cơ là chuỗi động tác ngắn, mỗi động tác một clip.
- Khi chưa có clip, app dùng ảnh tĩnh của chính nhân vật đó ở một tư thế đặc trưng. Bản phát hành không được thiếu cả hai.

## Giọng đọc

- Tất cả câu đọc là file audio tạo sẵn bằng dịch vụ AI, cho cả tiếng Việt và tiếng Anh. TTS của hệ điều hành chỉ dùng khi thiếu file.
- Danh sách câu đọc:
  - tên của 72 bài, cùng các động tác khởi động và giãn cơ;
  - "Chuẩn bị", "Nghỉ", "Tiếp theo", "Đổi bên", "Hoàn thành";
  - câu cổ vũ tự viết: khoảng 20 câu chung và 10 câu cho bài giữ tư thế, mỗi ngôn ngữ (đề xuất).
- Giọng được chọn bằng cách nghe thử cùng một bộ câu mẫu từ 2–3 dịch vụ. Chủ repo nghe và chọn.
- Điều khoản của dịch vụ phải cho phép đưa file audio vào repo công khai và phân phối kèm app.

## Văn bản

- Tên bài tiếng Việt, tên và mô tả workout đều viết mới, không dịch từ chữ của J&J.
- Mỗi bài có mô tả kỹ thuật bằng hai thứ tiếng: tư thế bắt đầu, các bước thực hiện, lỗi hay gặp, cách làm dễ hơn. Phần này viết ở luồng nội dung, trước M3.

## Ghi nguồn gốc

Mỗi file media phải có trong catalog các thông tin:
- đường dẫn file;
- nguồn nhân vật và giấy phép;
- nguồn chuyển động (keyframe tự đặt, mocap tự quay, hoặc thư viện) và giấy phép;
- công cụ và phiên bản dùng để tạo;
- ngày tạo.

Với file audio: dịch vụ, giọng, ngày tạo, điều khoản sử dụng.

Thiếu một trong các thông tin trên thì kiểm tra catalog khi build bản phát hành phải fail.

## Duyệt nội dung

- Chủ repo duyệt từng clip và từng câu đọc.
- Bài mức khó nên có người có chuyên môn (huấn luyện viên hoặc chuyên viên vật lý trị liệu) xem lại kỹ thuật trước khi phát hành.
