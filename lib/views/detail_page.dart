import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/story.dart';

class DetailPage extends StatelessWidget {
  final Story story;

  const DetailPage({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.title, overflow: TextOverflow.ellipsis),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: WebView(
              initialUrl: story.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {},
            ),
          ),
        ],
      ),
    );
  }
}
