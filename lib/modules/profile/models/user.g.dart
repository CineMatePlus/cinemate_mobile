// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      favoriteMovies: (json['favoriteMovies'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      watchlist: (json['watchlist'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      watchedMovies: (json['watchedMovies'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'favoriteMovies': instance.favoriteMovies,
      'watchlist': instance.watchlist,
      'watchedMovies': instance.watchedMovies,
    };
