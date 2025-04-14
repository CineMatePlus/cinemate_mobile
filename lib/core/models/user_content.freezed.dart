// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserContent _$UserContentFromJson(Map<String, dynamic> json) {
  return _UserContent.fromJson(json);
}

/// @nodoc
mixin _$UserContent {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get contentId => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;
  bool get isWatched => throw _privateConstructorUsedError;
  bool get inWatchlist => throw _privateConstructorUsedError;
  int? get rated => throw _privateConstructorUsedError;
  DateTime get lastInteractedAt => throw _privateConstructorUsedError;

  /// Serializes this UserContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserContentCopyWith<UserContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserContentCopyWith<$Res> {
  factory $UserContentCopyWith(
          UserContent value, $Res Function(UserContent) then) =
      _$UserContentCopyWithImpl<$Res, UserContent>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String contentId,
      bool isLiked,
      bool isWatched,
      bool inWatchlist,
      int? rated,
      DateTime lastInteractedAt});
}

/// @nodoc
class _$UserContentCopyWithImpl<$Res, $Val extends UserContent>
    implements $UserContentCopyWith<$Res> {
  _$UserContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? contentId = null,
    Object? isLiked = null,
    Object? isWatched = null,
    Object? inWatchlist = null,
    Object? rated = freezed,
    Object? lastInteractedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isWatched: null == isWatched
          ? _value.isWatched
          : isWatched // ignore: cast_nullable_to_non_nullable
              as bool,
      inWatchlist: null == inWatchlist
          ? _value.inWatchlist
          : inWatchlist // ignore: cast_nullable_to_non_nullable
              as bool,
      rated: freezed == rated
          ? _value.rated
          : rated // ignore: cast_nullable_to_non_nullable
              as int?,
      lastInteractedAt: null == lastInteractedAt
          ? _value.lastInteractedAt
          : lastInteractedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserContentImplCopyWith<$Res>
    implements $UserContentCopyWith<$Res> {
  factory _$$UserContentImplCopyWith(
          _$UserContentImpl value, $Res Function(_$UserContentImpl) then) =
      __$$UserContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String contentId,
      bool isLiked,
      bool isWatched,
      bool inWatchlist,
      int? rated,
      DateTime lastInteractedAt});
}

/// @nodoc
class __$$UserContentImplCopyWithImpl<$Res>
    extends _$UserContentCopyWithImpl<$Res, _$UserContentImpl>
    implements _$$UserContentImplCopyWith<$Res> {
  __$$UserContentImplCopyWithImpl(
      _$UserContentImpl _value, $Res Function(_$UserContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? contentId = null,
    Object? isLiked = null,
    Object? isWatched = null,
    Object? inWatchlist = null,
    Object? rated = freezed,
    Object? lastInteractedAt = null,
  }) {
    return _then(_$UserContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isWatched: null == isWatched
          ? _value.isWatched
          : isWatched // ignore: cast_nullable_to_non_nullable
              as bool,
      inWatchlist: null == inWatchlist
          ? _value.inWatchlist
          : inWatchlist // ignore: cast_nullable_to_non_nullable
              as bool,
      rated: freezed == rated
          ? _value.rated
          : rated // ignore: cast_nullable_to_non_nullable
              as int?,
      lastInteractedAt: null == lastInteractedAt
          ? _value.lastInteractedAt
          : lastInteractedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserContentImpl implements _UserContent {
  const _$UserContentImpl(
      {required this.id,
      required this.userId,
      required this.contentId,
      this.isLiked = false,
      this.isWatched = false,
      this.inWatchlist = false,
      this.rated,
      required this.lastInteractedAt});

  factory _$UserContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserContentImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String contentId;
  @override
  @JsonKey()
  final bool isLiked;
  @override
  @JsonKey()
  final bool isWatched;
  @override
  @JsonKey()
  final bool inWatchlist;
  @override
  final int? rated;
  @override
  final DateTime lastInteractedAt;

  @override
  String toString() {
    return 'UserContent(id: $id, userId: $userId, contentId: $contentId, isLiked: $isLiked, isWatched: $isWatched, inWatchlist: $inWatchlist, rated: $rated, lastInteractedAt: $lastInteractedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.isWatched, isWatched) ||
                other.isWatched == isWatched) &&
            (identical(other.inWatchlist, inWatchlist) ||
                other.inWatchlist == inWatchlist) &&
            (identical(other.rated, rated) || other.rated == rated) &&
            (identical(other.lastInteractedAt, lastInteractedAt) ||
                other.lastInteractedAt == lastInteractedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, contentId, isLiked,
      isWatched, inWatchlist, rated, lastInteractedAt);

  /// Create a copy of UserContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserContentImplCopyWith<_$UserContentImpl> get copyWith =>
      __$$UserContentImplCopyWithImpl<_$UserContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserContentImplToJson(
      this,
    );
  }
}

abstract class _UserContent implements UserContent {
  const factory _UserContent(
      {required final String id,
      required final String userId,
      required final String contentId,
      final bool isLiked,
      final bool isWatched,
      final bool inWatchlist,
      final int? rated,
      required final DateTime lastInteractedAt}) = _$UserContentImpl;

  factory _UserContent.fromJson(Map<String, dynamic> json) =
      _$UserContentImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get contentId;
  @override
  bool get isLiked;
  @override
  bool get isWatched;
  @override
  bool get inWatchlist;
  @override
  int? get rated;
  @override
  DateTime get lastInteractedAt;

  /// Create a copy of UserContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserContentImplCopyWith<_$UserContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
