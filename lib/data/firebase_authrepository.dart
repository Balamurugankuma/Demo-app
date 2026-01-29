import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled5/domain/auth_repository.dart';
import 'package:untitled5/domain/user_model.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    await _firestore.collection('Users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,

      'createdAt': FieldValue.serverTimestamp(),
    });

    return UserModel(uid: uid, name: name, email: email, password: null);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    final snap = await _firestore.collection('Users').doc(uid).get();
    final data = snap.data();

    return UserModel.fromMap(data!);
  }

  @override
  Future<UserModel?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
