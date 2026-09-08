import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/model/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class GoogleSignInLoading extends AuthState {}

class GoogleSignInSuccess extends AuthState {
  final UserCredential userCredential;
  final UserModel? user;

  GoogleSignInSuccess({required this.userCredential, this.user});
}

class GoogleSignInFailure extends AuthState {
  final String message;

  GoogleSignInFailure(this.message);
}
