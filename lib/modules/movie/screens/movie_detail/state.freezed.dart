// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MovieDetailScreenState {
  Movie? get movie => throw _privateConstructorUsedError;
  List<Movie> get relatedMovies => throw _privateConstructorUsedError;

  /// Create a copy of MovieDetailScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieDetailScreenStateCopyWith<MovieDetailScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieDetailScreenStateCopyWith<$Res> {
  factory $MovieDetailScreenStateCopyWith(MovieDetailScreenState value,
          $Res Function(MovieDetailScreenState) then) =
      _$MovieDetailScreenStateCopyWithImpl<$Res, MovieDetailScreenState>;
  @useResult
  $Res call({Movie? movie, List<Movie> relatedMovies});

  $MovieCopyWith<$Res>? get movie;
}

/// @nodoc
class _$MovieDetailScreenStateCopyWithImpl<$Res,
        $Val extends MovieDetailScreenState>
    implements $MovieDetailScreenStateCopyWith<$Res> {
  _$MovieDetailScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieDetailScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movie = freezed,
    Object? relatedMovies = null,
  }) {
    return _then(_value.copyWith(
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie?,
      relatedMovies: null == relatedMovies
          ? _value.relatedMovies
          : relatedMovies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ) as $Val);
  }

  /// Create a copy of MovieDetailScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MovieCopyWith<$Res>? get movie {
    if (_value.movie == null) {
      return null;
    }

    return $MovieCopyWith<$Res>(_value.movie!, (value) {
      return _then(_value.copyWith(movie: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MovieDetailScreenStateImplCopyWith<$Res>
    implements $MovieDetailScreenStateCopyWith<$Res> {
  factory _$$MovieDetailScreenStateImplCopyWith(
          _$MovieDetailScreenStateImpl value,
          $Res Function(_$MovieDetailScreenStateImpl) then) =
      __$$MovieDetailScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Movie? movie, List<Movie> relatedMovies});

  @override
  $MovieCopyWith<$Res>? get movie;
}

/// @nodoc
class __$$MovieDetailScreenStateImplCopyWithImpl<$Res>
    extends _$MovieDetailScreenStateCopyWithImpl<$Res,
        _$MovieDetailScreenStateImpl>
    implements _$$MovieDetailScreenStateImplCopyWith<$Res> {
  __$$MovieDetailScreenStateImplCopyWithImpl(
      _$MovieDetailScreenStateImpl _value,
      $Res Function(_$MovieDetailScreenStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieDetailScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movie = freezed,
    Object? relatedMovies = null,
  }) {
    return _then(_$MovieDetailScreenStateImpl(
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie?,
      relatedMovies: null == relatedMovies
          ? _value._relatedMovies
          : relatedMovies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ));
  }
}

/// @nodoc

class _$MovieDetailScreenStateImpl implements _MovieDetailScreenState {
  const _$MovieDetailScreenStateImpl(
      {this.movie, final List<Movie> relatedMovies = const []})
      : _relatedMovies = relatedMovies;

  @override
  final Movie? movie;
  final List<Movie> _relatedMovies;
  @override
  @JsonKey()
  List<Movie> get relatedMovies {
    if (_relatedMovies is EqualUnmodifiableListView) return _relatedMovies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedMovies);
  }

  @override
  String toString() {
    return 'MovieDetailScreenState(movie: $movie, relatedMovies: $relatedMovies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieDetailScreenStateImpl &&
            (identical(other.movie, movie) || other.movie == movie) &&
            const DeepCollectionEquality()
                .equals(other._relatedMovies, _relatedMovies));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, movie, const DeepCollectionEquality().hash(_relatedMovies));

  /// Create a copy of MovieDetailScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieDetailScreenStateImplCopyWith<_$MovieDetailScreenStateImpl>
      get copyWith => __$$MovieDetailScreenStateImplCopyWithImpl<
          _$MovieDetailScreenStateImpl>(this, _$identity);
}

abstract class _MovieDetailScreenState implements MovieDetailScreenState {
  const factory _MovieDetailScreenState(
      {final Movie? movie,
      final List<Movie> relatedMovies}) = _$MovieDetailScreenStateImpl;

  @override
  Movie? get movie;
  @override
  List<Movie> get relatedMovies;

  /// Create a copy of MovieDetailScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieDetailScreenStateImplCopyWith<_$MovieDetailScreenStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
