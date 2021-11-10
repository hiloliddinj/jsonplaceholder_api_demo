import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  const UserWidget(this.username, this.name, {Key? key}) : super(key: key);

  final String username, name;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blue.shade100,
        child: Row(
          children: [
            const SizedBox(width: 15),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('Username: ' + username),
                  Text('Name: ' + name),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
          ],
        ));
  }
}
