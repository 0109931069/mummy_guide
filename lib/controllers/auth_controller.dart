
import 'package:flutter/material.dart';
import 'package:mummy_guide/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Controller class for authentication-related operations.
class AuthController {
  /// Stores authentication data securely.
  static Future<void> setAuth(Map<String, dynamic> data) async {
    try {
      await secureStorage.write(
        key: "is_logged_in",
        value: true.toString(),
      );
      await secureStorage.write(
        key: "login_email",
        value: data["email"].toString(),
      );
      await secureStorage.write(
        key: "login_password",
        value: data["password"].toString(),
      );
      await secureStorage.write(
        key: "uid",
        value: data["uid"].toString(),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Deletes stored authentication data.
  static Future<void> purgeAuth() async {
    try {
      await secureStorage.delete(key: "is_logged_in");
      await secureStorage.delete(key: "login_email");
      await secureStorage.delete(key: "login_password");
      await secureStorage.delete(key: "uid");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Creates a new user account with the provided data.
  static Future<Map<String, dynamic>> createAccount(
      Map<String, dynamic> data) async {
    try {
      var res = await Supabase.instance.client.auth.signUp(
        password: data["password"].toString(),
        email: data["email"].toString(),
        data: {
          ...data,
        },
      );

      if (res.user == null) {
        return {
          "result": false,
          "message": "Error while creating account.",
        };
      }

      await Supabase.instance.client.from("users").insert({
        "user_id": res.user!.id,
        "email": data["email"].toString().toLowerCase().trim(),
        "full_name": data["fullName"].toString(),
        "phone": data["phone"].toString(),
      });

      return {
        "result": true,
        "message": "Account created successfully.",
        "data": {
          ...res.user!.toJson(),
        },
      };
    } catch (e) {
      debugPrint(e.toString());
      return {
        "result": false,
        "message": e.toString(),
      };
    }
  }

  /// Logs in a user with email and password.
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      var res = await Supabase.instance.client.auth.signInWithPassword(
        password: password,
        email: email.toLowerCase().trim(),
      );

      if (res.user == null) {
        return {
          "result": false,
          "message": "Error while logging in.",
        };
      }

      await setAuth({
        "email": email.toLowerCase().trim(),
        "password": password,
        "uid": res.user!.id,
      });

      return {
        "result": true,
        "message": "Logged in successfully.",
        "data": {
          ...res.user!.toJson(),
        },
      };
    } on AuthException catch (e) {
      debugPrint(e.message.toString());
      return {
        "result": false,
        "message": e.message,
      };
    }
  }

  /// Checks if the user is logged in and returns user data.
  static Future<Map<String, dynamic>> checkLogin() async {
    try {
      bool isLoggedIn = (await secureStorage.read(key: "is_logged_in")) == null
          ? false
          : bool.parse((await secureStorage.read(key: "is_logged_in"))!);
      if (isLoggedIn == false) {
        return {
          "result": false,
          "message": "Please login again.",
        };
      }

      var email = await secureStorage.read(key: "login_email");
      var password = await secureStorage.read(key: "login_password");

      var res = await Supabase.instance.client.auth.signInWithPassword(
        password: password!,
        email: email!.toLowerCase().trim(),
      );

      if (res.user == null) {
        return {
          "result": false,
          "message": "Error while logging in.",
        };
      }

      return {
        "result": true,
        "message": "Logged in successfully.",
        "data": {
          ...res.user!.toJson(),
        },
      };
    } on AuthException catch (e) {
      debugPrint(e.message.toString());
      return {
        "result": false,
        "message": e.message,
      };
    }
  }

  /// Logs out the current user and clears stored auth data.
  static Future<void> logOut() async {
    try {
      try {
        await Supabase.instance.client.auth.signOut();
      } catch (e) {
        debugPrint(e.toString());
      }

      try {
        await purgeAuth();
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Retrieves current user data.
  static Future<Map<String, dynamic>> getCurrentUserData() async {
    try {
      var uid = await secureStorage.read(
        key: "uid",
      );

      if (uid == null) {
        return {
          "result": false,
          "message": "Please login again.",
        };
      }

      var res = Supabase.instance.client.auth.currentUser!.toJson();

      return {
        "result": true,
        "message": "Retrieved successfully.",
        "data": res,
      };
    } catch (e) {
      return {
        "result": false,
        "message": e.toString(),
      };
    }
  }

  /// Updates current user data with provided fields.
  static Future<Map<String, dynamic>> updateCurrentUserData(
      Map<String, dynamic> data) async {
    try {
      await Supabase.instance.client.auth.updateUser(UserAttributes(data: {
        ...data,
      }));

      return {
        "result": true,
        "message": "Updated successfully.",
      };
    } catch (e) {
      debugPrint(e.toString());
      return {
        "result": false,
        "message": e.toString(),
      };
    }
  }

  /// Sends a password reset email to the given email address.
  static Future<Map<String, dynamic>> forgetPassword(String email) async {
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(email.toLowerCase().trim());
      return {
        "result": true,
        "message": "Password reset link has been sent successfully to your email.",
      };
    } catch (e) {
      debugPrint(e.toString());
      return {
        "result": false,
        "message": e.toString(),
      };
    }
  }
}
