// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Content _$ContentFromJson(Map<String, dynamic> json) {
  return _Content.fromJson(json);
}

/// @nodoc
mixin _$Content {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get genres => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rating')
  double? get averageRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_likes')
  int? get numLikes => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_watches')
  int? get numWatches => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_ratings')
  int? get numRatings => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_comments')
  int? get numComments => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool? get type =>
      throw _privateConstructorUsedError; // true: dizi, false: film
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Content to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentCopyWith<Content> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentCopyWith<$Res> {
  factory $ContentCopyWith(Content value, $Res Function(Content) then) =
      _$ContentCopyWithImpl<$Res, Content>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? title,
      String? description,
      List<String>? genres,
      int? year,
      @JsonKey(name: 'average_rating') double? averageRating,
      @JsonKey(name: 'num_likes') int? numLikes,
      @JsonKey(name: 'num_watches') int? numWatches,
      @JsonKey(name: 'num_ratings') int? numRatings,
      @JsonKey(name: 'num_comments') int? numComments,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      bool? type,
      @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class _$ContentCopyWithImpl<$Res, $Val extends Content>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? genres = freezed,
    Object? year = freezed,
    Object? averageRating = freezed,
    Object? numLikes = freezed,
    Object? numWatches = freezed,
    Object? numRatings = freezed,
    Object? numComments = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? type = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: freezed == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      numLikes: freezed == numLikes
          ? _value.numLikes
          : numLikes // ignore: cast_nullable_to_non_nullable
              as int?,
      numWatches: freezed == numWatches
          ? _value.numWatches
          : numWatches // ignore: cast_nullable_to_non_nullable
              as int?,
      numRatings: freezed == numRatings
          ? _value.numRatings
          : numRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      numComments: freezed == numComments
          ? _value.numComments
          : numComments // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as bool?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? title,
      String? description,
      List<String>? genres,
      int? year,
      @JsonKey(name: 'average_rating') double? averageRating,
      @JsonKey(name: 'num_likes') int? numLikes,
      @JsonKey(name: 'num_watches') int? numWatches,
      @JsonKey(name: 'num_ratings') int? numRatings,
      @JsonKey(name: 'num_comments') int? numComments,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      bool? type,
      @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ContentCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? genres = freezed,
    Object? year = freezed,
    Object? averageRating = freezed,
    Object? numLikes = freezed,
    Object? numWatches = freezed,
    Object? numRatings = freezed,
    Object? numComments = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? type = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$ContentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: freezed == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      numLikes: freezed == numLikes
          ? _value.numLikes
          : numLikes // ignore: cast_nullable_to_non_nullable
              as int?,
      numWatches: freezed == numWatches
          ? _value.numWatches
          : numWatches // ignore: cast_nullable_to_non_nullable
              as int?,
      numRatings: freezed == numRatings
          ? _value.numRatings
          : numRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      numComments: freezed == numComments
          ? _value.numComments
          : numComments // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as bool?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentImpl implements _Content {
  const _$ContentImpl(
      {@JsonKey(name: '_id') this.id,
      this.title,
      this.description,
      final List<String>? genres,
      this.year,
      @JsonKey(name: 'average_rating') this.averageRating,
      @JsonKey(name: 'num_likes') this.numLikes,
      @JsonKey(name: 'num_watches') this.numWatches,
      @JsonKey(name: 'num_ratings') this.numRatings,
      @JsonKey(name: 'num_comments') this.numComments,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.type,
      @JsonKey(name: 'image_url') this.imageUrl})
      : _genres = genres;

  factory _$ContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? title;
  @override
  final String? description;
  final List<String>? _genres;
  @override
  List<String>? get genres {
    final value = _genres;
    if (value == null) return null;
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? year;
  @override
  @JsonKey(name: 'average_rating')
  final double? averageRating;
  @override
  @JsonKey(name: 'num_likes')
  final int? numLikes;
  @override
  @JsonKey(name: 'num_watches')
  final int? numWatches;
  @override
  @JsonKey(name: 'num_ratings')
  final int? numRatings;
  @override
  @JsonKey(name: 'num_comments')
  final int? numComments;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  final bool? type;
// true: dizi, false: film
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'Content(id: $id, title: $title, description: $description, genres: $genres, year: $year, averageRating: $averageRating, numLikes: $numLikes, numWatches: $numWatches, numRatings: $numRatings, numComments: $numComments, createdAt: $createdAt, updatedAt: $updatedAt, type: $type, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.numLikes, numLikes) ||
                other.numLikes == numLikes) &&
            (identical(other.numWatches, numWatches) ||
                other.numWatches == numWatches) &&
            (identical(other.numRatings, numRatings) ||
                other.numRatings == numRatings) &&
            (identical(other.numComments, numComments) ||
                other.numComments == numComments) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_genres),
      year,
      averageRating,
      numLikes,
      numWatches,
      numRatings,
      numComments,
      createdAt,
      updatedAt,
      type,
      imageUrl);

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentImplToJson(
      this,
    );
  }
}

abstract class _Content implements Content {
  const factory _Content(
      {@JsonKey(name: '_id') final String? id,
      final String? title,
      final String? description,
      final List<String>? genres,
      final int? year,
      @JsonKey(name: 'average_rating') final double? averageRating,
      @JsonKey(name: 'num_likes') final int? numLikes,
      @JsonKey(name: 'num_watches') final int? numWatches,
      @JsonKey(name: 'num_ratings') final int? numRatings,
      @JsonKey(name: 'num_comments') final int? numComments,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      final bool? type,
      @JsonKey(name: 'image_url') final String? imageUrl}) = _$ContentImpl;

  factory _Content.fromJson(Map<String, dynamic> json) = _$ContentImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  List<String>? get genres;
  @override
  int? get year;
  @override
  @JsonKey(name: 'average_rating')
  double? get averageRating;
  @override
  @JsonKey(name: 'num_likes')
  int? get numLikes;
  @override
  @JsonKey(name: 'num_watches')
  int? get numWatches;
  @override
  @JsonKey(name: 'num_ratings')
  int? get numRatings;
  @override
  @JsonKey(name: 'num_comments')
  int? get numComments;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  bool? get type; // true: dizi, false: film
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
