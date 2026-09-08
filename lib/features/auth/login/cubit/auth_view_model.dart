import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/login/cubit/auth_state.dart';
import 'package:movies_app/services/firebase_service.dart';

class AuthViewModel extends Cubit<AuthState> {
  final AuthService authService;

  AuthViewModel(this.authService) : super(AuthInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    try {
      final userCredential = await authService.signInWithGoogle();
      if (userCredential == null || userCredential.user == null) {
        emit(AuthInitial());
        return;
      }
      final user = await authService.readUserFromFireStore(
        userCredential.user!.uid,
      );
      emit(GoogleSignInSuccess(userCredential: userCredential, user: user));
    } catch (e) {
      emit(GoogleSignInFailure(e.toString()));
    }
  }
}
