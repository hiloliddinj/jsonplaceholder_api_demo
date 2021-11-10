import 'package:jsonplaceholder_api_demo/models/post_comments.dart';
import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/services/remote_services.dart';
import 'package:jsonplaceholder_api_demo/models/comment.dart';

class CommentsController extends GetxController{
  var isCommentsLoading = true.obs;
  var commentsList = <Comment>[].obs;
  var listOfPostsWithComments = <PostComments>[].obs;

  @override
  void onInit() {
    fetchComments();
    super.onInit();
  }

  void fetchComments() async {
    try {
      isCommentsLoading(true);
      var comments = await RemoteServices.fetchPostsComments();
      if (comments != null) {
        commentsList.value = comments;
      }
    } finally {
      List<Comment> postCommentsList = [];
      for (int i=1; i<101; i++) {
        for(var u in commentsList) {
          if (u.postId == i) {
            postCommentsList.add(u);
          }
        }
        listOfPostsWithComments.add(PostComments(postCommentsList));
        postCommentsList = [];
      }
      isCommentsLoading(false);
    }
  }
}