class User {
  final int id;
  final String username;
  final String email;
  final String? avatarUrl;
  final List<int> favoriteMovies;
  final List<int> watchlist;
  final List<int> watchedMovies;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatarUrl,
    required this.favoriteMovies,
    required this.watchlist,
    required this.watchedMovies,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      favoriteMovies: List<int>.from(json['favorite_movies'] ?? []),
      watchlist: List<int>.from(json['watchlist'] ?? []),
      watchedMovies: List<int>.from(json['watched_movies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar_url': avatarUrl,
      'favorite_movies': favoriteMovies,
      'watchlist': watchlist,
      'watched_movies': watchedMovies,
    };
  }
}
