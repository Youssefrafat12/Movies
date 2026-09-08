import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileService {
  ProfileService._();

  static final ProfileService instance = ProfileService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _boxName = 'user_profiles';
  late Box<Map> _box;
  Future<void>? _initialization;

  Future<void> initialize() {
    return _initialization ??= _openBox();
  }

  Future<void> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      _box = Hive.box<Map>(_boxName);
    } else {
      _box = await Hive.openBox<Map>(_boxName);
    }
  }

  DocumentReference<Map<String, dynamic>> _profileReference(User user) {
    return _firestore.collection('users').doc(user.uid);
  }

  Future<Map<String, dynamic>> loadProfile() async {
    final user = _auth.currentUser;
    if (user == null) return {};

    await initialize();
    final localProfile = _box.get(user.uid);
    try {
      final snapshot = await _profileReference(user).get(
        const GetOptions(source: Source.server),
      );
      final profile = snapshot.data() ?? <String, dynamic>{};
      await _box.put(user.uid, profile);
      return profile;
    } catch (_) {
      return localProfile == null
          ? <String, dynamic>{}
          : Map<String, dynamic>.from(localProfile);
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await user.updateDisplayName(name);
    await user.reload();
    await _profileReference(user).set({
      'name': name,
      'phone': phone,
      'avatar': avatar,
      'email': user.email,
    }, SetOptions(merge: true));
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _profileReference(user).delete();
    await user.delete();
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
