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
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get numLikes => throw _privateConstructorUsedError;
  int get numWatches => throw _privateConstructorUsedError;
  int get numRatings => throw _privateConstructorUsedError;
  int get numComments => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get type => throw _privateConstructorUsedError;

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
      {String id,
      String title,
      String description,
      List<String> genres,
      int year,
      double averageRating,
      int numLikes,
      int numWatches,
      int numRatings,
      int numComments,
      DateTime createdAt,
      DateTime updatedAt,
      bool type});
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
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? genres = null,
    Object? year = null,
    Object? averageRating = null,
    Object? numLikes = null,
    Object? numWatches = null,
    Object? numRatings = null,
    Object? numComments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      numLikes: null == numLikes
          ? _value.numLikes
          : numLikes // ignore: cast_nullable_to_non_nullable
              as int,
      numWatches: null == numWatches
          ? _value.numWatches
          : numWatches // ignore: cast_nullable_to_non_nullable
              as int,
      numRatings: null == numRatings
          ? _value.numRatings
          : numRatings // ignore: cast_nullable_to_non_nullable
              as int,
      numComments: null == numComments
          ? _value.numComments
          : numComments // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {String id,
      String title,
      String description,
      List<String> genres,
      int year,
      double averageRating,
      int numLikes,
      int numWatches,
      int numRatings,
      int numComments,
      DateTime createdAt,
      DateTime updatedAt,
      bool type});
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
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? genres = null,
    Object? year = null,
    Object? averageRating = null,
    Object? numLikes = null,
    Object? numWatches = null,
    Object? numRatings = null,
    Object? numComments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? type = null,
  }) {
    return _then(_$ContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      numLikes: null == numLikes
          ? _value.numLikes
          : numLikes // ignore: cast_nullable_to_non_nullable
              as int,
      numWatches: null == numWatches
          ? _value.numWatches
          : numWatches // ignore: cast_nullable_to_non_nullable
              as int,
      numRatings: null == numRatings
          ? _value.numRatings
          : numRatings // ignore: cast_nullable_to_non_nullable
              as int,
      numComments: null == numComments
          ? _value.numComments
          : numComments // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentImpl implements _Content {
  const _$ContentImpl(
      {required this.id,
      required this.title,
      required this.description,
      required final List<String> genres,
      required this.year,
      required this.averageRating,
      required this.numLikes,
      required this.numWatches,
      required this.numRatings,
      required this.numComments,
      required this.createdAt,
      required this.updatedAt,
      required this.type})
      : _genres = genres;

  factory _$ContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  final List<String> _genres;
  @override
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  final int year;
  @override
  final double averageRating;
  @override
  final int numLikes;
  @override
  final int numWatches;
  @override
  final int numRatings;
  @override
  final int numComments;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final bool type;

  @override
  String toString() {
    return 'Content(id: $id, title: $title, description: $description, genres: $genres, year: $year, averageRating: $averageRating, numLikes: $numLikes, numWatches: $numWatches, numRatings: $numRatings, numComments: $numComments, createdAt: $createdAt, updatedAt: $updatedAt, type: $type)';
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
            (identical(other.type, type) || other.type == type));
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
      type);

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
      {required final String id,
      required final String title,
      required final String description,
      required final List<String> genres,
      required final int year,
      required final double averageRating,
      required final int numLikes,
      required final int numWatches,
      required final int numRatings,
      required final int numComments,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final bool type}) = _$ContentImpl;

  factory _Content.fromJson(Map<String, dynamic> json) = _$ContentImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  List<String> get genres;
  @override
  int get year;
  @override
  double get averageRating;
  @override
  int get numLikes;
  @override
  int get numWatches;
  @override
  int get numRatings;
  @override
  int get numComments;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get type;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
