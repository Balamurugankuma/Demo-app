import 'package:untitled5/data/firebase_authrepository.dart';
import 'package:untitled5/data/firebase_userrepository.dart';
import 'package:untitled5/domain/auth_repository.dart';
import 'package:untitled5/domain/user_repository.dart';

final UserRepository userRepository = FirebaseUserrepository();
final AuthRepository authRepository = FirebaseAuthRepository();
