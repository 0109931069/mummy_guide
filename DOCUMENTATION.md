# Mummy Guide Project Documentation

## 1. Project Overview

- **Flutter SDK Version:** >=3.27.0
- **Dart SDK Version:** >=3.6.0 <4.0.0

## 2. Libraries Used

| Library Name            | Version  | Description                                                                                  |
|------------------------|----------|----------------------------------------------------------------------------------------------|
| adaptive_theme         | 3.7.0    | Provides dynamic theme switching and persistence for Flutter apps.                          |
| animate_do             | 4.2.0    | A package for easily adding animations to Flutter widgets.                                  |
| animated_text_kit      | 4.2.3    | A collection of cool and beautiful text animations for Flutter.                             |
| cached_network_image   | 3.4.1    | Displays images from the internet and caches them for faster reloads.                       |
| carousel_slider        | 5.0.0    | A carousel slider widget for Flutter.                                                       |
| cupertino_icons        | 1.0.8    | The official Cupertino icons for Flutter.                                                  |
| dots_indicator         | 4.0.1    | A dots indicator widget for Flutter, often used with PageView.                             |
| flick_video_player     | 0.9.0    | A video player widget with gesture controls and customizable UI.                           |
| flutter_animate        | 4.5.2    | A simple and powerful animation package for Flutter.                                       |
| flutter_dotenv         | 5.2.1    | Loads environment variables from a .env file.                                              |
| flutter_localization   | 0.3.2    | Provides localization support for Flutter apps.                                            |
| flutter_osm_plugin     | 1.3.7    | OpenStreetMap plugin for Flutter with map features.                                        |
| flutter_reaction_button| 3.0.0+3  | Reaction button widget for Flutter, similar to social media reactions.                     |
| flutter_secure_storage | 9.2.4    | Provides secure storage for sensitive data on iOS and Android.                             |
| flutter_typeahead      | 5.2.0    | A Flutter widget for auto-complete and typeahead functionality.                            |
| fluttertoast           | 8.2.12   | Toast messages for Flutter apps.                                                          |
| google_fonts           | 6.2.1    | Use fonts from fonts.google.com in your Flutter app.                                      |
| image_picker           | 1.1.2    | Flutter plugin for selecting images from the gallery or camera.                            |
| path                   | 1.9.0    | Provides common operations for manipulating paths.                                        |
| persistent_bottom_nav_bar | 6.2.1 | A customizable persistent bottom navigation bar.                                          |
| photo_view             | 0.15.0   | A simple photo viewer with zooming and panning.                                           |
| provider               | 6.1.4    | State management library for Flutter apps.                                                |
| supabase_flutter       | 2.8.4    | Supabase client for Flutter, providing backend services.                                  |
| swipe_refresh          | 1.1.2    | Pull-to-refresh widget for Flutter.                                                      |
| timeago                | 3.7.0    | A library to format dates as "time ago" strings.                                          |
| video_player           | 2.9.5    | Flutter plugin for playing videos on iOS, Android, and web.                               |

## 3. Key Functions

### lib/main.dart

- **main()**: Initializes Flutter bindings, loads environment variables, initializes Supabase and localization, sets up providers, and runs the app.
- **MyApp**: Root widget of the application, sets up localization, theme, and routes.
- **MyAppState.initState()**: Initializes localization and sets language change callback.
- **MyAppState._onTranslatedLanguage(Locale? locale)**: Updates state on language change.
- **MyAppState.build(BuildContext context)**: Builds MaterialApp with routes and localization support.

### lib/controllers/auth_controller.dart

- **setAuth(Map<String, dynamic> data)**: Stores authentication data securely.
- **purgeAuth()**: Clears stored authentication data.
- **createAccount(Map<String, dynamic> data)**: Creates a new user account using Supabase.
- **login(String email, String password)**: Logs in a user using Supabase.
- **checkLogin()**: Checks if the user is logged in and validates the session.
- **logOut()**: Logs out the user and clears authentication data.
- **getCurrentUserData()**: Retrieves current logged-in user data.
- **updateCurrentUserData(Map<String, dynamic> data)**: Updates current user data.
- **forgetPassword(String Email)**: Sends a password reset email.

### lib/controllers/posts_controller.dart

- **getAllPosts()**: Fetches all posts from the backend.
- **addPost(Map<String, dynamic> data)**: Adds a new post with user metadata and timestamps.
- **uploadPostMedia(File file)**: Uploads media file to storage and returns public URL.

---

This documentation provides an overview of the project setup, dependencies, and key functions with their purposes.
