import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RichText Example',
      debugShowCheckedModeBanner: false,
      home: const RichTextPage(),
    );
  }
}

class RichTextPage extends StatefulWidget {
  const RichTextPage({super.key});
  @override
  State<RichTextPage> createState() => _RichTextPageState();
}

class _RichTextPageState extends State<RichTextPage> {
  late TapGestureRecognizer _emailRecognizer;
  late TapGestureRecognizer _phoneRecognizer;
  late TapGestureRecognizer _blogRecognizer;

  @override
  void initState() {
    super.initState();
    _emailRecognizer = TapGestureRecognizer()..onTap = _onEmailTap;
    _phoneRecognizer = TapGestureRecognizer()..onTap = _onPhoneTap;
    _blogRecognizer = TapGestureRecognizer()..onTap = _onBlogTap;
  }

  @override
  void dispose() {
    _emailRecognizer.dispose();
    _phoneRecognizer.dispose();
    _blogRecognizer.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Không thể mở: $url")));
    }
  }

  void _onEmailTap() {
    _launchUrl("mailto:test@example.com");
  }

  void _onPhoneTap() {
    _launchUrl("tel:+1234987654321");
  }

  void _onBlogTap() {
    _launchUrl("https://exampleblog.com");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RichText"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 18, color: Colors.black),
            children: [
              const TextSpan(
                text: "Hello ",
                style: TextStyle(color: Colors.green, fontSize: 24),
              ),
              const TextSpan(
                text: "World\n\n",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const TextSpan(
                text: "Hello World 👋\n\n",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const TextSpan(
                text: "Contact me via: ",
                style: TextStyle(fontSize: 16),
              ),
              WidgetSpan(
                child: Icon(Icons.email, color: Colors.blue, size: 18),
              ),
              TextSpan(
                text: " Email\n\n",
                style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16),
                recognizer: _emailRecognizer,
              ),
              const TextSpan(
                text: "Call Me: ",
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: "+1234987654321\n\n",
                style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16),
                recognizer: _phoneRecognizer,
              ),
              const TextSpan(
                text: "Read My Blog ",
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: "HERE",
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
                recognizer: _blogRecognizer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
