import 'package:jsonplaceholder_api_demo/controllers/users_controller.dart';
import 'package:jsonplaceholder_api_demo/models/user.dart';
import 'package:jsonplaceholder_api_demo/models/user_posts.dart';
import 'package:jsonplaceholder_api_demo/screens/post_details_screen.dart';
import 'package:jsonplaceholder_api_demo/widgets/post_widget.dart';
import 'package:jsonplaceholder_api_demo/widgets/prog_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/controllers/posts_controller.dart';

class UserPostsScreen extends StatelessWidget {
  UserPostsScreen(this.userIndex, {Key? key}) : super(key: key);

  final int userIndex;

  final UsersController uC = Get.find<UsersController>();
  final PostsController pC = Get.find<PostsController>();

  @override
  Widget build(BuildContext context) {
    final User user = uC.userList[userIndex];

    return Scaffold(
      appBar: AppBar(title: Text(user.username + ' Posts')),
      body: SafeArea(
        child: Obx(() {
          if (pC.isPostsLoading()) {
            return const ProgIndicator();
          } else {
            UserPosts userPosts =
                UserPosts(pC.listOfUsersWithPosts[userIndex].userPostsList);
            return ListView.builder(
              itemCount: userPosts.userPostsList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  child: PostWidget(
                    userPosts.userPostsList[i].title,
                    userPosts.userPostsList[i].body,
                  ),
                  onTap: () {
                    Get.to(() => PostDetailsScreen(userIndex, i));
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
