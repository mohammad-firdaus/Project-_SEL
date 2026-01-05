import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GeminiaiChatbot extends StatelessWidget {
  const GeminiaiChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    // Return ChatScreen directly without MaterialApp wrapper
    // This allows the back button to work properly
    return ChatScreen();
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  List<Map<String, dynamic>> messages = [];
  bool isTyping = false;
  bool showWelcome = true;

  final Color primaryGreen = const Color(0xFF42B642);
  final Color lightGreen = const Color(0xFF4DB6AC);
  final Color darkGreen = const Color(0xFF2E7D32);

  @override
  void initState() {
    super.initState();
    // Add welcome message
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted && showWelcome) {
        setState(() {
          messages.add({
            "sender": "bot",
            "text":
            "👋 Hello! I'm your Waste2Wealth AI assistant. How can I help you today?",
            "timestamp": DateTime.now(),
          });
          showWelcome = false;
        });
        scrollToBottom();
      }
    });
  }

  Future<String> sendToGemini(String userMessage) async {
    const String apiKey = "AIzaSyA_n7ECYbbZ7QYxtZfGrCxrBxLQUyI8sow";

    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent?key=$apiKey",
    );

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userMessage},
              ],
            },
          ],
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        return "I apologize, but I'm having trouble connecting right now. Please try again in a moment.";
      }
    } catch (e) {
      return "I encountered an error. Please check your connection and try again.";
    }
  }

  void sendMessage() async {
    String text = controller.text.trim();
    if (text.isEmpty) return;

    // Haptic feedback
    HapticFeedback.lightImpact();

    setState(() {
      messages.add({
        "sender": "user",
        "text": text,
        "timestamp": DateTime.now(),
      });
      isTyping = true;
    });

    controller.clear();
    scrollToBottom();

    String reply = await sendToGemini(text);

    setState(() {
      isTyping = false;
      messages.add({
        "sender": "bot",
        "text": reply.trim(),
        "timestamp": DateTime.now(),
      });
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  Widget buildMessageBubble(Map<String, dynamic> msg, int index) {
    final isUser = msg["sender"] == "user";
    final text = msg["text"] as String;
    final timestamp = msg["timestamp"] as DateTime?;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          child: Column(
            crossAxisAlignment: isUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                decoration: BoxDecoration(
                  gradient: isUser
                      ? LinearGradient(
                    colors: [primaryGreen, darkGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  color: isUser ? null : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(isUser ? 20 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isUser
                          ? primaryGreen.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: isUser
                    ? Text(
                  // Keep standard Text for the User (users usually don't type Markdown)
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.4,
                  ),
                )
                    : MarkdownBody(
                  // Use Markdown for the AI Bot
                  data: text,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      height: 1.4,
                    ),
                    // This ensures the bold text is still readable
                    strong: TextStyle(fontWeight: FontWeight.bold),
                    listBullet: TextStyle(color: darkGreen),
                  ),
                ),
              ),
              if (timestamp != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 12, right: 12),
                  child: Text(
                    formatTime(timestamp),
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryGreen, lightGreen],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.smart_toy, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  "AI is thinking",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                const AnimatedDots(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSuggestionChips() {
    final suggestions = [
      "Tell me about eco-friendly products",
      "How can I reduce waste?",
      "What are your best sellers?",
      "Sustainability tips",
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Icon(Icons.eco, size: 64, color: primaryGreen.withOpacity(0.3)),
          SizedBox(height: 16),
          Text(
            "How can I help you today?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: suggestions.map((suggestion) {
              return ActionChip(
                label: Text(suggestion),
                onPressed: () {
                  controller.text = suggestion;
                  sendMessage();
                },
                backgroundColor: primaryGreen.withOpacity(0.1),
                labelStyle: TextStyle(color: primaryGreen, fontSize: 13),
                side: BorderSide(color: primaryGreen.withOpacity(0.3)),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.smart_toy, size: 20),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AI Assistant",
                  style: TextStyle(
                    fontFamily: 'MomoSignature',
                    fontSize: 20,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Always here to help",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryGreen, darkGreen],
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryGreen.withOpacity(0.05), Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: messages.isEmpty && !showWelcome
                  ? buildSuggestionChips()
                  : ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length + (isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isTyping && index == messages.length) {
                    return buildTypingIndicator();
                  }
                  return buildMessageBubble(messages[index], index);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: focusNode.hasFocus
                                ? primaryGreen.withOpacity(0.5)
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: "Ask me anything...",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            suffixIcon: controller.text.isNotEmpty
                                ? IconButton(
                              icon: Icon(Icons.clear, size: 20),
                              onPressed: () {
                                controller.clear();
                                setState(() {});
                              },
                              color: Colors.grey[600],
                            )
                                : null,
                          ),
                          style: TextStyle(fontSize: 15),
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) => setState(() {}),
                          onSubmitted: (value) => sendMessage(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryGreen, darkGreen],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryGreen.withOpacity(0.4),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: controller.text.trim().isEmpty
                              ? null
                              : sendMessage,
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

/// Animated three dots for typing indicator
class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  _AnimatedDotsState createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<int> dotAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
    dotAnimation = IntTween(begin: 0, end: 4).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: dotAnimation,
      builder: (context, child) {
        String dots = "." * dotAnimation.value;
        return SizedBox(
          width: 20,
          child: Text(
            dots,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}