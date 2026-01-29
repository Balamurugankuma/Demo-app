import 'package:untitled5/domain/user_model.dart';

abstract class UserRepository {
  Stream<List<UserModel>> getAllUserData();
  Future<UserModel?> getCurrentUserData(String uid);
}
