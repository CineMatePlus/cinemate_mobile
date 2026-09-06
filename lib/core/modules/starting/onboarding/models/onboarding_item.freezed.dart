// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingItem {

 String get title; String get subtitle; String get image;
/// Create a copy of OnboardingItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingItemCopyWith<OnboardingItem> get copyWith => _$OnboardingItemCopyWithImpl<OnboardingItem>(this as OnboardingItem, _$identity);

  /// Serializes this OnboardingItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OnboardingItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingItem&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.image, _this.image) || other.image == _this.image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OnboardingItem;
  return Object.hash(runtimeType,_this.title,_this.subtitle,_this.image);
}

@override
String toString() {
  final _this = this as OnboardingItem;
  return 'OnboardingItem(title: ${_this.title}, subtitle: ${_this.subtitle}, image: ${_this.image})';
}


}

/// @nodoc
abstract mixin class $OnboardingItemCopyWith<$Res>  {
  factory $OnboardingItemCopyWith(OnboardingItem value, $Res Function(OnboardingItem) _then) = _$OnboardingItemCopyWithImpl;
@useResult
$Res call({
 String title, String subtitle, String image
});




}
/// @nodoc
class _$OnboardingItemCopyWithImpl<$Res>
    implements $OnboardingItemCopyWith<$Res> {
  _$OnboardingItemCopyWithImpl(this._self, this._then);

  final OnboardingItem _self;
  final $Res Function(OnboardingItem) _then;

/// Create a copy of OnboardingItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subtitle = null,Object? image = null,}) {
  return _then(OnboardingItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingItem].
extension OnboardingItemPatterns on OnboardingItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingItem value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingItem value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String subtitle,  String image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingItem() when $default != null:
return $default(_that.title,_that.subtitle,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String subtitle,  String image)  $default,) {final _that = this;
switch (_that) {
case _OnboardingItem():
return $default(_that.title,_that.subtitle,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String subtitle,  String image)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingItem() when $default != null:
return $default(_that.title,_that.subtitle,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingItem implements OnboardingItem {
  const _OnboardingItem({required this.title, required this.subtitle, required this.image});
  factory _OnboardingItem.fromJson(Map<String, dynamic> json) => _$OnboardingItemFromJson(json);

@override final  String title;
@override final  String subtitle;
@override final  String image;

/// Create a copy of OnboardingItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingItemCopyWith<_OnboardingItem> get copyWith => __$OnboardingItemCopyWithImpl<_OnboardingItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingItem&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,subtitle,image);
}

@override
String toString() {
    return 'OnboardingItem(title: $title, subtitle: $subtitle, image: $image)';
}


}

/// @nodoc
abstract mixin class _$OnboardingItemCopyWith<$Res> implements $OnboardingItemCopyWith<$Res> {
  factory _$OnboardingItemCopyWith(_OnboardingItem value, $Res Function(_OnboardingItem) _then) = __$OnboardingItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String subtitle, String image
});




}
/// @nodoc
class __$OnboardingItemCopyWithImpl<$Res>
    implements _$OnboardingItemCopyWith<$Res> {
  __$OnboardingItemCopyWithImpl(this._self, this._then);

  final _OnboardingItem _self;
  final $Res Function(_OnboardingItem) _then;

/// Create a copy of OnboardingItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,Object? image = null,}) {
  return _then(_OnboardingItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
