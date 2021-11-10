import 'package:jsonplaceholder_api_demo/constants.dart';
import 'package:flutter/material.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget(this.commentName, this.commentEmail, this.commentBody, {Key? key}) : super(key: key);

  final String commentName, commentEmail, commentBody;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ' + commentName, style: kPostTitleStyle),
            Text('Email: ' + commentEmail, style: kPostTitleStyle),
            const SizedBox(height: 6),
            Text('Comment: ' + commentBody),
          ],
        ),
      ),
    );
  }
}
