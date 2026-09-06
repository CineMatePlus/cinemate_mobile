// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieDetailScreenState {

 Movie? get movie; List<Movie> get relatedMovies;
/// Create a copy of MovieDetailScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieDetailScreenStateCopyWith<MovieDetailScreenState> get copyWith => _$MovieDetailScreenStateCopyWithImpl<MovieDetailScreenState>(this as MovieDetailScreenState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MovieDetailScreenState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieDetailScreenState&&(identical(other.movie, _this.movie) || other.movie == _this.movie)&&const DeepCollectionEquality().equals(other.relatedMovies, _this.relatedMovies));
}


@override
int get hashCode {
  final _this = this as MovieDetailScreenState;
  return Object.hash(runtimeType,_this.movie,const DeepCollectionEquality().hash(_this.relatedMovies));
}

@override
String toString() {
  final _this = this as MovieDetailScreenState;
  return 'MovieDetailScreenState(movie: ${_this.movie}, relatedMovies: ${_this.relatedMovies})';
}


}

/// @nodoc
abstract mixin class $MovieDetailScreenStateCopyWith<$Res>  {
  factory $MovieDetailScreenStateCopyWith(MovieDetailScreenState value, $Res Function(MovieDetailScreenState) _then) = _$MovieDetailScreenStateCopyWithImpl;
@useResult
$Res call({
 Movie? movie, List<Movie> relatedMovies
});


$MovieCopyWith<$Res>? get movie;

}
/// @nodoc
class _$MovieDetailScreenStateCopyWithImpl<$Res>
    implements $MovieDetailScreenStateCopyWith<$Res> {
  _$MovieDetailScreenStateCopyWithImpl(this._self, this._then);

  final MovieDetailScreenState _self;
  final $Res Function(MovieDetailScreenState) _then;

/// Create a copy of MovieDetailScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? movie = freezed,Object? relatedMovies = null,}) {
  return _then(MovieDetailScreenState(
movie: freezed == movie ? _self.movie : movie // ignore: cast_nullable_to_non_nullable
as Movie?,relatedMovies: null == relatedMovies ? _self.relatedMovies : relatedMovies // ignore: cast_nullable_to_non_nullable
as List<Movie>,
  ));
}
/// Create a copy of MovieDetailScreenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MovieCopyWith<$Res>? get movie {
    if (_self.movie == null) {
    return null;
  }

  return $MovieCopyWith<$Res>(_self.movie!, (value) {
    return _then(_self.copyWith(movie: value));
  });
}
}


/// Adds pattern-matching-related methods to [MovieDetailScreenState].
extension MovieDetailScreenStatePatterns on MovieDetailScreenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieDetailScreenState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieDetailScreenState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieDetailScreenState value)  $default,){
final _that = this;
switch (_that) {
case _MovieDetailScreenState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieDetailScreenState value)?  $default,){
final _that = this;
switch (_that) {
case _MovieDetailScreenState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Movie? movie,  List<Movie> relatedMovies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieDetailScreenState() when $default != null:
return $default(_that.movie,_that.relatedMovies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Movie? movie,  List<Movie> relatedMovies)  $default,) {final _that = this;
switch (_that) {
case _MovieDetailScreenState():
return $default(_that.movie,_that.relatedMovies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Movie? movie,  List<Movie> relatedMovies)?  $default,) {final _that = this;
switch (_that) {
case _MovieDetailScreenState() when $default != null:
return $default(_that.movie,_that.relatedMovies);case _:
  return null;

}
}

}

/// @nodoc


class _MovieDetailScreenState implements MovieDetailScreenState {
  const _MovieDetailScreenState({this.movie,  List<Movie> relatedMovies = const []}): _relatedMovies = relatedMovies;


@override final  Movie? movie;
 final  List<Movie> _relatedMovies;
@override@JsonKey() List<Movie> get relatedMovies {
  if (_relatedMovies is EqualUnmodifiableListView) return _relatedMovies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relatedMovies);
}


/// Create a copy of MovieDetailScreenState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieDetailScreenStateCopyWith<_MovieDetailScreenState> get copyWith => __$MovieDetailScreenStateCopyWithImpl<_MovieDetailScreenState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieDetailScreenState&&(identical(other.movie, movie) || other.movie == movie)&&const DeepCollectionEquality().equals(other.relatedMovies, _relatedMovies));
}


@override
int get hashCode {
    return Object.hash(runtimeType,movie,const DeepCollectionEquality().hash(_relatedMovies));
}

@override
String toString() {
    return 'MovieDetailScreenState(movie: $movie, relatedMovies: $relatedMovies)';
}


}

/// @nodoc
abstract mixin class _$MovieDetailScreenStateCopyWith<$Res> implements $MovieDetailScreenStateCopyWith<$Res> {
  factory _$MovieDetailScreenStateCopyWith(_MovieDetailScreenState value, $Res Function(_MovieDetailScreenState) _then) = __$MovieDetailScreenStateCopyWithImpl;
@override @useResult
$Res call({
 Movie? movie, List<Movie> relatedMovies
});


@override $MovieCopyWith<$Res>? get movie;

}
/// @nodoc
class __$MovieDetailScreenStateCopyWithImpl<$Res>
    implements _$MovieDetailScreenStateCopyWith<$Res> {
  __$MovieDetailScreenStateCopyWithImpl(this._self, this._then);

  final _MovieDetailScreenState _self;
  final $Res Function(_MovieDetailScreenState) _then;

/// Create a copy of MovieDetailScreenState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? movie = freezed,Object? relatedMovies = null,}) {
  return _then(_MovieDetailScreenState(
movie: freezed == movie ? _self.movie : movie // ignore: cast_nullable_to_non_nullable
as Movie?,relatedMovies: null == relatedMovies ? _self._relatedMovies : relatedMovies // ignore: cast_nullable_to_non_nullable
as List<Movie>,
  ));
}

/// Create a copy of MovieDetailScreenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MovieCopyWith<$Res>? get movie {
    if (_self.movie == null) {
    return null;
  }

  return $MovieCopyWith<$Res>(_self.movie!, (value) {
    return _then(_self.copyWith(movie: value));
  });
}
}

// dart format on
