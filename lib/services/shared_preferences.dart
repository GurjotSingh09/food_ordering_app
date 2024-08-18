import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{

  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userWalletKey = "USERWALLETKEY";
  static String userProfileKey = "USERWALLETKEY";


  Future<bool> saveUserId(String getUserId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserMail(String getUserMail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserMail);
  }

  Future<bool> saveUserWallet(String getUserWallet) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userWalletKey, getUserWallet);
  }
  Future<bool> saveUserProfile(String getUserProfile) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfileKey, getUserProfile);
  }


  Future<String?> getUserId()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUserName()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserMail()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserWallet()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(userWalletKey);
  }
  Future<String?> getUserProfile()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfileKey);
  }
}