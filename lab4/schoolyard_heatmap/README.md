# Bản đồ nhiệt Sân trường (Schoolyard Heatmap)

Ứng dụng Flutter để khảo sát và trực quan hóa dữ liệu môi trường của sân trường bằng cảm biến di động.

## Mô tả

Ứng dụng "Bản đồ nhiệt Sân trường" cho phép bạn:
- Thu thập dữ liệu cảm biến real-time (gia tốc kế, từ kế, cảm biến ánh sáng)
- Ghi lại vị trí GPS chính xác
- Lưu trữ dữ liệu local dưới dạng JSON
- Trực quan hóa dữ liệu đã thu thập

## Tính năng chính

### 1. Trạm Khảo sát (Survey Station)
- Hiển thị dữ liệu cảm biến real-time:
  - **Cường độ Ánh sáng**: Đo bằng lux với icon mặt trời
  - **Độ Năng động**: Tính toán độ lớn vector gia tốc với icon bước chân
  - **Cường độ Từ trường**: Đo bằng microTesla (μT) với icon nam châm
- Nút "Ghi Dữ liệu tại Điểm này" để lưu:
  - Tọa độ GPS (kinh độ, vĩ độ)
  - Tất cả giá trị cảm biến hiện tại
  - Timestamp

### 2. Bản đồ Dữ liệu (Data Map)
- Hiển thị danh sách tất cả điểm đã khảo sát
- Mỗi card hiển thị:
  - Tọa độ GPS
  - Giá trị cảm biến với màu sắc trực quan
  - Thời gian ghi dữ liệu
- Tổng quan thống kê dữ liệu
- Tính năng xóa dữ liệu

## Cài đặt và Chạy

### Yêu cầu
- Flutter SDK (version 3.9.2+)
- Android Studio hoặc VS Code
- Thiết bị Android với các cảm biến cần thiết

### Các bước cài đặt

1. **Clone dự án**
```bash
git clone <repository-url>
cd schoolyard_heatmap
```

2. **Cài đặt dependencies**
```bash
flutter pub get
```

3. **Tạo file JSON serialization**
```bash
flutter packages pub run build_runner build
```

4. **Chạy ứng dụng**
```bash
flutter run
```

## Quyền cần thiết

Ứng dụng yêu cầu các quyền sau:
- `ACCESS_FINE_LOCATION`: Để lấy vị trí GPS chính xác
- `ACCESS_COARSE_LOCATION`: Để lấy vị trí GPS gần đúng
- `WRITE_EXTERNAL_STORAGE`: Để lưu dữ liệu
- `READ_EXTERNAL_STORAGE`: Để đọc dữ liệu

## Hướng dẫn sử dụng

### Giai đoạn 1: Thu thập dữ liệu
1. Mở ứng dụng và chọn "Trạm Khảo sát"
2. Đảm bảo GPS được bật và cấp quyền
3. Di chuyển đến các vị trí khác nhau trong sân trường
4. Quan sát dữ liệu cảm biến thay đổi real-time
5. Nhấn "Ghi Dữ liệu tại Điểm này" để lưu

### Giai đoạn 2: Xem dữ liệu
1. Chọn "Bản đồ Dữ liệu" từ màn hình chính
2. Xem danh sách tất cả điểm đã khảo sát
3. Phân tích dữ liệu và tìm các mẫu thú vị

## Gợi ý khảo sát

### Các điểm nên khảo sát:
- **Điểm sáng nhất**: Giữa sân trường vào lúc trời nắng
- **Điểm tối nhất**: Dưới tán cây rậm rạp hoặc góc khuất
- **Điểm tĩnh nhất**: Góc yên tĩnh, không có ai qua lại
- **Điểm năng động nhất**: Gần sân bóng, khu vực có nhiều người
- **Điểm có từ trường bất thường**: Gần cột cờ, hàng rào sắt, nắp cống kim loại

### Mục tiêu khảo sát:
- Thu thập ít nhất 15 điểm dữ liệu
- Khảo sát các vị trí có đặc điểm khác nhau
- Quan sát sự thay đổi của dữ liệu khi di chuyển

## Cấu trúc Dự án

```
lib/
├── main.dart                 # Entry point của ứng dụng
├── models/
│   ├── survey_point.dart    # Model cho điểm khảo sát
│   └── sensor_data.dart     # Model cho dữ liệu cảm biến
├── services/
│   ├── sensor_service.dart  # Xử lý cảm biến
│   ├── location_service.dart # Xử lý GPS
│   └── data_storage_service.dart # Lưu trữ dữ liệu
└── screens/
    ├── survey_station_screen.dart # Màn hình khảo sát
    └── data_map_screen.dart       # Màn hình xem dữ liệu
```

## Dependencies chính

- `sensors_plus`: Đọc dữ liệu cảm biến
- `location`: Lấy vị trí GPS
- `path_provider`: Lưu trữ file local
- `permission_handler`: Xử lý quyền
- `json_annotation` & `json_serializable`: Serialization JSON

## Lưu ý kỹ thuật

- Cảm biến ánh sáng được mô phỏng dựa trên thời gian trong ngày
- Dữ liệu được lưu trong file `schoolyard_map_data.json` trong thư mục Documents
- Ứng dụng sử dụng Material Design 3
- Hỗ trợ theme động và responsive design

## Phân tích dữ liệu

Sau khi thu thập dữ liệu, hãy trả lời các câu hỏi:
1. Khu vực nào có cường độ ánh sáng cao nhất/thấp nhất? Tại sao?
2. Dữ liệu về độ "Năng động" có phản ánh đúng thực tế không?
3. Có điểm nào có từ trường cao bất thường không? Nằm gần vật thể gì?

## Báo cáo

Chụp ảnh màn hình "Bản đồ Dữ liệu" và viết báo cáo ngắn mô tả những phát hiện thú vị.
