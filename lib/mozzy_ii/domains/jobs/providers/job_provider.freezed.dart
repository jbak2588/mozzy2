// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobFiltersState {

 String? get category; JobType? get jobType; String? get search;
/// Create a copy of JobFiltersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobFiltersStateCopyWith<JobFiltersState> get copyWith => _$JobFiltersStateCopyWithImpl<JobFiltersState>(this as JobFiltersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobFiltersState&&(identical(other.category, category) || other.category == category)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,category,jobType,search);

@override
String toString() {
  return 'JobFiltersState(category: $category, jobType: $jobType, search: $search)';
}


}

/// @nodoc
abstract mixin class $JobFiltersStateCopyWith<$Res>  {
  factory $JobFiltersStateCopyWith(JobFiltersState value, $Res Function(JobFiltersState) _then) = _$JobFiltersStateCopyWithImpl;
@useResult
$Res call({
 String? category, JobType? jobType, String? search
});




}
/// @nodoc
class _$JobFiltersStateCopyWithImpl<$Res>
    implements $JobFiltersStateCopyWith<$Res> {
  _$JobFiltersStateCopyWithImpl(this._self, this._then);

  final JobFiltersState _self;
  final $Res Function(JobFiltersState) _then;

/// Create a copy of JobFiltersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = freezed,Object? jobType = freezed,Object? search = freezed,}) {
  return _then(_self.copyWith(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as JobType?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobFiltersState].
extension JobFiltersStatePatterns on JobFiltersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobFiltersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobFiltersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobFiltersState value)  $default,){
final _that = this;
switch (_that) {
case _JobFiltersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobFiltersState value)?  $default,){
final _that = this;
switch (_that) {
case _JobFiltersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? category,  JobType? jobType,  String? search)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobFiltersState() when $default != null:
return $default(_that.category,_that.jobType,_that.search);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? category,  JobType? jobType,  String? search)  $default,) {final _that = this;
switch (_that) {
case _JobFiltersState():
return $default(_that.category,_that.jobType,_that.search);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? category,  JobType? jobType,  String? search)?  $default,) {final _that = this;
switch (_that) {
case _JobFiltersState() when $default != null:
return $default(_that.category,_that.jobType,_that.search);case _:
  return null;

}
}

}

/// @nodoc


class _JobFiltersState implements JobFiltersState {
  const _JobFiltersState({this.category, this.jobType, this.search});
  

@override final  String? category;
@override final  JobType? jobType;
@override final  String? search;

/// Create a copy of JobFiltersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobFiltersStateCopyWith<_JobFiltersState> get copyWith => __$JobFiltersStateCopyWithImpl<_JobFiltersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobFiltersState&&(identical(other.category, category) || other.category == category)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,category,jobType,search);

@override
String toString() {
  return 'JobFiltersState(category: $category, jobType: $jobType, search: $search)';
}


}

/// @nodoc
abstract mixin class _$JobFiltersStateCopyWith<$Res> implements $JobFiltersStateCopyWith<$Res> {
  factory _$JobFiltersStateCopyWith(_JobFiltersState value, $Res Function(_JobFiltersState) _then) = __$JobFiltersStateCopyWithImpl;
@override @useResult
$Res call({
 String? category, JobType? jobType, String? search
});




}
/// @nodoc
class __$JobFiltersStateCopyWithImpl<$Res>
    implements _$JobFiltersStateCopyWith<$Res> {
  __$JobFiltersStateCopyWithImpl(this._self, this._then);

  final _JobFiltersState _self;
  final $Res Function(_JobFiltersState) _then;

/// Create a copy of JobFiltersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? jobType = freezed,Object? search = freezed,}) {
  return _then(_JobFiltersState(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as JobType?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
