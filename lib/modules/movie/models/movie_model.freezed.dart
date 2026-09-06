// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Movie {

@JsonKey(name: '_id') String get id; String get title; String get overview;@JsonKey(name: 'poster_path') String? get posterPath;@JsonKey(name: 'backdrop_path') String? get backdropPath;@JsonKey(name: 'vote_average') double get voteAverage;@JsonKey(name: 'release_date') String get releaseDate; List<String> get genres;@JsonKey(name: 'num_likes') int get numLikes;@JsonKey(name: 'num_watches') int get numWatches;@JsonKey(name: 'is_liked') bool get isLiked;@JsonKey(name: 'is_watched') bool get isWatched;@JsonKey(name: 'is_in_watchlist') bool get isInWatchlist;
/// Create a copy of Movie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieCopyWith<Movie> get copyWith => _$MovieCopyWithImpl<Movie>(this as Movie, _$identity);

  /// Serializes this Movie to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Movie;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Movie&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&(identical(other.posterPath, _this.posterPath) || other.posterPath == _this.posterPath)&&(identical(other.backdropPath, _this.backdropPath) || other.backdropPath == _this.backdropPath)&&(identical(other.voteAverage, _this.voteAverage) || other.voteAverage == _this.voteAverage)&&(identical(other.releaseDate, _this.releaseDate) || other.releaseDate == _this.releaseDate)&&const DeepCollectionEquality().equals(other.genres, _this.genres)&&(identical(other.numLikes, _this.numLikes) || other.numLikes == _this.numLikes)&&(identical(other.numWatches, _this.numWatches) || other.numWatches == _this.numWatches)&&(identical(other.isLiked, _this.isLiked) || other.isLiked == _this.isLiked)&&(identical(other.isWatched, _this.isWatched) || other.isWatched == _this.isWatched)&&(identical(other.isInWatchlist, _this.isInWatchlist) || other.isInWatchlist == _this.isInWatchlist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Movie;
  return Object.hash(runtimeType,_this.id,_this.title,_this.overview,_this.posterPath,_this.backdropPath,_this.voteAverage,_this.releaseDate,const DeepCollectionEquality().hash(_this.genres),_this.numLikes,_this.numWatches,_this.isLiked,_this.isWatched,_this.isInWatchlist);
}

@override
String toString() {
  final _this = this as Movie;
  return 'Movie(id: ${_this.id}, title: ${_this.title}, overview: ${_this.overview}, posterPath: ${_this.posterPath}, backdropPath: ${_this.backdropPath}, voteAverage: ${_this.voteAverage}, releaseDate: ${_this.releaseDate}, genres: ${_this.genres}, numLikes: ${_this.numLikes}, numWatches: ${_this.numWatches}, isLiked: ${_this.isLiked}, isWatched: ${_this.isWatched}, isInWatchlist: ${_this.isInWatchlist})';
}


}

/// @nodoc
abstract mixin class $MovieCopyWith<$Res>  {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) _then) = _$MovieCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id, String title, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'vote_average') double voteAverage,@JsonKey(name: 'release_date') String releaseDate, List<String> genres,@JsonKey(name: 'num_likes') int numLikes,@JsonKey(name: 'num_watches') int numWatches,@JsonKey(name: 'is_liked') bool isLiked,@JsonKey(name: 'is_watched') bool isWatched,@JsonKey(name: 'is_in_watchlist') bool isInWatchlist
});




}
/// @nodoc
class _$MovieCopyWithImpl<$Res>
    implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._self, this._then);

  final Movie _self;
  final $Res Function(Movie) _then;

/// Create a copy of Movie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? overview = null,Object? posterPath = freezed,Object? backdropPath = freezed,Object? voteAverage = null,Object? releaseDate = null,Object? genres = null,Object? numLikes = null,Object? numWatches = null,Object? isLiked = null,Object? isWatched = null,Object? isInWatchlist = null,}) {
  return _then(Movie(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,releaseDate: null == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,numLikes: null == numLikes ? _self.numLikes : numLikes // ignore: cast_nullable_to_non_nullable
as int,numWatches: null == numWatches ? _self.numWatches : numWatches // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,isWatched: null == isWatched ? _self.isWatched : isWatched // ignore: cast_nullable_to_non_nullable
as bool,isInWatchlist: null == isInWatchlist ? _self.isInWatchlist : isInWatchlist // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Movie].
extension MoviePatterns on Movie {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Movie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Movie() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Movie value)  $default,){
final _that = this;
switch (_that) {
case _Movie():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Movie value)?  $default,){
final _that = this;
switch (_that) {
case _Movie() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String title,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'vote_average')  double voteAverage, @JsonKey(name: 'release_date')  String releaseDate,  List<String> genres, @JsonKey(name: 'num_likes')  int numLikes, @JsonKey(name: 'num_watches')  int numWatches, @JsonKey(name: 'is_liked')  bool isLiked, @JsonKey(name: 'is_watched')  bool isWatched, @JsonKey(name: 'is_in_watchlist')  bool isInWatchlist)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Movie() when $default != null:
return $default(_that.id,_that.title,_that.overview,_that.posterPath,_that.backdropPath,_that.voteAverage,_that.releaseDate,_that.genres,_that.numLikes,_that.numWatches,_that.isLiked,_that.isWatched,_that.isInWatchlist);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String title,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'vote_average')  double voteAverage, @JsonKey(name: 'release_date')  String releaseDate,  List<String> genres, @JsonKey(name: 'num_likes')  int numLikes, @JsonKey(name: 'num_watches')  int numWatches, @JsonKey(name: 'is_liked')  bool isLiked, @JsonKey(name: 'is_watched')  bool isWatched, @JsonKey(name: 'is_in_watchlist')  bool isInWatchlist)  $default,) {final _that = this;
switch (_that) {
case _Movie():
return $default(_that.id,_that.title,_that.overview,_that.posterPath,_that.backdropPath,_that.voteAverage,_that.releaseDate,_that.genres,_that.numLikes,_that.numWatches,_that.isLiked,_that.isWatched,_that.isInWatchlist);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String id,  String title,  String overview, @JsonKey(name: 'poster_path')  String? posterPath, @JsonKey(name: 'backdrop_path')  String? backdropPath, @JsonKey(name: 'vote_average')  double voteAverage, @JsonKey(name: 'release_date')  String releaseDate,  List<String> genres, @JsonKey(name: 'num_likes')  int numLikes, @JsonKey(name: 'num_watches')  int numWatches, @JsonKey(name: 'is_liked')  bool isLiked, @JsonKey(name: 'is_watched')  bool isWatched, @JsonKey(name: 'is_in_watchlist')  bool isInWatchlist)?  $default,) {final _that = this;
switch (_that) {
case _Movie() when $default != null:
return $default(_that.id,_that.title,_that.overview,_that.posterPath,_that.backdropPath,_that.voteAverage,_that.releaseDate,_that.genres,_that.numLikes,_that.numWatches,_that.isLiked,_that.isWatched,_that.isInWatchlist);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Movie implements Movie {
  const _Movie({@JsonKey(name: '_id') required this.id, required this.title, required this.overview, @JsonKey(name: 'poster_path') this.posterPath, @JsonKey(name: 'backdrop_path') this.backdropPath, @JsonKey(name: 'vote_average') required this.voteAverage, @JsonKey(name: 'release_date') required this.releaseDate, required  List<String> genres, @JsonKey(name: 'num_likes') required this.numLikes, @JsonKey(name: 'num_watches') required this.numWatches, @JsonKey(name: 'is_liked') required this.isLiked, @JsonKey(name: 'is_watched') required this.isWatched, @JsonKey(name: 'is_in_watchlist') required this.isInWatchlist}): _genres = genres;
  factory _Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

@override@JsonKey(name: '_id') final  String id;
@override final  String title;
@override final  String overview;
@override@JsonKey(name: 'poster_path') final  String? posterPath;
@override@JsonKey(name: 'backdrop_path') final  String? backdropPath;
@override@JsonKey(name: 'vote_average') final  double voteAverage;
@override@JsonKey(name: 'release_date') final  String releaseDate;
 final  List<String> _genres;
@override List<String> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override@JsonKey(name: 'num_likes') final  int numLikes;
@override@JsonKey(name: 'num_watches') final  int numWatches;
@override@JsonKey(name: 'is_liked') final  bool isLiked;
@override@JsonKey(name: 'is_watched') final  bool isWatched;
@override@JsonKey(name: 'is_in_watchlist') final  bool isInWatchlist;

/// Create a copy of Movie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieCopyWith<_Movie> get copyWith => __$MovieCopyWithImpl<_Movie>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MovieToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Movie&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterPath, posterPath) || other.posterPath == posterPath)&&(identical(other.backdropPath, backdropPath) || other.backdropPath == backdropPath)&&(identical(other.voteAverage, voteAverage) || other.voteAverage == voteAverage)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&const DeepCollectionEquality().equals(other.genres, _genres)&&(identical(other.numLikes, numLikes) || other.numLikes == numLikes)&&(identical(other.numWatches, numWatches) || other.numWatches == numWatches)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isWatched, isWatched) || other.isWatched == isWatched)&&(identical(other.isInWatchlist, isInWatchlist) || other.isInWatchlist == isInWatchlist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,overview,posterPath,backdropPath,voteAverage,releaseDate,const DeepCollectionEquality().hash(_genres),numLikes,numWatches,isLiked,isWatched,isInWatchlist);
}

@override
String toString() {
    return 'Movie(id: $id, title: $title, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, voteAverage: $voteAverage, releaseDate: $releaseDate, genres: $genres, numLikes: $numLikes, numWatches: $numWatches, isLiked: $isLiked, isWatched: $isWatched, isInWatchlist: $isInWatchlist)';
}


}

/// @nodoc
abstract mixin class _$MovieCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$MovieCopyWith(_Movie value, $Res Function(_Movie) _then) = __$MovieCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id, String title, String overview,@JsonKey(name: 'poster_path') String? posterPath,@JsonKey(name: 'backdrop_path') String? backdropPath,@JsonKey(name: 'vote_average') double voteAverage,@JsonKey(name: 'release_date') String releaseDate, List<String> genres,@JsonKey(name: 'num_likes') int numLikes,@JsonKey(name: 'num_watches') int numWatches,@JsonKey(name: 'is_liked') bool isLiked,@JsonKey(name: 'is_watched') bool isWatched,@JsonKey(name: 'is_in_watchlist') bool isInWatchlist
});




}
/// @nodoc
class __$MovieCopyWithImpl<$Res>
    implements _$MovieCopyWith<$Res> {
  __$MovieCopyWithImpl(this._self, this._then);

  final _Movie _self;
  final $Res Function(_Movie) _then;

/// Create a copy of Movie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? overview = null,Object? posterPath = freezed,Object? backdropPath = freezed,Object? voteAverage = null,Object? releaseDate = null,Object? genres = null,Object? numLikes = null,Object? numWatches = null,Object? isLiked = null,Object? isWatched = null,Object? isInWatchlist = null,}) {
  return _then(_Movie(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterPath: freezed == posterPath ? _self.posterPath : posterPath // ignore: cast_nullable_to_non_nullable
as String?,backdropPath: freezed == backdropPath ? _self.backdropPath : backdropPath // ignore: cast_nullable_to_non_nullable
as String?,voteAverage: null == voteAverage ? _self.voteAverage : voteAverage // ignore: cast_nullable_to_non_nullable
as double,releaseDate: null == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,numLikes: null == numLikes ? _self.numLikes : numLikes // ignore: cast_nullable_to_non_nullable
as int,numWatches: null == numWatches ? _self.numWatches : numWatches // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,isWatched: null == isWatched ? _self.isWatched : isWatched // ignore: cast_nullable_to_non_nullable
as bool,isInWatchlist: null == isInWatchlist ? _self.isInWatchlist : isInWatchlist // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
