import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';

class WatchListService {
  WatchListService._();

  static final WatchListService instance = WatchListService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _boxName = 'watch_list';
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

  CollectionReference<Map<String, dynamic>>? _watchListReference() {
    final user = _auth.currentUser;
    if (user == null) return null;
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('watchlist');
  }

  Future<List<Movie>> loadSavedMovies() async {
    final ref = _watchListReference();
    if (ref == null) return [];

    await initialize();
    final localMovies = _readLocalMovies();
    try {
      final snapshot = await ref.get(
        const GetOptions(source: Source.server),
      );
      final movies = snapshot.docs
          .map((doc) => Movie.fromJson(doc.data()))
          .toList();
      await _replaceLocalMovies(movies);
      return movies;
    } catch (_) {
      return localMovies;
    }
  }

  Stream<List<Movie>> watchSavedMovies() async* {
    final user = _auth.currentUser;
    if (user == null) {
      yield const <Movie>[];
      return;
    }

    await initialize();
    var localMovies = _readLocalMovies();
    yield localMovies;

    try {
      await for (final snapshot in _firestore
        .collection('users')
        .doc(user.uid)
        .collection('watchlist')
        .snapshots()) {
        final movies = snapshot.docs
            .map((doc) => Movie.fromJson(doc.data()))
            .toList();
        if (snapshot.metadata.isFromCache &&
            movies.isEmpty &&
            localMovies.isNotEmpty) {
          continue;
        }
        await _replaceLocalMovies(movies);
        localMovies = movies;
        yield movies;
      }
    } catch (_) {
    }
  }

  Future<bool> isSaved(int? movieId) async {
    if (movieId == null) return false;
    final ref = _watchListReference();
    if (ref == null) return false;

    await initialize();
    if (_box.get(_localKey(movieId)) != null) return true;

    try {
      final doc = await ref.doc(movieId.toString()).get();
      return doc.exists;
    } catch (_) {
      return false;
    }
  }

  Future<bool> toggleSave(Movie movie) async {
    final ref = _watchListReference();
    if (ref == null || movie.id == null) return false;

    await initialize();
    final docRef = ref.doc(movie.id.toString());
    final localKey = _localKey(movie.id!);
    var exists = _box.get(localKey) != null;
    if (!exists) {
      try {
        exists = (await docRef.get()).exists;
      } catch (_) {
        exists = false;
      }
    }

    if (exists) {
      await _box.delete(localKey);
      try {
        await docRef.delete();
      } catch (_) {}
      return false;
    } else {
      await _box.put(localKey, movie.toJson());
      try {
        await docRef.set(movie.toJson());
      } catch (_) {}
      return true;
    }
  }

  String _localKey(int movieId) {
    return '${_auth.currentUser?.uid ?? 'guest'}_$movieId';
  }

  List<Movie> _readLocalMovies() {
    final prefix = '${_auth.currentUser?.uid ?? 'guest'}_';
    return _box.keys
        .whereType<String>()
        .where((key) => key.startsWith(prefix))
        .map((key) => _box.get(key))
        .whereType<Map>()
        .map((movie) => Movie.fromJson(Map<String, dynamic>.from(movie)))
        .toList();
  }

  Future<void> _replaceLocalMovies(List<Movie> movies) async {
    final prefix = '${_auth.currentUser?.uid ?? 'guest'}_';
    final keys = _box.keys.whereType<String>().where(
      (key) => key.startsWith(prefix),
    );
    await _box.deleteAll(keys);
    for (final movie in movies) {
      if (movie.id != null) {
        await _box.put(_localKey(movie.id!), movie.toJson());
      }
    }
  }
}
