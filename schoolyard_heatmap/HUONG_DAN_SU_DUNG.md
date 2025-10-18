# HƯỚNG DẪN SỬ DỤNG ỨNG DỤNG "BẢN ĐỒ NHIỆT SÂN TRƯỜNG"

## 🎯 MỤC TIÊU BÀI TẬP

Xây dựng và sử dụng ứng dụng Flutter để khảo sát dữ liệu môi trường sân trường, bao gồm:
- Cường độ ánh sáng
- Độ năng động (gia tốc kế)
- Cường độ từ trường

## 📱 CÁCH SỬ DỤNG ỨNG DỤNG

### Bước 1: Khởi động ứng dụng
1. Mở ứng dụng "Bản đồ nhiệt Sân trường"
2. Bạn sẽ thấy màn hình chính với 2 nút:
   - **Trạm Khảo sát**: Để thu thập dữ liệu
   - **Bản đồ Dữ liệu**: Để xem dữ liệu đã thu thập

### Bước 2: Cấp quyền
1. Nhấn vào "Trạm Khảo sát"
2. Ứng dụng sẽ yêu cầu quyền truy cập vị trí
3. **Chọn "Cho phép"** để ứng dụng có thể lấy tọa độ GPS

### Bước 3: Thu thập dữ liệu
1. **Di chuyển ra sân trường** với điện thoại
2. **Quan sát màn hình** - bạn sẽ thấy 3 chỉ số thay đổi real-time:
   - 🌞 **Cường độ Ánh sáng**: Icon mặt trời với màu sắc thay đổi
   - 🚶 **Độ Năng động**: Icon bước chân (càng đỏ = càng năng động)
   - 🧲 **Cường độ Từ trường**: Icon nam châm (càng xanh đậm = từ trường càng mạnh)

3. **Đến các vị trí khác nhau** và nhấn nút **"Ghi Dữ liệu tại Điểm này"**
4. Mỗi lần nhấn sẽ lưu:
   - Tọa độ GPS chính xác
   - Giá trị cảm biến hiện tại
   - Thời gian ghi dữ liệu

## 🗺️ CÁC ĐIỂM NÊN KHẢO SÁT

### 1. Điểm sáng nhất
- **Vị trí**: Giữa sân trường, nơi có ánh nắng trực tiếp
- **Mục tiêu**: Tìm nơi có cường độ ánh sáng cao nhất
- **Gợi ý**: Vào lúc trời nắng (10h-14h)

### 2. Điểm tối nhất
- **Vị trí**: Dưới tán cây rậm rạp, góc khuất
- **Mục tiêu**: Tìm nơi có cường độ ánh sáng thấp nhất
- **Gợi ý**: Dưới cây bàng, cây phượng

### 3. Điểm tĩnh nhất
- **Vị trí**: Góc yên tĩnh, không có ai qua lại
- **Mục tiêu**: Đặt điện thoại xuống đất, chờ giá trị "Năng động" ổn định ở mức thấp
- **Gợi ý**: Góc sân trường, xa khu vực hoạt động

### 4. Điểm năng động nhất
- **Vị trí**: Gần sân bóng, khu vực có nhiều người
- **Mục tiêu**: Cầm điện thoại trên tay và đi bộ quanh khu vực
- **Gợi ý**: Gần sân bóng rổ, cổng trường

### 5. Điểm có từ trường bất thường
- **Vị trí**: Gần các vật thể kim loại lớn
- **Mục tiêu**: Quan sát sự thay đổi của giá trị Từ kế
- **Gợi ý**: 
  - Cột cờ
  - Cột gôn
  - Hàng rào sắt
  - Nắp cống kim loại
  - Cổng sắt

## 📊 PHÂN TÍCH DỮ LIỆU

### Bước 1: Xem dữ liệu đã thu thập
1. Quay lại màn hình chính
2. Nhấn **"Bản đồ Dữ liệu"**
3. Xem danh sách tất cả điểm đã khảo sát

### Bước 2: Quan sát các pattern
Mỗi card sẽ hiển thị:
- **Tọa độ GPS**: Vị trí chính xác
- **Thời gian**: Khi nào ghi dữ liệu
- **3 chỉ số cảm biến** với màu sắc trực quan

### Bước 3: Trả lời câu hỏi phân tích
1. **Khu vực nào có cường độ ánh sáng cao nhất và thấp nhất? Tại sao?**
   - So sánh giá trị lux giữa các điểm
   - Giải thích dựa trên vị trí (có bóng râm hay không)

2. **Dữ liệu về độ "Năng động" có phản ánh đúng thực tế không?**
   - So sánh giá trị gia tốc giữa điểm tĩnh và điểm năng động
   - Giải thích sự khác biệt

3. **Bạn có tìm thấy điểm nào có từ trường cao bất thường không? Nó nằm ở gần vật thể gì?**
   - Tìm điểm có giá trị μT cao nhất
   - Mô tả vật thể kim loại gần đó

## 📝 VIẾT BÁO CÁO

### Nội dung báo cáo cần có:
1. **Ảnh chụp màn hình** "Bản đồ Dữ liệu"
2. **Số lượng điểm** đã khảo sát
3. **Phân tích** trả lời 3 câu hỏi trên
4. **Phát hiện thú vị** trong quá trình khảo sát
5. **Kết luận** về đặc điểm môi trường sân trường

### Gợi ý viết báo cáo:
- Dùng ngôn ngữ khoa học nhưng dễ hiểu
- Có số liệu cụ thể (giá trị lux, μT, gia tốc)
- Giải thích nguyên nhân của các hiện tượng quan sát được
- So sánh giữa các vị trí khác nhau

## ⚠️ LƯU Ý QUAN TRỌNG

### Khi thu thập dữ liệu:
- **Đảm bảo GPS được bật** trên điện thoại
- **Di chuyển chậm** để GPS định vị chính xác
- **Chờ 2-3 giây** sau khi đến vị trí mới trước khi ghi dữ liệu
- **Ghi ít nhất 15 điểm** tại các vị trí khác nhau

### Khi phân tích:
- **Quan sát màu sắc** của các icon để hiểu giá trị tương đối
- **So sánh** giữa các điểm có đặc điểm tương tự
- **Ghi chú** vị trí và đặc điểm của từng điểm khi khảo sát

### Xử lý sự cố:
- Nếu không lấy được GPS: Di chuyển ra nơi thoáng hơn
- Nếu cảm biến không hoạt động: Khởi động lại ứng dụng
- Nếu dữ liệu không lưu: Kiểm tra quyền lưu trữ

## 🎓 MỤC TIÊU HỌC TẬP

Sau khi hoàn thành bài tập này, bạn sẽ:
- Hiểu cách hoạt động của các cảm biến di động
- Biết cách thu thập và phân tích dữ liệu môi trường
- Có kinh nghiệm sử dụng Flutter để xây dựng ứng dụng cảm biến
- Phát triển kỹ năng quan sát và phân tích khoa học

**Chúc bạn khảo sát thành công! 🌟**


