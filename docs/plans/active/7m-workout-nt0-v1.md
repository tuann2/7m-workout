# Kế hoạch thực hiện: 7M Workout Nt0 v1

Ngày: 2026-11-03

## Trạng thái

Active. M0 đang làm trên nhánh `m0-spec-foundation`. Spike 3D làm thử 5 video chạy song song trong một worktree riêng để đo thời gian. Người review vẫn góp ý được theo các câu hỏi bên dưới.

### Cần người review trả lời

1. Nhân vật 3D làm bằng MPFB có đủ "giống người thật" cho một app tập luyện không? Hay nên dùng tài sản trả phí, hoặc phương án lai với Kling Motion Control (mục "Minh hoạ")?
2. Mocap từ một camera điện thoại có đủ tốt cho 72 bài, nhất là các bài nằm sàn, hay nên ưu tiên keyframe và Mixamo?
3. Ước lượng 3–4 tuần làm việc khi AI viết code có thực tế không? Phần nào dễ trễ nhất?
4. Có nên giữ tên "7M Workout Nt0" khi phát hành công khai không (mục "Rủi ro và phục hồi")?
5. Còn rủi ro nào chưa được nêu?

## Kết quả cần đạt

Một app thay thế J&J Official 7 Minute Workout, app đã ngừng hỗ trợ từ năm 2024. Khi v1 hoàn thành:

- Có app Android và app iOS native, chạy hoàn toàn offline, không cần tài khoản, không thu dữ liệu người dùng.
- Có đủ 22 workout theo app gốc (dùng 72 bài tập), Smart Workout tự điều chỉnh theo cấp thể lực, workout tự tạo, lịch sử tập và nhắc lịch.
- Minh hoạ bằng nhân vật 3D nam trông giống người thật. Giọng đọc tạo sẵn bằng AI. Giao diện và giọng đọc có tiếng Việt và tiếng Anh.
- Tên hiển thị "7M Workout Nt0", miễn phí, mã nguồn công khai trên GitHub theo giấy phép Apache 2.0.
- Bản Android tải và cài được từ GitHub Releases. Bản iOS build và cài được bằng Xcode.
- Hai app chạy giống nhau vì cùng đọc một catalog và cùng qua một bộ fixture test.

## Bối cảnh

### App gốc

Phân tích từ file XAPK bản 2.8.5 (bản cuối): dữ liệu trong `assets/json_data`, manifest và chuỗi giao diện. Có đối chiếu thêm với thông cáo báo chí năm 2014 của J&J.

- 72 bài tập, chia đều cho 4 nhóm cơ (toàn thân, thân trên, core, thân dưới) và 3 mức khó. Có 17 bài tập từng bên, giữa hiệp có lệnh đổi bên. Có 5 bài giữ tư thế (plank, wall sit…) dùng bộ câu cổ vũ riêng.
- 22 workout soạn sẵn, dùng hết cả 72 bài. Mỗi workout có 1–3 vòng, nghỉ 5, 10 hoặc 15 giây giữa các bài, mỗi vòng 12, 24 hoặc 36 bài.
- Dữ liệu không ghi độ dài hiệp. Đối chiếu với tên bài (7, 8, 9, 16, 21, 24 phút) thì suy ra mỗi hiệp 30 giây.
- Workout 12 động tác xếp theo thứ tự toàn thân → thân dưới → thân trên → core, lặp 3 lần.
- Smart Workout có 19 mẫu cho 5 cấp thể lực. Mỗi mẫu quy định số vòng, thời gian nghỉ và số bài dễ/vừa/khó trong 12 bài: cấp 1 là 9/3/0, cấp 3 là 4/4/4, cấp 5 là 0/3/9. App dùng danh sách thích/không thích khi chọn bài, và báo không tạo được khi danh sách này loại quá nhiều bài.
- Sau buổi tập, app hỏi cảm nhận bằng thanh trượt rồi gợi ý tăng hoặc giảm cấp. Người dùng đồng ý thì cấp mới đổi.
- Trình phát có:
  - vòng đếm giờ, video lặp, bài tiếp theo, giọng đọc, bíp;
  - nút thích/không thích ngay khi tập;
  - khởi động và giãn cơ tuỳ chọn;
  - xử lý cuộc gọi đến và rút tai nghe;
  - trình phát nhạc riêng.
- Ngoài ra có tự tạo workout qua 6 bước, lịch sử tập, nhắc lịch tập lặp theo ngày và nhắc khi lâu không tập.
- Media đóng gói:
  - 78 video lặp (trung vị 3,5 giây, phần lớn 960×540);
  - video khởi động và video giãn cơ dài 2–3,5 phút;
  - gần 18 MB audio giọng đọc.
- Các phần phụ thuộc server: tài khoản, đồng bộ, kết nối Castlight, Jiff, Walgreens và analytics. App ghi rõ rằng khi offline thì kết quả tập, cấp thể lực và lựa chọn thích/không thích sẽ không được lưu. App đã ngừng hỗ trợ nên nhiều khả năng phần server không còn chạy.

### Repo hiện tại

- Commit `5211a1f` đã dựng khung repo theo [quyết định 0001](../../decisions/0001-native-ios-and-android-apps.md):
  - `ios/`: SwiftUI, iOS 17+, iPhone và iPad.
  - `android/`: Jetpack Compose, minSdk 26.
  - Hai app dùng chung bundle id `vn.io.nt0.sevenminworkout`. Cả hai mới là khung hiện chữ "7min Workout".
- Kiểm tra bằng `scripts/validate.sh ios|android|all`. Lệnh chi tiết nằm ở `docs/runbooks/`. Android chưa có unit test và chưa chạy thử trên máy hay emulator.
- `docs/product/` còn trống. Theo `AGENTS.md`, nội dung bài tập, thời lượng và luật sản phẩm phải được ghi ở đó trước khi viết code. Mọi con số trong plan này là đề xuất. Chúng chỉ thành luật khi được ghi vào `docs/product/` ở M0.
- File XAPK nằm ở gốc repo. File chưa được track nhưng cũng chưa có trong `.gitignore`. Repo chưa có remote.
- Máy phát triển: Apple M4 Pro, RAM 24 GB, Xcode 27.2, Android SDK, ffmpeg 8.1.2. Chưa cài Blender và MediaPipe.

### Ranh giới bản quyền

Không dùng lại bất kỳ tài sản nào của J&J:
- video, audio, hình ảnh và giọng nói của Chris Jordan;
- tên và nhận diện thương hiệu;
- văn bản mô tả, câu cổ vũ, bài viết;
- mã nguồn decompile.

Không commit file XAPK, kể cả vào lịch sử git.

Những gì được dựa vào:
- Phương pháp 7 Minute Workout và 12 động tác gốc, đã công bố trong bài của Klika và Jordan trên ACSM's Health & Fitness Journal (số tháng 5–6/2013). App sẽ ghi nguồn.
- Dữ liệu chức năng của 22 workout: bài nào, thứ tự, số vòng, thời gian nghỉ.
- Tên động tác phổ thông và các ý tưởng chức năng như cấp thể lực, thích/không thích, nhắc lịch.

Tên và mô tả workout sẽ viết mới bằng hai thứ tiếng, không dịch lại mô tả của J&J. Workout có tên chỉ mô tả bài tập như "Original 7 Minute Workout" thì giữ tên. Những tên J&J tự đặt như "The Super Hero Workout", "The Mountain Peak", "The Triple Triple Workout", "The Adventure Workout" sẽ được đổi.

Luật bản quyền nói chung bảo hộ cách thể hiện, không bảo hộ ý tưởng hay phương pháp. Đây là định hướng làm việc, không phải ý kiến pháp lý.

## Phạm vi

Trong phạm vi v1:
- 22 workout, 72 bài tập, khởi động và giãn cơ.
- Trình phát:
  - đếm giờ, minh hoạ 3D, giọng đọc, bíp, lệnh đổi bên;
  - tạm dừng, bỏ qua, thoát;
  - chạy tiếp khi khoá màn hình;
  - tự dừng khi có cuộc gọi hoặc rút tai nghe;
  - nhạc của app khác tự nhỏ lại khi app đọc lệnh.
- Smart Workout, thích/không thích, phản hồi sau buổi tập và gợi ý đổi cấp.
- Workout tự tạo, lịch sử, chuỗi ngày tập, nhắc lịch, nhắc khi lâu không tập.
- Sao lưu bằng cơ chế của hệ điều hành. Xuất và nhập file JSON dùng chung một định dạng cho hai nền tảng.
- Tiếng Việt và tiếng Anh, dark mode, trình đọc màn hình, chữ cỡ lớn, máy tính bảng.
- Phát hành bản Android qua GitHub Releases, kèm hướng dẫn build iOS bằng Xcode.

Ngoài phạm vi v1:
- Google Play và App Store. Sẽ làm khi có tài khoản.
- Health Connect, HealthKit, Wear OS, Apple Watch, Live Activity.
- Chế độ không nhảy và tuỳ chỉnh độ dài hiệp. Hai tính năng này để v1.1, nhưng catalog có sẵn cờ `impact` từ v1.
- Trình phát nhạc trong app, tài khoản, đồng bộ server, analytics, quảng cáo, mức động lực.
- Chuyển dữ liệu từ app cũ. Dữ liệu đó nằm trong vùng riêng của app và được mã hoá bằng SQLCipher.

## Cách làm

### Phần dùng chung cho hai app

- Luật sản phẩm viết một lần trong `docs/product/`.
- Catalog JSON chứa bài tập, workout và mẫu Smart Workout:
  - Đặt trong `docs/product/catalog/`, có `schemaVersion`, id dạng slug.
  - Một script chép catalog và media vào `android/app/src/main/assets/` và `ios/SevenMinWorkout/`. File mới trong `ios/SevenMinWorkout/` tự vào target nên không phải sửa `project.pbxproj`.
  - `validate.sh` báo lỗi nếu bản chép khác bản gốc.
- Bộ fixture test chung, là các file JSON ghi đầu vào và kết quả mong đợi. Bộ này phủ timeline, mốc phát lệnh, bộ sinh Smart Workout và luật đổi cấp. Unit test Kotlin và Swift chạy cùng bộ này.
- Engine viết hai lần, theo cùng một thiết kế:
  - Workout được chia thành các đoạn nối tiếp: chuẩn bị, tập, nghỉ, khởi động, giãn cơ. Tổng thời gian tính sẵn từ trước.
  - Giờ hiện tại lấy từ đồng hồ hệ thống chỉ chạy tiến (không đổi khi chỉnh giờ máy), trừ đi thời gian tạm dừng. Không cộng dồn từng nhịp tick, nên đồng hồ không chạy lệch.
  - Các lệnh phát theo mốc: đọc tên bài khi bắt đầu, "đổi bên" giữa hiệp với bài một bên, "tiếp theo" lúc nghỉ, bíp 3-2-1, câu cổ vũ.
  - Bộ sinh ngẫu nhiên có seed dùng cùng một thuật toán ở hai bên (ví dụ SplitMix64), để cùng seed thì ra cùng workout.
- Android không xin quyền `INTERNET`. iOS không có code mạng.

### Phần riêng từng nền tảng

| Thành phần | Android | iOS |
|---|---|---|
| Giao diện | Compose + Material 3, Navigation Compose | SwiftUI, NavigationStack |
| Dữ liệu người dùng | Room | SwiftData |
| Cài đặt | DataStore | UserDefaults (`@AppStorage`) |
| Phát audio giọng đọc, bíp | Media3 hoặc SoundPool | AVAudioPlayer |
| Chạy khi khoá màn hình | foreground service `mediaPlayback` + MediaSession của Media3 | background mode Audio, chọn cách làm qua spike |
| Hạ âm nhạc của app khác khi đọc | audio focus tạm thời có ducking | AVAudioSession với `.duckOthers` |
| Cuộc gọi, rút tai nghe | theo dõi audio mode, `ACTION_AUDIO_BECOMING_NOISY` | interruption và route change của AVAudioSession |
| Nhắc lịch | AlarmManager (inexact) + WorkManager, đăng ký lại sau khi khởi động máy | UNUserNotificationCenter, trigger theo lịch |
| Video lặp | Media3 ExoPlayer | AVPlayerLooper |
| Đồng hồ hệ thống | `SystemClock.elapsedRealtime()` | `ContinuousClock` |

- Android phát hiện cuộc gọi qua audio mode: dùng `AudioManager.addOnModeChangedListener` từ Android 12, máy cũ hơn thì đọc `mode` định kỳ. Nhờ vậy app không cần quyền `READ_PHONE_STATE`.
- Android không xin quyền `SCHEDULE_EXACT_ALARM`.
- iOS cần một spike để chọn cách giữ trình phát chạy nền. Có ba hướng:
  - giữ audio session hoạt động suốt buổi;
  - dùng HKWorkoutSession trên iPhone (cần kiểm tra từ phiên bản iOS nào thì có);
  - lên lịch notification cho từng mốc.

### Minh hoạ: nhân vật 3D bằng Blender

Đã chọn nhân vật 3D nam trông giống người thật, thay cho video do AI tạo. Lý do:
- Nhân vật giống nhau ở mọi clip.
- Động tác đúng theo dữ liệu chuyển động.
- Vòng lặp khớp tuyệt đối.
- Render lại được bất cứ lúc nào.
- Không tốn phí phần mềm.

Claude viết script Python điều khiển Blender, chạy nền bằng lệnh `blender -b -P`. Quy trình gồm 5 bước:

1. **Nhân vật.** Spike so sánh các nguồn sau:
   - MPFB, bản MakeHuman chạy trong Blender. Theo hiểu biết hiện tại, file xuất ra theo giấy phép CC0, cần kiểm tra lại.
   - Nhân vật có sẵn trên Mixamo.
   - Nhân vật dựng từ ảnh AI bằng công cụ image-to-3D (Meshy, Tripo, Hunyuan3D).
   - Tài sản trả phí (Character Creator, Daz).

   Tiêu chí chọn: độ giống người thật, có khung xương chuẩn, và giấy phép cho phép đăng video lên repo công khai.
2. **Chuyển động.** Mỗi bài dùng một trong ba nguồn:
   - Claude đặt góc khớp cho từng tư thế (keyframe): dùng cho bài giữ tư thế và bài đơn giản.
   - Hoạt hoạ có sẵn của Mixamo: dùng cho bài phổ biến.
   - Mocap: chủ repo quay clip tập bằng điện thoại. Tool MediaPipe chạy trên máy nhận ra tư thế trong clip, rồi script áp chuyển động đó lên khung xương nhân vật và lọc rung, lọc trượt chân.
3. **Render.**
   - Cảnh và ánh sáng cố định. Góc máy cố định cho từng bài, ghi trong catalog.
   - Tư thế cuối trùng tư thế đầu để vòng lặp liền mạch.
   - 960×540, 30 fps, H.264, không tiếng, khoảng 300 KB mỗi clip, kèm ảnh đại diện.
   - 17 bài tập từng bên có thêm bản đối xứng.
4. **Kiểm tra.**
   - Claude trích khung hình từ clip đã render để tự sửa tư thế.
   - Chủ repo duyệt từng clip.
   - Bài mức khó nên có người có chuyên môn xem lại.
5. **Lưu trữ.**
   - Script, keyframe và dữ liệu mocap tự quay nằm trong repo.
   - File có giấy phép cấm phân phối lại (ví dụ file gốc của Mixamo) và clip quay thô nằm trong thư mục bị ignore.
   - Repo chỉ chứa video đã render.
   - Catalog ghi nguồn nhân vật, nguồn chuyển động và giấy phép của từng clip. Thiếu thông tin này thì test fail.

Khởi động và giãn cơ được dựng thành chuỗi khoảng 10–15 động tác ngắn chạy bằng engine, thay cho video dài như app gốc. Tổng cộng khoảng 85 clip.

Nếu nhân vật MPFB chưa đủ giống người thật thì có hai hướng:
- Dùng tài sản trả phí.
- Dùng clip 3D làm mẫu chuyển động cho Kling Motion Control. Kling sẽ áp chuyển động đó lên một nhân vật trông như người thật. Cách này tốn phí API và phải xem điều khoản của dịch vụ.

### Giọng đọc AI

- Mọi câu app đọc đều cố định: tên bài, "tiếp theo", câu cổ vũ tự viết, đếm ngược, "đổi bên". Một script tạo sẵn vài trăm file audio ngắn cho hai thứ tiếng.
- Chọn dịch vụ bằng cách nghe thử: tạo cùng khoảng 10 câu mẫu bằng 2–3 dịch vụ, chủ repo nghe rồi chọn. Các ứng viên: ElevenLabs, FPT.AI, Viettel AI, Zalo AI, Google Cloud Text-to-Speech, Azure AI Speech.
- Điều khoản của dịch vụ phải cho phép đưa file audio vào repo công khai.
- TTS của máy chỉ giữ làm dự phòng.

### Phát hành qua GitHub

- Repo công khai `tuann2/7m-workout`, giấy phép Apache 2.0.
- Trước lần push đầu tiên: thêm `*.xapk` vào `.gitignore` và kiểm tra lịch sử git không chứa file XAPK.
- Android:
  - APK release ký bằng keystore tự quản. Keystore cất ngoài repo và sao lưu ở hai nơi.
  - `versionCode` tăng ở mỗi bản.
  - Script chạy trên máy chủ repo: build, tính SHA-256 và tạo Release bằng `gh release create`.
  - Chuyển sang GitHub Actions thì cần được cho phép riêng, vì khi đó khoá ký phải nằm trong GitHub Secrets.
- Cập nhật: app không có mạng nên không tự kiểm tra bản mới. Người dùng theo dõi trang Release hoặc dùng Obtainium.
- Khi lên Google Play sau này, đăng ký Play App Signing bằng đúng khoá ký hiện tại. Như vậy người đã cài từ GitHub vẫn cập nhật được qua Play.
- Google yêu cầu xác minh developer cho app cài ngoài store. Yêu cầu áp dụng từ 30/9/2026 ở Brazil, Indonesia, Singapore và Thái Lan, toàn cầu từ năm 2027. Cần đăng ký xác minh trước năm 2027.
- iOS:
  - Hướng dẫn build bằng Xcode với Apple ID miễn phí. App cài theo cách này hết hạn sau 7 ngày.
  - Tuỳ chọn đính kèm file IPA chưa ký cho người dùng AltStore hoặc SideStore.

## Rủi ro và phục hồi

| Rủi ro | Cách giảm |
|---|---|
| Nhân vật 3D chưa đủ giống người thật | Chạy spike trước khi làm hàng loạt. Dự phòng bằng tài sản trả phí hoặc phương án lai với Kling |
| Mocap từ một camera điện thoại bị rung, trượt chân, sai ở bài nằm sàn | Lọc chuyển động. Dùng keyframe hoặc Mixamo cho bài khó nhận diện |
| Động tác sai kỹ thuật gây chấn thương | Duyệt từng clip, có người chuyên môn xem bài khó, khuyến cáo hỏi ý kiến bác sĩ, bài nào cũng có phương án dễ hơn |
| Lỡ đưa tài sản của J&J hoặc file cấm phân phối lại lên repo công khai | `.gitignore`, test kiểm tra nguồn gốc trong catalog, rà `git ls-files` trước mỗi lần push |
| Tên "7M Workout Nt0" trùng tên hiển thị "7M Workout" của app J&J nên có thể bị khiếu nại nhãn hiệu | Chuẩn bị tên dự phòng trước v1 |
| Hai app chạy khác nhau | Catalog và fixture dùng chung. Milestone chỉ đóng khi cả hai app cùng qua |
| iOS dừng trình phát khi khoá màn hình | Spike ngay đầu M2 |
| Hãng điện thoại Android chặn app chạy nền | Test trên máy thật, hướng dẫn người dùng tắt tối ưu pin cho app |
| Mất keystore Android | Sao lưu ở hai nơi ngay khi tạo |

Phục hồi:
- Mỗi milestone là một nhóm commit riêng. Muốn quay lại milestone trước thì dùng `git revert`.
- Media và audio tạo lại được từ script và dữ liệu trong repo.
- Dữ liệu người dùng xuất và nhập được bằng file JSON. Mỗi lần đổi schema Room hoặc SwiftData đều kèm migration và test.

## Tiến độ

Thời gian tính theo ngày làm việc, với hai giả định:
- AI viết code.
- Chủ repo phản hồi trong ngày mỗi khi cần duyệt hoặc thử trên máy thật.

Milestone chỉ đóng khi cả hai app cùng qua một bộ fixture và một checklist.

- [ ] **M0. Spec và nền móng (1–2 ngày).**
  - [x] Viết `docs/product/`: 72 bài, 22 workout, luật trình phát, Smart Workout, luật đổi cấp, nhắc lịch, schema catalog (bản nháp chờ duyệt).
  - [x] Ghi các quyết định 0002–0005 vào `docs/decisions/`.
  - [x] Thêm `*.xapk` vào `.gitignore`, thêm file `LICENSE`.
  - [x] Tạo repo `tuann2/7m-workout`, push `main` và nhánh `m0-spec-foundation`, mở draft PR #1 để duyệt spec.
  - [x] Tạo emulator Android `sevenmin_api35` (Android 15, Pixel 7). App debug mở được trên emulator và hiện "7min Workout". Runbook Android đã cập nhật.
  - [x] `scripts/validate.sh all` chạy thành công trên bản clone mới của nhánh `m0-spec-foundation` (2026-11-03, 112 giây). Test iOS qua. Build và lint Android qua, chỉ còn cảnh báo `MissingApplicationIcon` đã biết.
  - [ ] Bạn duyệt spec rồi merge PR #1.
  - Chuyển sang M1: đổi tên hiển thị "7min Workout" thành "7M Workout Nt0" ở cả hai app, cập nhật runbook theo.
  - Xong khi: spec được duyệt và `scripts/validate.sh all` chạy thành công trên một bản clone mới.
- [ ] **M1. Catalog và engine (1–2 ngày).**
  - Catalog, script chép catalog, engine Kotlin và Swift, fixture chung.
  - Xong khi fixture chạy qua ở cả hai nền tảng, gồm các trường hợp:
    - Bài gốc 12 động tác × 30 giây, nghỉ 10 giây, dài đúng 470 giây. Nghỉ 5 giây thì dài 415 giây. Chưa tính đếm ngược chuẩn bị.
    - Tạm dừng rồi tiếp tục không làm lệch giờ.
    - Lệnh "đổi bên" rơi đúng giây thứ 15.
    - Catalog sai thì test fail.
- [ ] **M2. Trình phát (4–5 ngày), ra bản thử v0.1.**
  - Màn hình tập, chạy nền, âm thanh, xử lý cuộc gọi và tai nghe, lưu buổi tập, spike chạy nền trên iOS.
  - Xong khi: trên máy thật của mỗi nền tảng, tập trọn bài gốc trong lúc tắt màn hình, Spotify phát nền và có một cuộc gọi đến giữa chừng. Sau 30 phút, đồng hồ lệch không quá 1 giây.
- [ ] **M3. Thư viện, lịch sử, cài đặt (2–3 ngày).**
  - Xong khi: Compose UI test và XCUITest chạy qua luồng chọn workout → tập → kết thúc → thấy buổi tập trong lịch sử.
- [ ] **M4. Cá nhân hoá (2–3 ngày).**
  - Smart Workout, thích/không thích, phản hồi và đổi cấp, workout tự tạo.
  - Xong khi fixture chạy với cả 5 cấp và nhiều seed, và workout sinh ra luôn:
    - đủ 12 bài, đúng số bài theo mức khó, không trùng bài;
    - không có bài bị đánh dấu không thích;
    - báo lỗi rõ ràng khi bị loại quá nhiều bài.
- [ ] **M5. Nhắc lịch, sao lưu, hoàn thiện (2–3 ngày).**
  - Xong khi:
    - Nhắc lịch vẫn đến sau khi khởi động lại máy.
    - File xuất từ app này nhập được vào app kia.
    - Bản Android đã được thử trên một máy Samsung và một máy Xiaomi hoặc Oppo.
- [ ] **M6. Phát hành trên GitHub (1–2 ngày).**
  - Keystore, script phát hành, hướng dẫn cài, README.
  - Xong khi:
    - Tải APK từ Release về một máy chưa từng cài app, cài được và tập trọn bài gốc.
    - Cài bản mới đè lên bản cũ mà dữ liệu vẫn còn nguyên.
- [ ] **Nội dung 3D (song song từ M0, 2–3 tuần).**
  - Spike chọn nhân vật (1–2 ngày) với ba bài Squat, Jumping Jacks, Push-Up.
  - Dựng quy trình render (3–4 ngày).
  - Làm chuyển động và render khoảng 85 clip (1–2 tuần).
  - Xong khi: bài nào trong catalog cũng có clip đã duyệt và ghi đủ nguồn gốc.
- [ ] **Giọng đọc (song song, 2–3 ngày).**
  - Nghe thử, chọn dịch vụ, tạo và kiểm tra file.
  - Xong khi: mọi câu đọc ở cả hai thứ tiếng đều có file audio, có ghi nguồn và điều khoản.

Ước lượng tổng:
- Bản thử v0.1 có sau khoảng 1,5–2 tuần.
- Bản v1 Android trên GitHub có sau khoảng 3–4 tuần làm việc.
- Phần nội dung 3D dễ trễ nhất. Nếu trễ, v1 vẫn phát hành được: những bài chưa có clip sẽ dùng ảnh tĩnh của chính nhân vật đó, render ở một tư thế đặc trưng.

## Quyết định

- 2026-11-02: Hai app native trong một repo, bundle id `vn.io.nt0.sevenminworkout` ([0001](../../decisions/0001-native-ios-and-android-apps.md)).
- 2026-11-03: Bám theo 22 workout của app gốc, nên v1 cần đủ 72 bài.
- 2026-11-03: Tiếng Việt và tiếng Anh.
- 2026-11-03: Tên hiển thị "7M Workout Nt0". Rủi ro nhãn hiệu đã được nêu, cần chuẩn bị tên dự phòng.
- 2026-11-03: Miễn phí, không bán gì trong app.
- 2026-11-03: Phát hành qua GitHub trước, tài khoản store tính sau. Repo công khai dưới `tuann2`, giấy phép Apache 2.0.
- 2026-11-03: v1 phát hành chính thức cho Android. iOS build bằng Xcode cho tới khi có tài khoản Apple.
- 2026-11-03: Giọng đọc tạo sẵn bằng AI.
- 2026-11-03: Minh hoạ bằng nhân vật 3D nam trông giống người thật, dựng bằng Blender, thay cho video do AI tạo.
- 2026-11-03: Tên repo là `7m-workout`.
- 2026-11-03: Các quyết định lâu dài được ghi thành bản ghi [0002](../../decisions/0002-offline-no-accounts.md), [0003](../../decisions/0003-content-sources-and-copyright.md), [0004](../../decisions/0004-shared-catalog-and-test-fixtures.md), [0005](../../decisions/0005-public-github-releases.md).
- 2026-11-03: Spec trong `docs/product/` giữ thời gian nghỉ 5 giây của workout gốc như dữ liệu J&J (6:55), thay vì 10 giây. Điểm này nằm trong danh sách cần duyệt ở `docs/product/catalog.md`.

Đang dùng mặc định, chưa được xác nhận rõ:
- Không quảng cáo.
- Mỗi milestone làm xong cả hai app.
- Build bản phát hành bằng script trên máy chủ repo.

Chưa chốt: tên dự phòng, nguồn nhân vật 3D, dịch vụ giọng đọc.

## Kiểm chứng

- Kiểm tra tập trung:
  - Fixture chung cho timeline, mốc phát lệnh, bộ sinh Smart Workout và luật đổi cấp, chạy ở cả Kotlin và Swift.
  - Kiểm tra catalog.
  - Kiểm tra nguồn gốc media.
- Tích hợp và end-to-end:
  - Compose UI test và XCUITest.
  - Checklist trên máy thật: khoá màn hình, cuộc gọi, nhạc nền, tai nghe, nhắc lịch sau khi khởi động lại, máy của các hãng hay chặn app chạy nền.
- Kiểm tra bắt buộc của repo: `scripts/validate.sh all`, kèm bước so bản chép catalog với bản gốc.
- Phát hành: cài từ GitHub Release trên máy chưa từng cài app, cài đè bản mới mà dữ liệu vẫn còn nguyên.

## Kết quả

Chưa có. Phần này được cập nhật khi hoàn thành, trước khi chuyển plan sang `docs/plans/completed/`.

## Nguồn tham khảo

- Klika B., Jordan C. "High-intensity circuit training using body weight: Maximum results with minimal investment." ACSM's Health & Fitness Journal, 2013.
- [Android developer verification](https://developer.android.com/developer-verification)
- [AI Video Generation in 2026 (OCDevel)](https://ocdevel.com/mlg/mla-26): tình hình các công cụ video AI, dùng cho phương án lai.
