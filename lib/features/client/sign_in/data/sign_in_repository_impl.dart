import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/entities/user_entity.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/sign_in/domain/failures/auth_failure.dart';
import 'package:healthy_app/features/client/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInRepositoryImpl implements SignInRepository {
  SignInRepositoryImpl(this._firebaseAuth, this._crashlytics, this._prefs);

  final FirebaseAuth _firebaseAuth;
  final FirebaseCrashlytics _crashlytics;
  final SharedPreferences _prefs;

  @override
  Future<Response<UserEntity>> loginWithEmail(
      String email, String password) async {
    try {
      // Firebase auth
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Register user collection
      final uid = _firebaseAuth.currentUser!.uid;
      final user = UserEntity(
        uid: uid,
        email: email,
      );

      _crashlytics.setUserIdentifier(uid);

      return Response.success(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Response.failed(UserNotFoundFailure());
      } else if (e.code == 'wrong-password') {
        return Response.failed(InvalidCredentialsFailure());
      }

      return Response.failed(UnexpectedFailure());
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<UserEntity>> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn(
        scopes: [
          'email',
        ],
      ).signIn();

      if (googleUser == null) {
        return Response.failed(SocialMediaCanceledFailure());
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final currentUser = _firebaseAuth.currentUser!;
      final user = UserEntity(
        uid: currentUser.uid,
        email: currentUser.email ?? '',
        name: googleUser.displayName ?? '',
      );

      _crashlytics.setUserIdentifier(currentUser.uid);

      return Response.success(user);
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<UserEntity>> signInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      final currentUser = _firebaseAuth.currentUser!;
      final user = UserEntity(
        uid: currentUser.uid,
        email: currentUser.email ?? '',
        name: currentUser.displayName ?? '',
      );

      _crashlytics.setUserIdentifier(currentUser.uid);

      return Response.success(user);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled)
        return Response.failed(SocialMediaCanceledFailure());

      return Response.failed(UnexpectedFailure());
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _prefs.clear(),
    ]);
  }

  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
