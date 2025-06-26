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
mixin _$CollectionsListState {
  List<Collection> get collections => throw _privateConstructorUsedError;

  /// Create a copy of CollectionsListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionsListStateCopyWith<CollectionsListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionsListStateCopyWith<$Res> {
  factory $CollectionsListStateCopyWith(CollectionsListState value,
          $Res Function(CollectionsListState) then) =
      _$CollectionsListStateCopyWithImpl<$Res, CollectionsListState>;
  @useResult
  $Res call({List<Collection> collections});
}

/// @nodoc
class _$CollectionsListStateCopyWithImpl<$Res,
        $Val extends CollectionsListState>
    implements $CollectionsListStateCopyWith<$Res> {
  _$CollectionsListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionsListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collections = null,
  }) {
    return _then(_value.copyWith(
      collections: null == collections
          ? _value.collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<Collection>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectionsListStateImplCopyWith<$Res>
    implements $CollectionsListStateCopyWith<$Res> {
  factory _$$CollectionsListStateImplCopyWith(_$CollectionsListStateImpl value,
          $Res Function(_$CollectionsListStateImpl) then) =
      __$$CollectionsListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Collection> collections});
}

/// @nodoc
class __$$CollectionsListStateImplCopyWithImpl<$Res>
    extends _$CollectionsListStateCopyWithImpl<$Res, _$CollectionsListStateImpl>
    implements _$$CollectionsListStateImplCopyWith<$Res> {
  __$$CollectionsListStateImplCopyWithImpl(_$CollectionsListStateImpl _value,
      $Res Function(_$CollectionsListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectionsListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collections = null,
  }) {
    return _then(_$CollectionsListStateImpl(
      collections: null == collections
          ? _value._collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<Collection>,
    ));
  }
}

/// @nodoc

class _$CollectionsListStateImpl implements _CollectionsListState {
  const _$CollectionsListStateImpl(
      {final List<Collection> collections = const []})
      : _collections = collections;

  final List<Collection> _collections;
  @override
  @JsonKey()
  List<Collection> get collections {
    if (_collections is EqualUnmodifiableListView) return _collections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collections);
  }

  @override
  String toString() {
    return 'CollectionsListState(collections: $collections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionsListStateImpl &&
            const DeepCollectionEquality()
                .equals(other._collections, _collections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_collections));

  /// Create a copy of CollectionsListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionsListStateImplCopyWith<_$CollectionsListStateImpl>
      get copyWith =>
          __$$CollectionsListStateImplCopyWithImpl<_$CollectionsListStateImpl>(
              this, _$identity);
}

abstract class _CollectionsListState implements CollectionsListState {
  const factory _CollectionsListState({final List<Collection> collections}) =
      _$CollectionsListStateImpl;

  @override
  List<Collection> get collections;

  /// Create a copy of CollectionsListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionsListStateImplCopyWith<_$CollectionsListStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
