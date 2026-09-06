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
mixin _$CollectionsListState {

 List<Collection> get collections;
/// Create a copy of CollectionsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionsListStateCopyWith<CollectionsListState> get copyWith => _$CollectionsListStateCopyWithImpl<CollectionsListState>(this as CollectionsListState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CollectionsListState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionsListState&&const DeepCollectionEquality().equals(other.collections, _this.collections));
}


@override
int get hashCode {
  final _this = this as CollectionsListState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.collections));
}

@override
String toString() {
  final _this = this as CollectionsListState;
  return 'CollectionsListState(collections: ${_this.collections})';
}


}

/// @nodoc
abstract mixin class $CollectionsListStateCopyWith<$Res>  {
  factory $CollectionsListStateCopyWith(CollectionsListState value, $Res Function(CollectionsListState) _then) = _$CollectionsListStateCopyWithImpl;
@useResult
$Res call({
 List<Collection> collections
});




}
/// @nodoc
class _$CollectionsListStateCopyWithImpl<$Res>
    implements $CollectionsListStateCopyWith<$Res> {
  _$CollectionsListStateCopyWithImpl(this._self, this._then);

  final CollectionsListState _self;
  final $Res Function(CollectionsListState) _then;

/// Create a copy of CollectionsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? collections = null,}) {
  return _then(CollectionsListState(
collections: null == collections ? _self.collections : collections // ignore: cast_nullable_to_non_nullable
as List<Collection>,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectionsListState].
extension CollectionsListStatePatterns on CollectionsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionsListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionsListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionsListState value)  $default,){
final _that = this;
switch (_that) {
case _CollectionsListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionsListState value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionsListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Collection> collections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionsListState() when $default != null:
return $default(_that.collections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Collection> collections)  $default,) {final _that = this;
switch (_that) {
case _CollectionsListState():
return $default(_that.collections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Collection> collections)?  $default,) {final _that = this;
switch (_that) {
case _CollectionsListState() when $default != null:
return $default(_that.collections);case _:
  return null;

}
}

}

/// @nodoc


class _CollectionsListState implements CollectionsListState {
  const _CollectionsListState({ List<Collection> collections = const []}): _collections = collections;


 final  List<Collection> _collections;
@override@JsonKey() List<Collection> get collections {
  if (_collections is EqualUnmodifiableListView) return _collections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collections);
}


/// Create a copy of CollectionsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionsListStateCopyWith<_CollectionsListState> get copyWith => __$CollectionsListStateCopyWithImpl<_CollectionsListState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionsListState&&const DeepCollectionEquality().equals(other.collections, _collections));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_collections));
}

@override
String toString() {
    return 'CollectionsListState(collections: $collections)';
}


}

/// @nodoc
abstract mixin class _$CollectionsListStateCopyWith<$Res> implements $CollectionsListStateCopyWith<$Res> {
  factory _$CollectionsListStateCopyWith(_CollectionsListState value, $Res Function(_CollectionsListState) _then) = __$CollectionsListStateCopyWithImpl;
@override @useResult
$Res call({
 List<Collection> collections
});




}
/// @nodoc
class __$CollectionsListStateCopyWithImpl<$Res>
    implements _$CollectionsListStateCopyWith<$Res> {
  __$CollectionsListStateCopyWithImpl(this._self, this._then);

  final _CollectionsListState _self;
  final $Res Function(_CollectionsListState) _then;

/// Create a copy of CollectionsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? collections = null,}) {
  return _then(_CollectionsListState(
collections: null == collections ? _self._collections : collections // ignore: cast_nullable_to_non_nullable
as List<Collection>,
  ));
}


}

// dart format on
