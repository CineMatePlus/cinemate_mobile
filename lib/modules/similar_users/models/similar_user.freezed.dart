// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'similar_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SimilarUser _$SimilarUserFromJson(Map<String, dynamic> json) {
  return _SimilarUser.fromJson(json);
}

/// @nodoc
mixin _$SimilarUser {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  int get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  double get similarity => throw _privateConstructorUsedError;

  /// Serializes this SimilarUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimilarUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimilarUserCopyWith<SimilarUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimilarUserCopyWith<$Res> {
  factory $SimilarUserCopyWith(
          SimilarUser value, $Res Function(SimilarUser) then) =
      _$SimilarUserCopyWithImpl<$Res, SimilarUser>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String email,
      String name,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      int gender,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      double similarity});
}

/// @nodoc
class _$SimilarUserCopyWithImpl<$Res, $Val extends SimilarUser>
    implements $SimilarUserCopyWith<$Res> {
  _$SimilarUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimilarUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? gender = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? similarity = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      similarity: null == similarity
          ? _value.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SimilarUserImplCopyWith<$Res>
    implements $SimilarUserCopyWith<$Res> {
  factory _$$SimilarUserImplCopyWith(
          _$SimilarUserImpl value, $Res Function(_$SimilarUserImpl) then) =
      __$$SimilarUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String email,
      String name,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      int gender,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      double similarity});
}

/// @nodoc
class __$$SimilarUserImplCopyWithImpl<$Res>
    extends _$SimilarUserCopyWithImpl<$Res, _$SimilarUserImpl>
    implements _$$SimilarUserImplCopyWith<$Res> {
  __$$SimilarUserImplCopyWithImpl(
      _$SimilarUserImpl _value, $Res Function(_$SimilarUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of SimilarUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? avatarUrl = freezed,
    Object? gender = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? similarity = null,
  }) {
    return _then(_$SimilarUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      similarity: null == similarity
          ? _value.similarity
          : similarity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SimilarUserImpl implements _SimilarUser {
  const _$SimilarUserImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.email,
      required this.name,
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      required this.gender,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      required this.similarity});

  factory _$SimilarUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimilarUserImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  final int gender;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  final double similarity;

  @override
  String toString() {
    return 'SimilarUser(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, gender: $gender, createdAt: $createdAt, updatedAt: $updatedAt, similarity: $similarity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimilarUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.similarity, similarity) ||
                other.similarity == similarity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, name, avatarUrl,
      gender, createdAt, updatedAt, similarity);

  /// Create a copy of SimilarUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimilarUserImplCopyWith<_$SimilarUserImpl> get copyWith =>
      __$$SimilarUserImplCopyWithImpl<_$SimilarUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SimilarUserImplToJson(
      this,
    );
  }
}

abstract class _SimilarUser implements SimilarUser {
  const factory _SimilarUser(
      {@JsonKey(name: '_id') required final String id,
      required final String email,
      required final String name,
      @JsonKey(name: 'avatar_url') final String? avatarUrl,
      required final int gender,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      required final double similarity}) = _$SimilarUserImpl;

  factory _SimilarUser.fromJson(Map<String, dynamic> json) =
      _$SimilarUserImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get email;
  @override
  String get name;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  int get gender;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  double get similarity;

  /// Create a copy of SimilarUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimilarUserImplCopyWith<_$SimilarUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
