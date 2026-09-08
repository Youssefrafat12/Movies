import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/api/model/movie_details_response/movie.dart';

class MovieHistoryService {
  MovieHistoryService._();

  static final MovieHistoryService instance = MovieHistoryService._();

  static const int maxHistoryItems = 10;
  static const String _boxName = 'movie_history';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Box<Map> _box;
  Future<void>? _initialization;

  Future<void> initialize() {
    return _initialization ??= _openBox();
  }

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.initFlutter();
    }
    _box = Hive.isBoxOpen(_boxName)
        ? Hive.box<Map>(_boxName)
        : await Hive.openBox<Map>(_boxName);
  }

  String _localKey(int movieId) {
    return '${_auth.currentUser?.uid ?? 'guest'}_$movieId';
  }

  CollectionReference<Map<String, dynamic>>? _historyReference() {
    final user = _auth.currentUser;
    if (user == null) return null;

    return _firestore.collection('users').doc(user.uid).collection('history');
  }

  Future<void> addMovie(Movie movie) async {
    final movieId = movie.id;
    if (movieId == null) return;

    await initialize();
    await _box.put(_localKey(movieId), {
      'movie': movie.toJson(),
      'viewedAt': DateTime.now().millisecondsSinceEpoch,
    });
    await _trimLocalHistory();

    final historyReference = _historyReference();
    if (historyReference == null) return;

    try {
      await historyReference.doc(movieId.toString()).set({
        ...movie.toJson(),
        'viewedAt': Timestamp.now(),
      });
      final snapshot = await historyReference
          .orderBy('viewedAt', descending: true)
          .get();
      for (final document in snapshot.docs.skip(maxHistoryItems)) {
        await document.reference.delete();
      }
    } catch (_) {}
  }

  Future<List<Movie>> loadHistory() async {
    if (_auth.currentUser == null) return [];

    await initialize();
    final localMovies = _readLocalHistory();
    final historyReference = _historyReference();
    if (historyReference == null) return localMovies;

    try {
      final snapshot = await historyReference
          .orderBy('viewedAt', descending: true)
          .limit(maxHistoryItems)
          .get(const GetOptions(source: Source.server));
      final remoteMovies = snapshot.docs
          .map((document) => Movie.fromJson(document.data()))
          .where((movie) => movie.id != null)
          .toList();
      if (remoteMovies.isEmpty && localMovies.isNotEmpty) {
        return localMovies;
      }
      await _replaceLocalHistory(remoteMovies);
      return remoteMovies;
    } catch (_) {
      return localMovies;
    }
  }

  List<Movie> _readLocalHistory() {
    final prefix = '${_auth.currentUser?.uid ?? 'guest'}_';
    final entries = _box.keys
      .whereType<String>()
      .where((key) => key.startsWith(prefix))
      .map((key) => _box.get(key))
      .whereType<Map>()
      .map((entry) => Map<String, dynamic>.from(entry))
        .where((entry) => entry['movie'] is Map)
        .toList();
    entries.sort(
      (first, second) => (second['viewedAt'] as int).compareTo(
        first['viewedAt'] as int,
      ),
    );
    return entries
        .take(maxHistoryItems)
        .map(
          (entry) => Movie.fromJson(
            Map<String, dynamic>.from(entry['movie'] as Map),
          ),
        )
        .toList();
  }

  Future<void> _trimLocalHistory() async {
    final keysByDate = _box.keys.whereType<String>().map((key) {
      final entry = _box.get(key);
      return (key: key, viewedAt: entry?['viewedAt'] as int? ?? 0);
    }).toList();
    keysByDate.sort((first, second) => second.viewedAt.compareTo(first.viewedAt));
    for (final item in keysByDate.skip(maxHistoryItems)) {
      await _box.delete(item.key);
    }
  }

  Future<void> _replaceLocalHistory(List<Movie> movies) async {
    final prefix = '${_auth.currentUser?.uid ?? 'guest'}_';
    final oldKeys = _box.keys.whereType<String>().where(
      (key) => key.startsWith(prefix),
    );
    await _box.deleteAll(oldKeys);
    for (var index = 0; index < movies.length; index++) {
      await _box.put(_localKey(movies[index].id!), {
        'movie': movies[index].toJson(),
        'viewedAt': DateTime.now().millisecondsSinceEpoch - index,
      });
    }
  }
}