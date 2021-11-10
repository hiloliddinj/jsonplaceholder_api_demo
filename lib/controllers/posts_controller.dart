import 'package:jsonplaceholder_api_demo/models/user_posts.dart';
import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/models/post.dart';
import 'package:jsonplaceholder_api_demo/services/remote_services.dart';

class PostsController extends GetxController{
  var isPostsLoading = true.obs;
  var postList = <Post>[].obs;
  var listOfUsersWithPosts = <UserPosts>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isPostsLoading(true);
      var posts = await RemoteServices.fetchUsersPosts();
      if (posts != null) {
        postList.value = posts;
      }
    } finally {
      List<Post> userPostsList = [];
      for (int i=1; i<11; i++) {
        for(var u in postList) {
          if (u.userId == i) {
            userPostsList.add(u);
          }
        }
        listOfUsersWithPosts.add(UserPosts(userPostsList));
        userPostsList = [];
      }
      isPostsLoading(false);
    }
  }
}