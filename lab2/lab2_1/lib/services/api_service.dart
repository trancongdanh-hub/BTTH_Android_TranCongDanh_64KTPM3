import 'dart:async';

class ApiService {
  static const Duration _networkDelay = Duration(seconds: 1);

  /// Kiểm tra kết nối mạng (giả lập)
  static Future<bool> checkNetworkConnection() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true; // luôn có mạng để test
  }

  static Future<Map<String, dynamic>> sendOTP(String email) async {
    try {
      final hasConnection = await checkNetworkConnection();
      if (!hasConnection) {
        throw Exception('Không có kết nối mạng. Vui lòng kiểm tra lại.');
      }

      await Future.delayed(_networkDelay);

      return {
        'success': true,
        'message': 'Mã OTP đã được gửi đến email $email',
        'otp': '123456',
        'expires_in': 300,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
        'error_code': 'SEND_OTP_FAILED',
      };
    }
  }

  static Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    try {
      final hasConnection = await checkNetworkConnection();
      if (!hasConnection) {
        throw Exception('Không có kết nối mạng. Vui lòng kiểm tra lại.');
      }

      await Future.delayed(const Duration(milliseconds: 800));

      if (otp == '123456') {
        return {
          'success': true,
          'message': 'Xác minh OTP thành công',
          'user_verified': true,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
      } else {
        return {
          'success': false,
          'message': 'Mã OTP không đúng hoặc đã hết hạn',
          'error_code': 'INVALID_OTP',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
        'error_code': 'VERIFY_OTP_FAILED',
      };
    }
  }

  static Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
    try {
      final hasConnection = await checkNetworkConnection();
      if (!hasConnection) {
        throw Exception('Không có kết nối mạng. Vui lòng kiểm tra lại.');
      }

      await Future.delayed(const Duration(seconds: 1));

      if (userData['email'] == null || userData['email'].isEmpty) {
        throw Exception('Email không được để trống');
      }
      if (userData['phone'] == null || userData['phone'].isEmpty) {
        throw Exception('Số điện thoại không được để trống');
      }

      final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';

      return {
        'success': true,
        'message': 'Đăng ký thành công. Vui lòng xác minh email.',
        'user_id': userId,
        'email': userData['email'],
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
        'error_code': 'REGISTER_FAILED',
      };
    }
  }
}

