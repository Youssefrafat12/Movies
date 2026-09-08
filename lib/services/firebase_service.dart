import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/model/user_model.dart';

class AuthResult {
  final bool success;
  final String? errorCode;
  final User? user;

  AuthResult({required this.success, this.errorCode, this.user});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return AuthResult(success: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, errorCode: e.code);
    } catch (e) {
      return AuthResult(success: false, errorCode: 'unknown');
    }
  }

  Future<AuthResult> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AuthResult(success: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, errorCode: e.code);
    } catch (e) {
      return AuthResult(success: false, errorCode: 'unknown');
    }
  }

  Future<UserModel?> readUserFromFireStore(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }

    return null;
  }

  Future<void> addUserInFireStore(UserModel user) async {
    await firestore.collection('users').doc(user.uId).set(user.toJson());
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;

      await signIn.initialize(
        serverClientId:
            '707456573917-mr0aclsteug4qglrouv7cc0gaokpt3hi.apps.googleusercontent.com',
      );

      final GoogleSignInAccount account = await signIn.authenticate();

      final idToken = account.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user != null) {
        final userExists = await readUserFromFireStore(user.uid);

        if (userExists == null) {
          await addUserInFireStore(
            UserModel(
              uId: user.uid,
              email: user.email ?? '',
              name: user.displayName ?? '',
            ),
          );
        }
      }

      return userCredential;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }

      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}

String getAuthErrorMessage(AppLocalizations l10n, String code) {
  switch (code) {
    case 'user-not-found':
      return l10n.user_not_found;

    case 'wrong-password':
      return l10n.wrong_password;

    case 'invalid-email':
      return l10n.invalid_email;

    case 'user-disabled':
      return l10n.user_disabled;

    case 'weak-password':
      return l10n.weak_password;

    case 'email-already-in-use':
      return l10n.email_already_in_use;

    case 'invalid-credential':
      return l10n.invalid_credential;

    case 'too-many-requests':
      return l10n.too_many_requests;

    case 'network-request-failed':
      return l10n.network_request_failed;

    case 'operation-not-allowed':
      return l10n.operation_not_allowed;

    default:
      return l10n.something_went_wrong;
  }
}
