// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mini_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MiniContent _$MiniContentFromJson(Map<String, dynamic> json) {
  return _MiniContent.fromJson(json);
}

/// @nodoc
mixin _$MiniContent {
  String get title => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_likes')
  int get numLikes => throw _privateConstructorUsedError;

  /// Serializes this MiniContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MiniContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MiniContentCopyWith<MiniContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MiniContentCopyWith<$Res> {
  factory $MiniContentCopyWith(
          MiniContent value, $Res Function(MiniContent) then) =
      _$MiniContentCopyWithImpl<$Res, MiniContent>;
  @useResult
  $Res call({String title, int year, @JsonKey(name: 'num_likes') int numLikes});
}

/// @nodoc
class _$MiniContentCopyWithImpl<$Res, $Val extends MiniContent>
    implements $MiniContentCopyWith<$Res> {
  _$MiniContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MiniContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? year = null,
    Object? numLikes = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      numLikes: null == numLikes
          ? _value.numLikes
          : numLikes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MiniContentImplCopyWith<$Res>
    implements $MiniContentCopyWith<$Res> {
  factory _$$MiniContentImplCopyWith(
          _$MiniContentImpl value, $Res Function(_$MiniContentImpl) then) =
      __$$MiniContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, int year, @JsonKey(name: 'num_likes') int numLikes});
}

/// @nodoc
class __$$MiniContentImplCopyWithImpl<$Res>
    extends _$MiniContentCopyWithImpl<$Res, _$MiniContentImpl>
    implements _$$MiniContentImplCopyWith<$Res> {
  __$$MiniContentImplCopyWithImpl(
      _$MiniContentImpl _value, $Res Function(_$MiniContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of MiniContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? year = null,
    Object? numLikes = null,
  }) {
    return _then(_$MiniContentImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      numLikes: null == numLikes
          ? _value.numLikes
          : numLikes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MiniContentImpl implements _MiniContent {
  const _$MiniContentImpl(
      {required this.title,
      required this.year,
      @JsonKey(name: 'num_likes') required this.numLikes});

  factory _$MiniContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MiniContentImplFromJson(json);

  @override
  final String title;
  @override
  final int year;
  @override
  @JsonKey(name: 'num_likes')
  final int numLikes;

  @override
  String toString() {
    return 'MiniContent(title: $title, year: $year, numLikes: $numLikes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MiniContentImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.numLikes, numLikes) ||
                other.numLikes == numLikes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, year, numLikes);

  /// Create a copy of MiniContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MiniContentImplCopyWith<_$MiniContentImpl> get copyWith =>
      __$$MiniContentImplCopyWithImpl<_$MiniContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MiniContentImplToJson(
      this,
    );
  }
}

abstract class _MiniContent implements MiniContent {
  const factory _MiniContent(
          {required final String title,
          required final int year,
          @JsonKey(name: 'num_likes') required final int numLikes}) =
      _$MiniContentImpl;

  factory _MiniContent.fromJson(Map<String, dynamic> json) =
      _$MiniContentImpl.fromJson;

  @override
  String get title;
  @override
  int get year;
  @override
  @JsonKey(name: 'num_likes')
  int get numLikes;

  /// Create a copy of MiniContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MiniContentImplCopyWith<_$MiniContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
