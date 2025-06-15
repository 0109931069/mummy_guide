import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:http/http.dart' as http;

class PDFViewerScreen extends StatefulWidget {
  static String id = 'pdfviewerscreen';
  final String pdfUrl;

  const PDFViewerScreen({super.key, required this.pdfUrl});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localPath;
  bool isLoading = true;
  bool isPortrait = true;

  PDFViewController? pdfViewController;
  List<int> bookmarks = [];

  @override
  void initState() {
    super.initState();
    downloadPdf();
    loadBookmarks();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Future<void> downloadPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      final bytes = response.bodyBytes;

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/temp.pdf');
      await file.writeAsBytes(bytes, flush: true);

      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      // معالجة الخطأ حسب الحاجة
    }
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('pdf_bookmarks') ?? [];
    setState(() {
      bookmarks = savedList.map(int.parse).toList();
    });
  }

  Future<void> saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = bookmarks.map((e) => e.toString()).toList();
    await prefs.setStringList('pdf_bookmarks', stringList);
  }

  void toggleOrientation() {
    if (isPortrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    setState(() {
      isPortrait = !isPortrait;
    });
  }

  void addBookmark(int page) async {
    if (!bookmarks.contains(page)) {
      setState(() {
        bookmarks.add(page);
      });
      await saveBookmarks();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم حفظ الإشارة على الصفحة $page')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الصفحة $page موجودة بالفعل في الإشارات')),
      );
    }
  }

  void goToPage(int page) {
    Navigator.pop(context); // اغلق صفحة الإشارات
    pdfViewController?.setPage(page);
  }

  void showBookmarksDialog() {
    showDialog(
      context: context,
      builder: (context) {
        if (bookmarks.isEmpty) {
          return AlertDialog(
            title: const Text('الإشارات المرجعية'),
            content: const Text('لا توجد إشارات محفوظة حتى الآن.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('حسناً'),
              ),
            ],
          );
        }

        return AlertDialog(
          title: const Text('الإشارات المرجعية'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final page = bookmarks[index];
                return ListTile(
                  title: Text('الصفحة $page'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      setState(() {
                        bookmarks.removeAt(index);
                      });
                      await saveBookmarks();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      showBookmarksDialog();
                    },
                  ),
                  onTap: () => goToPage(page),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قراءة الكتاب'),
        backgroundColor: Colors.pink[100],
        actions: [
          IconButton(
            icon: Icon(
              isPortrait ? Icons.screen_rotation : Icons.screen_lock_rotation,
            ),
            tooltip: isPortrait ? 'اقلب الشاشة للعرض' : 'اقلب الشاشة للطول',
            onPressed: toggleOrientation,
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            tooltip: 'إضافة إشارة مرجعية',
            onPressed: () {
              if (pdfViewController != null) {
                pdfViewController!.getCurrentPage().then((page) {
                  if (page != null) {
                    addBookmark(page);
                  }
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmarks),
            tooltip: 'عرض الإشارات المرجعية',
            onPressed: showBookmarksDialog,
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFView(
                filePath: localPath!,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: true,
                onViewCreated: (PDFViewController controller) {
                  pdfViewController = controller;
                },
                onPageChanged: (int? page, int? total) {
                  // لو حبيت تحفظ الصفحة تلقائياً هنا
                },
                onError: (error) => Center(child: Text(error.toString())),
                onPageError:
                    (page, error) =>
                        Center(child: Text('$page: ${error.toString()}')),
              ),
    );
  }
}
