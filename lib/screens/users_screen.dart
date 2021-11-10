import 'package:jsonplaceholder_api_demo/screens/user_details_screen.dart';
import 'package:jsonplaceholder_api_demo/widgets/prog_indicator.dart';
import 'package:jsonplaceholder_api_demo/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/controllers/users_controller.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);

  final UsersController c = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: SafeArea(
        child: Obx(() {
          if (c.isUsersLoading()) {
            return const ProgIndicator();
          } else {
            return ListView.builder(
              itemCount: c.userList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  child: UserWidget(
                    c.userList[i].username,
                    c.userList[i].name,
                  ),
                  onTap: () {
                    Get.to(() => UserDetailsScreen(i));
                  },
                );
              },
            );
          }
        }),
      ),
    );
  }
}
