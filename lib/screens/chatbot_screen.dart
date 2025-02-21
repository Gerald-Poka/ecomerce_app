import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
// import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:uuid/uuid.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '1');
  final _bot = const types.User(id: '2', firstName: 'Bot');
  bool _isTyping = false;

  final List<Map<String, String>> questions = [
{
    "question": "How do I track my order?",
    "answer": "You can track your order in the 'History' section using your order number."
  },
  {
    "question": "What is your refund policy?",
    "answer": "You can request a refund within 14 days of receiving your product, provided it is in its original condition."
  },
  {
    "question": "Do you offer international shipping?",
    "answer": "Yes, we ship to over 100 countries. Additional fees may apply based on your location."
  },
  {
    "question": "How do I contact customer support?",
    "answer": "You can reach our customer support via the 'Contact Us' page or call us at 1-800-123-4567."
  },
  {
    "question": "What are your working hours?",
    "answer": "Our support team is available from 9 AM to 6 PM, Monday to Friday."
  },
  {
    "question": "Can I cancel my order?",
    "answer": "Yes, you can cancel your order within 24 hours of placing it. After that, cancellations may not be possible."
  },
  {
    "question": "How do I change my account password?",
    "answer": "Go to 'Account Settings' and click 'Change Password'. Follow the instructions to set a new password."
  },
  {
    "question": "What is your warranty policy?",
    "answer": "We offer a one-year warranty on all products. Please retain your proof of purchase for warranty claims."
  },
  {
    "question": "Do you offer discounts?",
    "answer": "Yes, we offer discounts during promotional periods. Subscribe to our newsletter to stay updated."
  },
  {
    "question": "Can I track my shipment in real-time?",
    "answer": "Yes, once your order is shipped, you'll receive a tracking link to monitor its progress."
  },
  // Add more questions here...

  ];

  final Map<String, String> commonMisspellings = {
    "trak": "track",
    "retun": "return",
    "adress": "address",
    "paypal": "PayPal",
    "bitcon": "Bitcoin",
  };

  final Map<String, String> keywordResponses = {
  'refund': "You can request a refund within 14 days of receiving your product. Do you need help initiating a refund?",
  'shipping': "We offer international shipping to over 100 countries. Fees may vary. Would you like to know about specific locations?",
  'support': "You can contact customer support through our 'Contact Us' page or by calling 1-800-123-4567.",
  'hours': "Our support team is available from 9 AM to 6 PM, Monday to Friday.",
  'discount': "We offer discounts during special promotions. Stay updated by subscribing to our newsletter.",
  'warranty': "Our products come with a one-year warranty. Do you need help with a warranty claim?",
  };

  String normalizeInput(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
        .trim(); // Remove extra spaces
  }

  String correctMisspellings(String input) {
    for (var typo in commonMisspellings.keys) {
      if (input.contains(typo)) {
        input = input.replaceAll(typo, commonMisspellings[typo]!);
      }
    }
    return input;
  }

  bool isOffensive(String query) {
    final offensiveWords = [
      "stupid",
      "idiot",
      "fool",
      "dumb",
      "shut up",
      "hate you",
    ];

    for (var word in offensiveWords) {
      if (query.toLowerCase().contains(word)) {
        return true;
      }
    }
    return false;
  }

  String getResponse(String query) {
    // Normalize input
    query = normalizeInput(query);

    // Correct common misspellings
    query = correctMisspellings(query);

    // Check for keyword matches
    for (var keyword in keywordResponses.keys) {
      if (query.contains(keyword)) {
        return keywordResponses[keyword]!;
      }
    }

    // Handle greetings
    if (query.contains("hi") || query.contains("hello")) {
      return "Hello! How can I assist you today?";
    }

    // Handle offensive messages
    if (isOffensive(query)) {
      return "I'm here to help. Please keep the conversation respectful.";
    }

    // Fuzzy matching fallback
    var bestMatch = extractOne(
      query: query,
      choices: questions.map((q) => q["question"]!).toList(),
    );

    if (bestMatch.score > 60) {
      return questions[bestMatch.index]["answer"]!;
    } else if (bestMatch.score > 40) {
      return "Did you mean '${bestMatch.match}'?";
    } else {
      return "I'm sorry, I don't understand. Here are some examples of questions I can answer:\n"
          "- How do I track my order?\n"
          "- What is your refund policy?\n"
          "- How do I contact customer support?";
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    // Simulate typing
    setState(() {
      _isTyping = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
      });

      String response = getResponse(message.text);

      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: response,
      );

      _addMessage(botMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
        backgroundColor: const Color(0xFFF0B90B),
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        iconTheme: IconThemeData(
          color: isDarkMode ? const Color.fromARGB(255, 223, 190, 2) : Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
              theme: DefaultChatTheme(
                primaryColor: const Color(0xFFF0B90B),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                inputBackgroundColor: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                inputTextColor: isDarkMode ? Colors.white : Colors.black,
                inputTextCursorColor: const Color(0xFFF0B90B),
                sentMessageBodyTextStyle: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                receivedMessageBodyTextStyle: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                secondaryColor: isDarkMode ? Colors.grey[700]! : Colors.white,
                messageInsetsVertical: 12,
                messageInsetsHorizontal: 12,
              ),
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF0B90B)),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Bot is typing...",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

extension on ExtractedResult<String> {
  get match => null;
}
