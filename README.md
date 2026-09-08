# movies_app

A new Flutter project.

## Movie history

When a movie details request succeeds, the app stores the movie in two places:

- Hive box `movie_history`, keyed by `<userId>_<movieId>` for offline access.
- Firestore at `users/{userId}/history/{movieId}` for signed-in users.

Each signed-in user reads only their own UID-prefixed Hive records and their own
Firestore subcollection; histories are never shared between accounts.

The Firestore history document contains the fields from the movie API response
plus `viewedAt` (a Firestore `Timestamp`). Both stores keep the 10 most recent
movies. Opening an existing movie moves it to the newest position. The history
tab reads Hive immediately and falls back to that cached list if Firestore is
unavailable.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
