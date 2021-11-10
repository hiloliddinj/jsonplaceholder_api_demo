import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/models/user.dart';
import 'package:jsonplaceholder_api_demo/services/remote_services.dart';

class UsersController extends GetxController{
  var isUsersLoading = true.obs;
  var userList = <User>[].obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isUsersLoading(true);
      var users = await RemoteServices.fetchUsersData();
      if (users != null) {
        userList.value = users;
      }
    } finally {
      isUsersLoading(false);
    }
  }
}