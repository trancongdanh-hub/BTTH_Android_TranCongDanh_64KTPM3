import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class StorageService {
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userPhoneKey = 'user_phone';
  static const String _userPasswordKey = 'user_password';
  static const String _userBirthDateKey = 'user_birth_date';
  static const String _userGenderKey = 'user_gender';

  // Save user data to SharedPreferences
  static Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, user.name);
    await prefs.setString(_userEmailKey, user.email);
    await prefs.setString(_userPhoneKey, user.phone);
    await prefs.setString(_userPasswordKey, user.password);
    await prefs.setString(_userBirthDateKey, user.birthDate);
    await prefs.setString(_userGenderKey, user.gender);
  }

  // Get user data from SharedPreferences
  static Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    
    final name = prefs.getString(_userNameKey);
    final email = prefs.getString(_userEmailKey);
    final phone = prefs.getString(_userPhoneKey);
    final password = prefs.getString(_userPasswordKey);
    final birthDate = prefs.getString(_userBirthDateKey);
    final gender = prefs.getString(_userGenderKey);

    // Check if all required data exists
    if (name != null && 
        email != null && 
        phone != null && 
        password != null && 
        birthDate != null && 
        gender != null) {
      return UserModel(
        name: name,
        email: email,
        phone: phone,
        password: password,
        birthDate: birthDate,
        gender: gender,
      );
    }
    
    return null;
  }

  // Clear user data
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userPhoneKey);
    await prefs.remove(_userPasswordKey);
    await prefs.remove(_userBirthDateKey);
    await prefs.remove(_userGenderKey);
  }

  // Check if user data exists
  static Future<bool> hasUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userNameKey) &&
           prefs.containsKey(_userEmailKey) &&
           prefs.containsKey(_userPhoneKey) &&
           prefs.containsKey(_userPasswordKey) &&
           prefs.containsKey(_userBirthDateKey) &&
           prefs.containsKey(_userGenderKey);
  }
}



