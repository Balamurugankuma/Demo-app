import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled5/domain/user_model.dart';
import 'package:untitled5/domain/user_repository.dart';

class FirebaseUserrepository implements UserRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Stream<List<UserModel>> getAllUserData() {
    return _firestore
        .collection('Users')
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((doc) => UserModel.fromMap(doc.data())).toList(),
        );
  }

  @override
  Future<UserModel?> getCurrentUserData(String uid) async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final snap = await _firestore.collection('Users').doc(user.uid).get();
    if (!snap.exists) return null;
    return UserModel.fromMap(snap.data()!);
  }
}
