import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart';

class MarkdownView extends StatefulWidget {

  final String markdownData;
  MarkdownView({Key? key, required this.markdownData}): super(key: key);

  @override
  _markdownView createState() => _markdownView();
}

class _markdownView extends State<MarkdownView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Markdown(
        data: widget.markdownData.toString(),
      )
    );
  }
}