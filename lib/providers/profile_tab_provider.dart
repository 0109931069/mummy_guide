import 'package:flutter/cupertino.dart';
import 'package:mummy_guide/controllers/auth_controller.dart';

/// Provider for managing profile tab state and user data.
class ProfileTabProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _photoUrl = "";
  String get photoUrl => _photoUrl;

  String _email = "test@gmail.com";
  String get email => _email;

  String _username = "Test User";
  String get username => _username;

  String _phone = "0192398483484";
  String get phone => _phone;

  /// Toggles the loading state and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Updates the user's profile picture URL.
  Future<void> updateUserProfilePicture(String url) async {
    _setLoading(true);

    try {
      var res = await AuthController.updateCurrentUserData({
        "picUrl": url,
      });
      if (res["result"] == true) {
        _photoUrl = url;
        notifyListeners();
      }
    } catch (e) {
      // Consider logging error instead of print
    } finally {
      _setLoading(false);
    }
  }

  /// Fetches the current user data and updates the provider state.
  Future<void> getUserData() async {
    try {
      var res = await AuthController.getCurrentUserData();
      if (res["result"] == true) {
        var userData = res["data"]["user_metadata"];

        _email = userData["email"].toString();
        _username = userData["fullName"].toString();
        _phone = userData["phone"].toString();
        _photoUrl =
            userData["picUrl"] == null ? "" : userData["picUrl"].toString();

        notifyListeners();
      }
    } catch (e) {
      // Consider logging error instead of print
    }
  }

  /// Fetches user data and manages loading state.
  Future<void> getData() async {
    _setLoading(true);

    try {
      await getUserData();
    } catch (e) {
      // Consider logging error instead of print
    } finally {
      _setLoading(false);
    }
  }
}
