// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'similar_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SimilarUser {

@JsonKey(name: '_id') String get id; String get email; String get name;@JsonKey(name: 'avatar_url') String? get avatarUrl; int get gender;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt; double get similarity;
/// Create a copy of SimilarUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimilarUserCopyWith<SimilarUser> get copyWith => _$SimilarUserCopyWithImpl<SimilarUser>(this as SimilarUser, _$identity);

  /// Serializes this SimilarUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SimilarUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimilarUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.similarity, _this.similarity) || other.similarity == _this.similarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SimilarUser;
  return Object.hash(runtimeType,_this.id,_this.email,_this.name,_this.avatarUrl,_this.gender,_this.createdAt,_this.updatedAt,_this.similarity);
}

@override
String toString() {
  final _this = this as SimilarUser;
  return 'SimilarUser(id: ${_this.id}, email: ${_this.email}, name: ${_this.name}, avatarUrl: ${_this.avatarUrl}, gender: ${_this.gender}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, similarity: ${_this.similarity})';
}


}

/// @nodoc
abstract mixin class $SimilarUserCopyWith<$Res>  {
  factory $SimilarUserCopyWith(SimilarUser value, $Res Function(SimilarUser) _then) = _$SimilarUserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id, String email, String name,@JsonKey(name: 'avatar_url') String? avatarUrl, int gender,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, double similarity
});




}
/// @nodoc
class _$SimilarUserCopyWithImpl<$Res>
    implements $SimilarUserCopyWith<$Res> {
  _$SimilarUserCopyWithImpl(this._self, this._then);

  final SimilarUser _self;
  final $Res Function(SimilarUser) _then;

/// Create a copy of SimilarUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? name = null,Object? avatarUrl = freezed,Object? gender = null,Object? createdAt = null,Object? updatedAt = null,Object? similarity = null,}) {
  return _then(SimilarUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SimilarUser].
extension SimilarUserPatterns on SimilarUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimilarUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimilarUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimilarUser value)  $default,){
final _that = this;
switch (_that) {
case _SimilarUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimilarUser value)?  $default,){
final _that = this;
switch (_that) {
case _SimilarUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String email,  String name, @JsonKey(name: 'avatar_url')  String? avatarUrl,  int gender, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  double similarity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimilarUser() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.gender,_that.createdAt,_that.updatedAt,_that.similarity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String email,  String name, @JsonKey(name: 'avatar_url')  String? avatarUrl,  int gender, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  double similarity)  $default,) {final _that = this;
switch (_that) {
case _SimilarUser():
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.gender,_that.createdAt,_that.updatedAt,_that.similarity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String id,  String email,  String name, @JsonKey(name: 'avatar_url')  String? avatarUrl,  int gender, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  double similarity)?  $default,) {final _that = this;
switch (_that) {
case _SimilarUser() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.gender,_that.createdAt,_that.updatedAt,_that.similarity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SimilarUser implements SimilarUser {
  const _SimilarUser({@JsonKey(name: '_id') required this.id, this.email = '', required this.name, @JsonKey(name: 'avatar_url') this.avatarUrl, required this.gender, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, required this.similarity});
  factory _SimilarUser.fromJson(Map<String, dynamic> json) => _$SimilarUserFromJson(json);

@override@JsonKey(name: '_id') final  String id;
@override@JsonKey() final  String email;
@override final  String name;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override final  int gender;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override final  double similarity;

/// Create a copy of SimilarUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimilarUserCopyWith<_SimilarUser> get copyWith => __$SimilarUserCopyWithImpl<_SimilarUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimilarUserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimilarUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.similarity, similarity) || other.similarity == similarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,name,avatarUrl,gender,createdAt,updatedAt,similarity);
}

@override
String toString() {
    return 'SimilarUser(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, gender: $gender, createdAt: $createdAt, updatedAt: $updatedAt, similarity: $similarity)';
}


}

/// @nodoc
abstract mixin class _$SimilarUserCopyWith<$Res> implements $SimilarUserCopyWith<$Res> {
  factory _$SimilarUserCopyWith(_SimilarUser value, $Res Function(_SimilarUser) _then) = __$SimilarUserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id, String email, String name,@JsonKey(name: 'avatar_url') String? avatarUrl, int gender,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, double similarity
});




}
/// @nodoc
class __$SimilarUserCopyWithImpl<$Res>
    implements _$SimilarUserCopyWith<$Res> {
  __$SimilarUserCopyWithImpl(this._self, this._then);

  final _SimilarUser _self;
  final $Res Function(_SimilarUser) _then;

/// Create a copy of SimilarUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? name = null,Object? avatarUrl = freezed,Object? gender = null,Object? createdAt = null,Object? updatedAt = null,Object? similarity = null,}) {
  return _then(_SimilarUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
