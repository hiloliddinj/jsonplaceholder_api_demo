import 'package:flutter/material.dart';
import 'package:jsonplaceholder_api_demo/constants.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(this.title, this.body, {Key? key}) : super(key: key);

  final String title, body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: kPostTitleStyle),
            SizedBox(
              width: double.infinity,
              child: Text(
                body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
