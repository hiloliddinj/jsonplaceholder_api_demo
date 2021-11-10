import 'package:jsonplaceholder_api_demo/constants.dart';
import 'package:jsonplaceholder_api_demo/controllers/posts_controller.dart';
import 'package:jsonplaceholder_api_demo/models/comment.dart';
import 'package:jsonplaceholder_api_demo/models/post.dart';
import 'package:jsonplaceholder_api_demo/services/remote_services.dart';
import 'package:jsonplaceholder_api_demo/widgets/comments_widget.dart';
import 'package:jsonplaceholder_api_demo/widgets/prog_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/controllers/comments_controller.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen(this.userIndex, this.postIndex, {Key? key})
      : super(key: key);

  final int userIndex, postIndex;

  final PostsController pC = Get.find<PostsController>();
  final CommentsController cC = Get.put(CommentsController());

  _showDialog() {
    String name = '', email = '', body = '';
    Get.defaultDialog(
      title: 'Add New Comment',
      content: Column(
        children: [
          TextField(
            onChanged: (text) {
              name = text;
            },
            decoration:
            const InputDecoration(border: OutlineInputBorder(), hintText: 'Name'),
          ),
          TextField(
            onChanged: (text) {
              email = text;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Email'),
          ),
          TextField(
            onChanged: (text) {
              body = text;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Comment'),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                print('Sending to Server!');
                RemoteServices.postNewComment(name, email, body, postIndex + 1);
                Get.back();
              }, child: const Text('Send')),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Post post =
    pC.listOfUsersWithPosts[userIndex].userPostsList[postIndex];
    final postId = post.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.green.shade100,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Post: ', style: kHeadingStyle),
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.title, style: kPostTitleStyle),
                          Text(post.body),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text('Comments: ', style: kHeadingStyle),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.blueAccent.shade100,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Obx(() {
                  if (cC.isCommentsLoading()) {
                    return const ProgIndicator();
                  } else {
                    final List<Comment> postCommentsList =
                        cC.listOfPostsWithComments[postId - 1].postCommentsList;
                    return ListView.builder(
                      itemCount: postCommentsList.length,
                      itemBuilder: (context, i) {
                        return CommentsWidget(
                          postCommentsList[i].name,
                          postCommentsList[i].email,
                          postCommentsList[i].body,
                        );
                      },
                    );
                    return Container();
                  }
                }),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ElevatedButton(
                  child: const Text('Add New Comment'),
                  onPressed: () {
                    _showDialog();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
