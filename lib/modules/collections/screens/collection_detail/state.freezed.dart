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
mixin _$CollectionDetailState {

 Collection? get collection; List<Movie> get movies; List<Movie> get recommendations;
/// Create a copy of CollectionDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionDetailStateCopyWith<CollectionDetailState> get copyWith => _$CollectionDetailStateCopyWithImpl<CollectionDetailState>(this as CollectionDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CollectionDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionDetailState&&(identical(other.collection, _this.collection) || other.collection == _this.collection)&&const DeepCollectionEquality().equals(other.movies, _this.movies)&&const DeepCollectionEquality().equals(other.recommendations, _this.recommendations));
}


@override
int get hashCode {
  final _this = this as CollectionDetailState;
  return Object.hash(runtimeType,_this.collection,const DeepCollectionEquality().hash(_this.movies),const DeepCollectionEquality().hash(_this.recommendations));
}

@override
String toString() {
  final _this = this as CollectionDetailState;
  return 'CollectionDetailState(collection: ${_this.collection}, movies: ${_this.movies}, recommendations: ${_this.recommendations})';
}


}

/// @nodoc
abstract mixin class $CollectionDetailStateCopyWith<$Res>  {
  factory $CollectionDetailStateCopyWith(CollectionDetailState value, $Res Function(CollectionDetailState) _then) = _$CollectionDetailStateCopyWithImpl;
@useResult
$Res call({
 Collection? collection, List<Movie> movies, List<Movie> recommendations
});


$CollectionCopyWith<$Res>? get collection;

}
/// @nodoc
class _$CollectionDetailStateCopyWithImpl<$Res>
    implements $CollectionDetailStateCopyWith<$Res> {
  _$CollectionDetailStateCopyWithImpl(this._self, this._then);

  final CollectionDetailState _self;
  final $Res Function(CollectionDetailState) _then;

/// Create a copy of CollectionDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? collection = freezed,Object? movies = null,Object? recommendations = null,}) {
  return _then(CollectionDetailState(
collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as Collection?,movies: null == movies ? _self.movies : movies // ignore: cast_nullable_to_non_nullable
as List<Movie>,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<Movie>,
  ));
}
/// Create a copy of CollectionDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectionCopyWith<$Res>? get collection {
    if (_self.collection == null) {
    return null;
  }

  return $CollectionCopyWith<$Res>(_self.collection!, (value) {
    return _then(_self.copyWith(collection: value));
  });
}
}


/// Adds pattern-matching-related methods to [CollectionDetailState].
extension CollectionDetailStatePatterns on CollectionDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionDetailState value)  $default,){
final _that = this;
switch (_that) {
case _CollectionDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Collection? collection,  List<Movie> movies,  List<Movie> recommendations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionDetailState() when $default != null:
return $default(_that.collection,_that.movies,_that.recommendations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Collection? collection,  List<Movie> movies,  List<Movie> recommendations)  $default,) {final _that = this;
switch (_that) {
case _CollectionDetailState():
return $default(_that.collection,_that.movies,_that.recommendations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Collection? collection,  List<Movie> movies,  List<Movie> recommendations)?  $default,) {final _that = this;
switch (_that) {
case _CollectionDetailState() when $default != null:
return $default(_that.collection,_that.movies,_that.recommendations);case _:
  return null;

}
}

}

/// @nodoc


class _CollectionDetailState implements CollectionDetailState {
  const _CollectionDetailState({this.collection,  List<Movie> movies = const [],  List<Movie> recommendations = const []}): _movies = movies,_recommendations = recommendations;


@override final  Collection? collection;
 final  List<Movie> _movies;
@override@JsonKey() List<Movie> get movies {
  if (_movies is EqualUnmodifiableListView) return _movies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movies);
}

 final  List<Movie> _recommendations;
@override@JsonKey() List<Movie> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}


/// Create a copy of CollectionDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionDetailStateCopyWith<_CollectionDetailState> get copyWith => __$CollectionDetailStateCopyWithImpl<_CollectionDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionDetailState&&(identical(other.collection, collection) || other.collection == collection)&&const DeepCollectionEquality().equals(other.movies, _movies)&&const DeepCollectionEquality().equals(other.recommendations, _recommendations));
}


@override
int get hashCode {
    return Object.hash(runtimeType,collection,const DeepCollectionEquality().hash(_movies),const DeepCollectionEquality().hash(_recommendations));
}

@override
String toString() {
    return 'CollectionDetailState(collection: $collection, movies: $movies, recommendations: $recommendations)';
}


}

/// @nodoc
abstract mixin class _$CollectionDetailStateCopyWith<$Res> implements $CollectionDetailStateCopyWith<$Res> {
  factory _$CollectionDetailStateCopyWith(_CollectionDetailState value, $Res Function(_CollectionDetailState) _then) = __$CollectionDetailStateCopyWithImpl;
@override @useResult
$Res call({
 Collection? collection, List<Movie> movies, List<Movie> recommendations
});


@override $CollectionCopyWith<$Res>? get collection;

}
/// @nodoc
class __$CollectionDetailStateCopyWithImpl<$Res>
    implements _$CollectionDetailStateCopyWith<$Res> {
  __$CollectionDetailStateCopyWithImpl(this._self, this._then);

  final _CollectionDetailState _self;
  final $Res Function(_CollectionDetailState) _then;

/// Create a copy of CollectionDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? collection = freezed,Object? movies = null,Object? recommendations = null,}) {
  return _then(_CollectionDetailState(
collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as Collection?,movies: null == movies ? _self._movies : movies // ignore: cast_nullable_to_non_nullable
as List<Movie>,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<Movie>,
  ));
}

/// Create a copy of CollectionDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectionCopyWith<$Res>? get collection {
    if (_self.collection == null) {
    return null;
  }

  return $CollectionCopyWith<$Res>(_self.collection!, (value) {
    return _then(_self.copyWith(collection: value));
  });
}
}

// dart format on
