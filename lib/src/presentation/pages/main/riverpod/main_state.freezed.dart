// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MainState {
  bool get isShopsLoading => throw _privateConstructorUsedError;
  bool get isMoreShopsLoading => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  List<ShopData> get shops => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  int get selectIndex => throw _privateConstructorUsedError;

  /// Create a copy of MainState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MainStateCopyWith<MainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res, MainState>;
  @useResult
  $Res call(
      {bool isShopsLoading,
      bool isMoreShopsLoading,
      bool hasMore,
      List<ShopData> shops,
      String query,
      int selectIndex});
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res, $Val extends MainState>
    implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MainState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isShopsLoading = null,
    Object? isMoreShopsLoading = null,
    Object? hasMore = null,
    Object? shops = null,
    Object? query = null,
    Object? selectIndex = null,
  }) {
    return _then(_value.copyWith(
      isShopsLoading: null == isShopsLoading
          ? _value.isShopsLoading
          : isShopsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreShopsLoading: null == isMoreShopsLoading
          ? _value.isMoreShopsLoading
          : isMoreShopsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      shops: null == shops
          ? _value.shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopData>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      selectIndex: null == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainStateImplCopyWith<$Res>
    implements $MainStateCopyWith<$Res> {
  factory _$$MainStateImplCopyWith(
          _$MainStateImpl value, $Res Function(_$MainStateImpl) then) =
      __$$MainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isShopsLoading,
      bool isMoreShopsLoading,
      bool hasMore,
      List<ShopData> shops,
      String query,
      int selectIndex});
}

/// @nodoc
class __$$MainStateImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainStateImpl>
    implements _$$MainStateImplCopyWith<$Res> {
  __$$MainStateImplCopyWithImpl(
      _$MainStateImpl _value, $Res Function(_$MainStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MainState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isShopsLoading = null,
    Object? isMoreShopsLoading = null,
    Object? hasMore = null,
    Object? shops = null,
    Object? query = null,
    Object? selectIndex = null,
  }) {
    return _then(_$MainStateImpl(
      isShopsLoading: null == isShopsLoading
          ? _value.isShopsLoading
          : isShopsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreShopsLoading: null == isMoreShopsLoading
          ? _value.isMoreShopsLoading
          : isMoreShopsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      shops: null == shops
          ? _value._shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopData>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      selectIndex: null == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MainStateImpl extends _MainState {
  const _$MainStateImpl(
      {this.isShopsLoading = false,
      this.isMoreShopsLoading = false,
      this.hasMore = true,
      final List<ShopData> shops = const [],
      this.query = '',
      this.selectIndex = 0})
      : _shops = shops,
        super._();

  @override
  @JsonKey()
  final bool isShopsLoading;
  @override
  @JsonKey()
  final bool isMoreShopsLoading;
  @override
  @JsonKey()
  final bool hasMore;
  final List<ShopData> _shops;
  @override
  @JsonKey()
  List<ShopData> get shops {
    if (_shops is EqualUnmodifiableListView) return _shops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shops);
  }

  @override
  @JsonKey()
  final String query;
  @override
  @JsonKey()
  final int selectIndex;

  @override
  String toString() {
    return 'MainState(isShopsLoading: $isShopsLoading, isMoreShopsLoading: $isMoreShopsLoading, hasMore: $hasMore, shops: $shops, query: $query, selectIndex: $selectIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainStateImpl &&
            (identical(other.isShopsLoading, isShopsLoading) ||
                other.isShopsLoading == isShopsLoading) &&
            (identical(other.isMoreShopsLoading, isMoreShopsLoading) ||
                other.isMoreShopsLoading == isMoreShopsLoading) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            const DeepCollectionEquality().equals(other._shops, _shops) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.selectIndex, selectIndex) ||
                other.selectIndex == selectIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isShopsLoading,
      isMoreShopsLoading,
      hasMore,
      const DeepCollectionEquality().hash(_shops),
      query,
      selectIndex);

  /// Create a copy of MainState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      __$$MainStateImplCopyWithImpl<_$MainStateImpl>(this, _$identity);
}

abstract class _MainState extends MainState {
  const factory _MainState(
      {final bool isShopsLoading,
      final bool isMoreShopsLoading,
      final bool hasMore,
      final List<ShopData> shops,
      final String query,
      final int selectIndex}) = _$MainStateImpl;
  const _MainState._() : super._();

  @override
  bool get isShopsLoading;
  @override
  bool get isMoreShopsLoading;
  @override
  bool get hasMore;
  @override
  List<ShopData> get shops;
  @override
  String get query;
  @override
  int get selectIndex;

  /// Create a copy of MainState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
