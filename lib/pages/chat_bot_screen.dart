import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:/lib/constants.dart';
import 'package:mummy_guide/constants.dart';

class ChatBotPage extends StatefulWidget {
  static String id = 'ChatbotPage';
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _userMessage = TextEditingController();
  final List<Message> _messages = [];

  static const apiKey =
      "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";

  List<Map<String, String>> getChatHistory() {
    List<Map<String, String>> history = [
      {
        "role": "system",
        "content":
            "أنت مساعد تربوي يساعد الأمهات ويقدم نصائح متصلة بناءً على سياق الحديث. قم بالرد بنفس لغة المستخدم.",
      },
    ];

    for (var m in _messages) {
      history.add({
        "role": m.isUser ? "user" : "assistant",
        "content": m.message,
      });
    }

    return history;
  }

  Future<void> sendMessage() async {
    final message = _userMessage.text.trim();
    if (message.isEmpty) return;
    _userMessage.clear();

    setState(() {
      _messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
    });

    try {
      final url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      };

      final body = jsonEncode({
        "model": "llama3-70b-8192",
        "messages": [
          ...getChatHistory(),
          {"role": "user", "content": message},
        ],
        "temperature": 0.7,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final reply = responseData["choices"][0]["message"]["content"];

        setState(() {
          _messages.add(
            Message(isUser: false, message: reply, date: DateTime.now()),
          );
        });
      } else {
        throw Exception(
          "Status Code: ${response.statusCode}\n${response.body}",
        );
      }
    } catch (e) {
      setState(() {
        _messages.add(
          Message(
            isUser: false,
            message: "❌ Error: ${e.toString()}",
            date: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.pink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: kBackgroundColor,
                backgroundImage: const AssetImage(
                  'assets/images/2-removebg-preview (1) 1.png',
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MummyGuide',
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: const [
                    Icon(Icons.circle, size: 8, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      'Online',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: TextFormField(
                    controller: _userMessage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: kBackgroundColor),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      label: const Text("اسأل مامي جايد..."),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: const EdgeInsets.all(15),
                  iconSize: 20,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xffFF8EA2)),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(const CircleBorder()),
                  ),
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ).copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
        color: isUser ? Color(0xffFFC1CC) : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          bottomLeft: isUser ? const Radius.circular(30) : Radius.zero,
          topRight: const Radius.circular(30),
          bottomRight: isUser ? Radius.zero : const Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: message,
            styleSheet: MarkdownStyleSheet.fromTheme(
              Theme.of(context),
            ).copyWith(
              p: TextStyle(
                color: isUser ? Colors.white : Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: TextStyle(
              color: isUser ? Colors.white70 : Colors.black54,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}
