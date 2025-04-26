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
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'content_id')
  String get contentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_liked')
  bool? get isLiked => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_watched')
  bool? get isWatched => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_watchlist')
  bool? get isInWatchlist => throw _privateConstructorUsedError;
  @JsonKey(name: 'rated')
  int? get rated => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_interacted_at')
  DateTime? get lastInteractedAt => throw _privateConstructorUsedError;

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
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'content_id') String contentId,
      @JsonKey(name: 'is_liked') bool? isLiked,
      @JsonKey(name: 'is_watched') bool? isWatched,
      @JsonKey(name: 'in_watchlist') bool? isInWatchlist,
      @JsonKey(name: 'rated') int? rated,
      @JsonKey(name: 'last_interacted_at') DateTime? lastInteractedAt});
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
    Object? id = freezed,
    Object? userId = null,
    Object? contentId = null,
    Object? isLiked = freezed,
    Object? isWatched = freezed,
    Object? isInWatchlist = freezed,
    Object? rated = freezed,
    Object? lastInteractedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      isWatched: freezed == isWatched
          ? _value.isWatched
          : isWatched // ignore: cast_nullable_to_non_nullable
              as bool?,
      isInWatchlist: freezed == isInWatchlist
          ? _value.isInWatchlist
          : isInWatchlist // ignore: cast_nullable_to_non_nullable
              as bool?,
      rated: freezed == rated
          ? _value.rated
          : rated // ignore: cast_nullable_to_non_nullable
              as int?,
      lastInteractedAt: freezed == lastInteractedAt
          ? _value.lastInteractedAt
          : lastInteractedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'content_id') String contentId,
      @JsonKey(name: 'is_liked') bool? isLiked,
      @JsonKey(name: 'is_watched') bool? isWatched,
      @JsonKey(name: 'in_watchlist') bool? isInWatchlist,
      @JsonKey(name: 'rated') int? rated,
      @JsonKey(name: 'last_interacted_at') DateTime? lastInteractedAt});
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
    Object? id = freezed,
    Object? userId = null,
    Object? contentId = null,
    Object? isLiked = freezed,
    Object? isWatched = freezed,
    Object? isInWatchlist = freezed,
    Object? rated = freezed,
    Object? lastInteractedAt = freezed,
  }) {
    return _then(_$UserContentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      isWatched: freezed == isWatched
          ? _value.isWatched
          : isWatched // ignore: cast_nullable_to_non_nullable
              as bool?,
      isInWatchlist: freezed == isInWatchlist
          ? _value.isInWatchlist
          : isInWatchlist // ignore: cast_nullable_to_non_nullable
              as bool?,
      rated: freezed == rated
          ? _value.rated
          : rated // ignore: cast_nullable_to_non_nullable
              as int?,
      lastInteractedAt: freezed == lastInteractedAt
          ? _value.lastInteractedAt
          : lastInteractedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserContentImpl implements _UserContent {
  const _$UserContentImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'content_id') required this.contentId,
      @JsonKey(name: 'is_liked') this.isLiked,
      @JsonKey(name: 'is_watched') this.isWatched,
      @JsonKey(name: 'in_watchlist') this.isInWatchlist,
      @JsonKey(name: 'rated') this.rated,
      @JsonKey(name: 'last_interacted_at') this.lastInteractedAt});

  factory _$UserContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserContentImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'content_id')
  final String contentId;
  @override
  @JsonKey(name: 'is_liked')
  final bool? isLiked;
  @override
  @JsonKey(name: 'is_watched')
  final bool? isWatched;
  @override
  @JsonKey(name: 'in_watchlist')
  final bool? isInWatchlist;
  @override
  @JsonKey(name: 'rated')
  final int? rated;
  @override
  @JsonKey(name: 'last_interacted_at')
  final DateTime? lastInteractedAt;

  @override
  String toString() {
    return 'UserContent(id: $id, userId: $userId, contentId: $contentId, isLiked: $isLiked, isWatched: $isWatched, isInWatchlist: $isInWatchlist, rated: $rated, lastInteractedAt: $lastInteractedAt)';
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
            (identical(other.isInWatchlist, isInWatchlist) ||
                other.isInWatchlist == isInWatchlist) &&
            (identical(other.rated, rated) || other.rated == rated) &&
            (identical(other.lastInteractedAt, lastInteractedAt) ||
                other.lastInteractedAt == lastInteractedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, contentId, isLiked,
      isWatched, isInWatchlist, rated, lastInteractedAt);

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
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'content_id') required final String contentId,
      @JsonKey(name: 'is_liked') final bool? isLiked,
      @JsonKey(name: 'is_watched') final bool? isWatched,
      @JsonKey(name: 'in_watchlist') final bool? isInWatchlist,
      @JsonKey(name: 'rated') final int? rated,
      @JsonKey(name: 'last_interacted_at')
      final DateTime? lastInteractedAt}) = _$UserContentImpl;

  factory _UserContent.fromJson(Map<String, dynamic> json) =
      _$UserContentImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'content_id')
  String get contentId;
  @override
  @JsonKey(name: 'is_liked')
  bool? get isLiked;
  @override
  @JsonKey(name: 'is_watched')
  bool? get isWatched;
  @override
  @JsonKey(name: 'in_watchlist')
  bool? get isInWatchlist;
  @override
  @JsonKey(name: 'rated')
  int? get rated;
  @override
  @JsonKey(name: 'last_interacted_at')
  DateTime? get lastInteractedAt;

  /// Create a copy of UserContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserContentImplCopyWith<_$UserContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
