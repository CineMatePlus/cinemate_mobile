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
mixin _$CollectionDetailState {
  Collection? get collection => throw _privateConstructorUsedError;
  List<Movie> get movies => throw _privateConstructorUsedError;
  List<Movie> get recommendations => throw _privateConstructorUsedError;

  /// Create a copy of CollectionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionDetailStateCopyWith<CollectionDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionDetailStateCopyWith<$Res> {
  factory $CollectionDetailStateCopyWith(CollectionDetailState value,
          $Res Function(CollectionDetailState) then) =
      _$CollectionDetailStateCopyWithImpl<$Res, CollectionDetailState>;
  @useResult
  $Res call(
      {Collection? collection,
      List<Movie> movies,
      List<Movie> recommendations});

  $CollectionCopyWith<$Res>? get collection;
}

/// @nodoc
class _$CollectionDetailStateCopyWithImpl<$Res,
        $Val extends CollectionDetailState>
    implements $CollectionDetailStateCopyWith<$Res> {
  _$CollectionDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = freezed,
    Object? movies = null,
    Object? recommendations = null,
  }) {
    return _then(_value.copyWith(
      collection: freezed == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Collection?,
      movies: null == movies
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ) as $Val);
  }

  /// Create a copy of CollectionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CollectionCopyWith<$Res>? get collection {
    if (_value.collection == null) {
      return null;
    }

    return $CollectionCopyWith<$Res>(_value.collection!, (value) {
      return _then(_value.copyWith(collection: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CollectionDetailStateImplCopyWith<$Res>
    implements $CollectionDetailStateCopyWith<$Res> {
  factory _$$CollectionDetailStateImplCopyWith(
          _$CollectionDetailStateImpl value,
          $Res Function(_$CollectionDetailStateImpl) then) =
      __$$CollectionDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Collection? collection,
      List<Movie> movies,
      List<Movie> recommendations});

  @override
  $CollectionCopyWith<$Res>? get collection;
}

/// @nodoc
class __$$CollectionDetailStateImplCopyWithImpl<$Res>
    extends _$CollectionDetailStateCopyWithImpl<$Res,
        _$CollectionDetailStateImpl>
    implements _$$CollectionDetailStateImplCopyWith<$Res> {
  __$$CollectionDetailStateImplCopyWithImpl(_$CollectionDetailStateImpl _value,
      $Res Function(_$CollectionDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = freezed,
    Object? movies = null,
    Object? recommendations = null,
  }) {
    return _then(_$CollectionDetailStateImpl(
      collection: freezed == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as Collection?,
      movies: null == movies
          ? _value._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ));
  }
}

/// @nodoc

class _$CollectionDetailStateImpl implements _CollectionDetailState {
  const _$CollectionDetailStateImpl(
      {this.collection,
      final List<Movie> movies = const [],
      final List<Movie> recommendations = const []})
      : _movies = movies,
        _recommendations = recommendations;

  @override
  final Collection? collection;
  final List<Movie> _movies;
  @override
  @JsonKey()
  List<Movie> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  final List<Movie> _recommendations;
  @override
  @JsonKey()
  List<Movie> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'CollectionDetailState(collection: $collection, movies: $movies, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionDetailStateImpl &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            const DeepCollectionEquality().equals(other._movies, _movies) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      collection,
      const DeepCollectionEquality().hash(_movies),
      const DeepCollectionEquality().hash(_recommendations));

  /// Create a copy of CollectionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionDetailStateImplCopyWith<_$CollectionDetailStateImpl>
      get copyWith => __$$CollectionDetailStateImplCopyWithImpl<
          _$CollectionDetailStateImpl>(this, _$identity);
}

abstract class _CollectionDetailState implements CollectionDetailState {
  const factory _CollectionDetailState(
      {final Collection? collection,
      final List<Movie> movies,
      final List<Movie> recommendations}) = _$CollectionDetailStateImpl;

  @override
  Collection? get collection;
  @override
  List<Movie> get movies;
  @override
  List<Movie> get recommendations;

  /// Create a copy of CollectionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionDetailStateImplCopyWith<_$CollectionDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
