# Catalog bài tập và workout

Trạng thái: bản nháp chờ duyệt (M0).

Catalog là nguồn nội dung duy nhất cho cả hai app ([quyết định 0004](../decisions/0004-shared-catalog-and-test-fixtures.md)). Dữ liệu nằm trong ba file JSON:

| File | Nội dung |
|---|---|
| [catalog/exercises.json](catalog/exercises.json) | 72 bài tập |
| [catalog/workouts.json](catalog/workouts.json) | 22 workout soạn sẵn |
| [catalog/smart-templates.json](catalog/smart-templates.json) | 19 mẫu Smart Workout |

## Nguồn dữ liệu

Phần dữ liệu chức năng lấy từ app J&J bản 2.8.5: bài nào thuộc nhóm cơ nào, mức khó, bài nào tập từng bên, thứ tự bài trong mỗi workout, số vòng, thời gian nghỉ, số bài dễ/vừa/khó của từng mẫu Smart Workout. Tên tiếng Việt, tên và mô tả workout đều viết mới. Những tên workout J&J tự đặt đã được đổi.

Các cờ `hold`, `impact` và `equipment` là đánh giá mới, cần duyệt:
- `hold` gồm 8 bài giữ tư thế. App gốc chỉ đánh dấu 5 bài; bản này thêm Plank quỳ gối, Plank nghiêng quỳ gối và Ngồi tựa tường một chân.
- `impact: "high"` gồm 13 bài có bật nhảy. Riêng "Hạ người chạm sàn" và "Hạ người chạm sàn sang ngang" đang để `low` vì tên bài chưa đủ rõ để kết luận.

## Lược đồ

Mọi file đều có `schemaVersion` (hiện là `1`).

**Bài tập** (`exercises[]`):

| Trường | Kiểu | Ý nghĩa |
|---|---|---|
| `id` | chuỗi | Định danh dạng slug, không đổi sau khi phát hành |
| `name.en`, `name.vi` | chuỗi | Tên hiển thị và tên đọc |
| `muscleGroup` | `total-body`, `upper-body`, `core`, `lower-body` | Nhóm cơ chính |
| `difficulty` | 1, 2, 3 | Dễ, vừa, khó |
| `unilateral` | true/false | Tập từng bên; có lệnh "đổi bên" ở giây thứ 15 |
| `hold` | true/false | Giữ tư thế; dùng bộ câu cổ vũ riêng |
| `impact` | `low`, `high` | Có bật nhảy hay không (dành cho chế độ không nhảy ở v1.1) |
| `equipment` | danh sách `chair`, `wall` | Dụng cụ cần có |
| `media` | đối tượng hoặc `null` | Minh hoạ và nguồn gốc ([content.md](content.md)). Được để `null` trong lúc phát triển |

**Workout** (`workouts[]`): `id`, `order` (thứ tự hiển thị), `name`, `description` (đều có `en` và `vi`), `difficulty` (1–3), `cycles` (1–3), `restSeconds` (5, 10 hoặc 15), `exercises` (danh sách id bài theo thứ tự, 1–36 bài).

**Mẫu Smart Workout** (`templates[]`): `id`, `level` (1–5), `cycles`, `restSeconds`, `counts.easy`, `counts.moderate`, `counts.hard` (tổng bằng 12).

## Luật kiểm tra

Bộ nạp catalog trên cả hai nền tảng phải từ chối catalog vi phạm một trong các luật sau, và test phải fail:
- `id` trùng nhau trong cùng một file;
- workout tham chiếu tới bài không tồn tại;
- thiếu `en` hoặc `vi` ở bất kỳ tên hay mô tả nào;
- giá trị nằm ngoài miền cho phép ở bảng trên;
- tổng số bài của một mẫu Smart Workout khác 12;
- khi build bản phát hành: bài nào cũng phải có `media` đủ thông tin nguồn gốc.

## Điểm cần duyệt

- Workout gốc theo dữ liệu J&J nghỉ 5 giây, nên dài 6:55. Các bài viết phổ biến về bài báo năm 2013 thường nêu khoảng 10 giây chuyển bài; cần đối chiếu bản gốc của bài báo. Bản này giữ 5 giây để bám app gốc.
- Workout "Advanced Progression" có 24 bài × 2 vòng, tính theo công thức ra 31:50. Đây là con số từ dữ liệu gốc, chưa đối chiếu được với app khi chạy thật.

## Danh sách

Các bảng dưới được sinh từ file JSON lúc viết spec. Nếu bảng và JSON khác nhau thì JSON là nguồn chuẩn. Thời lượng tính theo công thức ở [workout-player.md](workout-player.md).


### Bài tập

| id | English | Tiếng Việt | Nhóm cơ | Mức | Đặc điểm |
|---|---|---|---|---|---|
| `jumping-jacks` | Jumping Jacks | Bật nhảy dang tay chân | Toàn thân | Vừa | bật nhảy |
| `step-up` | Step-Up | Bước lên ghế | Toàn thân | Dễ | cần ghế |
| `high-knees` | High Knees | Chạy nâng cao gối | Toàn thân | Vừa | bật nhảy |
| `mountain-climbers` | Mountain Climbers | Leo núi | Toàn thân | Khó |  |
| `burpees` | Burpees | Burpee | Toàn thân | Khó | bật nhảy |
| `plyo-split-squat` | Plyo Split Squat | Split squat bật nhảy đổi chân | Toàn thân | Khó | bật nhảy |
| `side-to-side-shuffle` | Side-to-Side Shuffle | Lướt ngang | Toàn thân | Dễ |  |
| `squat-and-box` | Squat & Box | Squat kết hợp đấm | Toàn thân | Dễ |  |
| `side-to-side-hop` | Side-to-Side Hop | Bật nhảy ngang | Toàn thân | Vừa | bật nhảy |
| `push-up` | Push-Up | Hít đất | Thân trên | Dễ |  |
| `triceps-dip` | Triceps Dip | Dip tay sau với ghế | Thân trên | Dễ | cần ghế |
| `push-up-and-rotation` | Push-Up & Rotation | Hít đất xoay người | Thân trên | Vừa |  |
| `one-leg-push-up` | One-Leg Push-Up | Hít đất một chân | Thân trên | Vừa | một bên |
| `one-leg-triceps-dip` | One-Leg Triceps Dip | Dip tay sau một chân | Thân trên | Vừa | một bên, cần ghế |
| `staggered-push-up` | Staggered Push-Up | Hít đất tay so le | Thân trên | Dễ |  |
| `spiderman-push-up` | Spiderman Push-Up | Hít đất người nhện | Thân trên | Khó |  |
| `hindu-push-up` | Hindu Push-Up | Hít đất kiểu Hindu | Thân trên | Khó |  |
| `grasshopper-push-up` | Grasshopper Push-Up | Hít đất châu chấu | Thân trên | Khó |  |
| `abdominal-crunch` | Abdominal Crunch | Gập bụng | Core | Dễ |  |
| `plank` | Plank | Plank | Core | Khó | giữ tư thế |
| `side-plank` | Side Plank | Plank nghiêng | Core | Vừa | một bên, giữ tư thế |
| `bird-dog` | Bird Dog | Bird dog (duỗi chéo tay chân) | Core | Dễ |  |
| `reverse-plank` | Reverse Plank | Plank ngửa | Core | Khó | giữ tư thế |
| `full-side-plank` | Full Side Plank | Plank nghiêng thẳng tay | Core | Khó | một bên, giữ tư thế |
| `one-leg-bridge` | One-Leg Bridge | Nâng hông một chân | Core | Vừa | một bên |
| `bicycle-crunch` | Bicycle Crunch | Gập bụng đạp xe | Core | Vừa |  |
| `superman` | Superman | Superman (nằm sấp nâng tay chân) | Core | Dễ |  |
| `wall-sit` | Wall Sit | Ngồi tựa tường | Thân dưới | Dễ | giữ tư thế, cần tường |
| `squat` | Squat | Squat | Thân dưới | Dễ |  |
| `lunge` | Lunge | Lunge (bước chùng chân) | Thân dưới | Dễ |  |
| `one-leg-squat` | One-Leg Squat | Squat một chân | Thân dưới | Khó | một bên |
| `lunge-and-rotation` | Lunge & Rotation | Lunge xoay người | Thân dưới | Vừa |  |
| `side-lunge` | Side Lunge | Lunge ngang | Thân dưới | Vừa | một bên |
| `power-squat` | Power Squat | Squat bật nhảy | Thân dưới | Khó | bật nhảy |
| `one-leg-squat-touch` | One-Leg Squat Touch | Squat một chân chạm sàn | Thân dưới | Khó | một bên |
| `chair-split-squat` | Chair Split Squat | Split squat gác chân lên ghế | Thân dưới | Vừa | một bên, cần ghế |
| `march-in-place` | March In Place | Bước tại chỗ | Toàn thân | Dễ |  |
| `chair-assist-squat` | Chair-Assist Squat | Squat có ghế hỗ trợ | Thân dưới | Dễ | cần ghế |
| `kneeling-push-up` | Kneeling Push-Up | Hít đất quỳ gối | Thân trên | Dễ |  |
| `kneeling-plank` | Kneeling Plank | Plank quỳ gối | Core | Dễ | giữ tư thế |
| `jump-rope-skip` | Jump Rope Skip | Nhảy dây không dây | Toàn thân | Dễ | bật nhảy |
| `chair-assist-split-squat` | Chair-Assist Split Squat | Split squat có ghế hỗ trợ | Thân dưới | Dễ | một bên, cần ghế |
| `kneeling-staggered-push-up` | Kneeling Staggered Push-Up | Hít đất quỳ gối tay so le | Thân trên | Dễ |  |
| `kneeling-side-plank` | Kneeling Side Plank | Plank nghiêng quỳ gối | Core | Dễ | một bên, giữ tư thế |
| `stand-and-box` | Stand & Box | Đứng đấm | Toàn thân | Dễ |  |
| `reverse-lunge` | Reverse Lunge | Lunge lùi | Thân dưới | Dễ |  |
| `chair-assist-push-up` | Chair-Assist Push-Up | Hít đất tựa ghế | Thân trên | Dễ | cần ghế |
| `swimmer` | Swimmer | Bơi cạn (nằm sấp đập tay chân) | Core | Dễ |  |
| `1-2-box-and-kick` | 1-2 Box & Kick | Đấm 1-2 và đá | Toàn thân | Vừa |  |
| `reverse-lunge-and-knee-lift` | Reverse Lunge & Knee Lift | Lunge lùi nâng gối | Thân dưới | Vừa |  |
| `power-push-up` | Power Push-Up | Hít đất bật | Thân trên | Vừa | bật nhảy |
| `reverse-crunch-and-hug` | Reverse Crunch & Hug | Gập bụng ngược ôm gối | Core | Vừa |  |
| `skater` | Skater | Bật ngang kiểu trượt băng | Toàn thân | Vừa | bật nhảy |
| `one-leg-squat-hops` | One-Leg Squat Hops | Squat một chân bật nhảy | Thân dưới | Vừa | một bên, bật nhảy |
| `downward-dog-grasshopper` | Downward Dog Grasshopper | Chó úp mặt kết hợp châu chấu | Thân trên | Vừa |  |
| `scissor-kicks` | Scissor Kicks | Đá chân cắt kéo | Core | Vừa |  |
| `lunge-touch-and-kick` | Lunge, Touch & Kick | Lunge chạm sàn và đá | Toàn thân | Vừa | một bên |
| `one-leg-deadlift` | One-Leg Deadlift | Deadlift một chân | Thân dưới | Vừa | một bên |
| `diamond-push-up` | Diamond Push-Up | Hít đất kim cương | Thân trên | Vừa |  |
| `v-sit-twist` | V Sit Twist | Ngồi chữ V xoay người | Core | Vừa |  |
| `squat-thrusts` | Squat Thrusts | Squat thrust | Toàn thân | Khó | bật nhảy |
| `one-leg-power-squat` | One-Leg Power Squat | Squat bật nhảy một chân | Thân dưới | Khó | một bên, bật nhảy |
| `chair-decline-push-up` | Chair Decline Push-Up | Hít đất gác chân lên ghế | Thân trên | Khó | cần ghế |
| `advanced-bird-dog` | Advanced Bird Dog | Bird dog nâng cao | Core | Khó |  |
| `drop-and-touch` | Drop & Touch | Hạ người chạm sàn | Toàn thân | Khó |  |
| `long-jumps` | Long Jumps | Bật xa | Thân dưới | Khó | bật nhảy |
| `bird-dog-push-up` | Bird Dog Push-Up | Hít đất kết hợp bird dog | Thân trên | Khó |  |
| `side-plank-crunch` | Side Plank Crunch | Plank nghiêng gập bụng | Core | Khó | một bên |
| `lateral-drop-and-touch` | Lateral Drop & Touch | Hạ người chạm sàn sang ngang | Toàn thân | Khó |  |
| `one-leg-wall-sit` | One-Leg Wall Sit | Ngồi tựa tường một chân | Thân dưới | Khó | một bên, giữ tư thế, cần tường |
| `chair-pike-push-up` | Chair Pike Push-Up | Hít đất pike gác chân lên ghế | Thân trên | Khó | cần ghế |
| `windscreen-wipers` | Windscreen Wipers | Gạt nước (nằm ngửa xoay chân) | Core | Khó |  |

### Workout

| # | id | English | Tiếng Việt | Mức | Vòng | Nghỉ | Bài/vòng | Thời lượng |
|---|---|---|---|---|---|---|---|---|
| 1 | `beginner-alternate-7` | Beginner 7 Minute, Alternate | 7 phút cho người mới, bài thay thế | Dễ | 1 | 5 giây | 12 | 6:55 |
| 2 | `original-7-minute` | Original 7 Minute Workout | 7 Minute Workout gốc | Dễ | 1 | 5 giây | 12 | 6:55 |
| 3 | `eight-minute` | 8 Minute Workout | Bài 8 phút | Dễ | 1 | 10 giây | 12 | 7:50 |
| 4 | `beginner-9-minute` | Beginner 9 Minute Workout | Bài 9 phút cho người mới | Dễ | 1 | 15 giây | 12 | 8:45 |
| 5 | `first-workout` | First Workout | Buổi tập đầu tiên | Dễ | 1 | 5 giây | 12 | 6:55 |
| 6 | `original-three-rounds` | Original, Three Rounds | Bài gốc, ba vòng | Dễ | 3 | 10 giây | 12 | 23:50 |
| 7 | `intermediate-16-minute` | Intermediate 16 Minute | Trung bình 16 phút | Vừa | 2 | 10 giây | 12 | 15:50 |
| 8 | `cardio-21-minute` | 21 Minute Cardio | Cardio 21 phút | Vừa | 3 | 5 giây | 12 | 20:55 |
| 9 | `beginner-plus` | Beginner Plus | Người mới, mức cao hơn | Vừa | 1 | 15 giây | 12 | 8:45 |
| 10 | `core-workout` | Core Workout | Bài tập core | Vừa | 3 | 15 giây | 12 | 26:45 |
| 11 | `easy-hard-easy` | Easy, Hard, Easy | Dễ, khó, dễ | Vừa | 1 | 5 giây | 36 | 20:55 |
| 12 | `rotating-levels` | Rotating Levels | Xoay vòng mức khó | Vừa | 1 | 10 giây | 36 | 23:50 |
| 13 | `strength-circuit` | Strength Circuit | Vòng sức mạnh | Vừa | 3 | 15 giây | 12 | 26:45 |
| 14 | `advanced-mix-21` | Advanced Mix 21 Minute | Tổng hợp nâng cao 21 phút | Khó | 3 | 5 giây | 12 | 20:55 |
| 15 | `advanced-21-minute` | Advanced 21 Minute | Nâng cao 21 phút | Khó | 3 | 5 giây | 12 | 20:55 |
| 16 | `expert-21-minute` | Expert 21 Minute | Chuyên sâu 21 phút | Khó | 3 | 5 giây | 12 | 20:55 |
| 17 | `power-24-minute` | 24 Minute Power | Sức bật 24 phút | Khó | 3 | 10 giây | 12 | 23:50 |
| 18 | `advanced-progression` | Advanced Progression | Tăng dần nâng cao | Khó | 2 | 10 giây | 24 | 31:50 |
| 19 | `power-and-balance` | Power and Balance | Sức bật và thăng bằng | Khó | 3 | 10 giây | 12 | 23:50 |
| 20 | `sports-conditioning` | Sports Conditioning | Thể lực thể thao | Khó | 3 | 5 giây | 12 | 20:55 |
| 21 | `endurance-circuit` | Endurance Circuit | Vòng sức bền | Khó | 3 | 10 giây | 12 | 23:50 |
| 22 | `mix-36` | 36 Move Mix | Tổng hợp 36 động tác | Khó | 1 | 10 giây | 36 | 23:50 |

### Mẫu Smart Workout

| id | Cấp | Vòng | Nghỉ | Dễ | Vừa | Khó |
|---|---|---|---|---|---|---|
| `level1-1` | 1 | 1 | 15 giây | 9 | 3 | 0 |
| `level1-2` | 1 | 2 | 15 giây | 9 | 3 | 0 |
| `level1-3` | 1 | 1 | 10 giây | 9 | 3 | 0 |
| `level1-4` | 1 | 2 | 10 giây | 9 | 3 | 0 |
| `level2-1` | 2 | 1 | 10 giây | 6 | 6 | 0 |
| `level2-2` | 2 | 2 | 15 giây | 6 | 6 | 0 |
| `level2-3` | 2 | 3 | 15 giây | 6 | 6 | 0 |
| `level3-1` | 3 | 2 | 10 giây | 4 | 4 | 4 |
| `level3-2` | 3 | 1 | 5 giây | 4 | 4 | 4 |
| `level3-3` | 3 | 2 | 5 giây | 4 | 4 | 4 |
| `level4-1` | 4 | 1 | 10 giây | 0 | 6 | 6 |
| `level4-2` | 4 | 2 | 15 giây | 0 | 6 | 6 |
| `level4-3` | 4 | 3 | 15 giây | 0 | 6 | 6 |
| `level4-4` | 4 | 2 | 10 giây | 0 | 6 | 6 |
| `level4-5` | 4 | 2 | 5 giây | 0 | 6 | 6 |
| `level5-1` | 5 | 2 | 5 giây | 0 | 3 | 9 |
| `level5-2` | 5 | 3 | 15 giây | 0 | 3 | 9 |
| `level5-3` | 5 | 3 | 10 giây | 0 | 3 | 9 |
| `level5-4` | 5 | 3 | 5 giây | 0 | 3 | 9 |
