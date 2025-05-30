// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShopState {
  bool get isProductsLoading => throw _privateConstructorUsedError;
  bool get isMoreProductsLoading => throw _privateConstructorUsedError;
  bool get isBrandsLoading => throw _privateConstructorUsedError;
  bool get isCategoriesLoading => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  List<ProductData> get products => throw _privateConstructorUsedError;
  List<ProductData> get allProducts =>
      throw _privateConstructorUsedError; // Todos los productos cargados
  List<CategoryData> get categories => throw _privateConstructorUsedError;
  List<DropDownItemData> get dropDownCategories =>
      throw _privateConstructorUsedError;
  List<DropDownItemData> get dropDownBrands =>
      throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  String get categoryQuery => throw _privateConstructorUsedError;
  CategoryData? get selectedCategory => throw _privateConstructorUsedError;
  OrderData? get selectedOrder => throw _privateConstructorUsedError;

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopStateCopyWith<ShopState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopStateCopyWith<$Res> {
  factory $ShopStateCopyWith(ShopState value, $Res Function(ShopState) then) =
      _$ShopStateCopyWithImpl<$Res, ShopState>;
  @useResult
  $Res call(
      {bool isProductsLoading,
      bool isMoreProductsLoading,
      bool isBrandsLoading,
      bool isCategoriesLoading,
      bool hasMore,
      List<ProductData> products,
      List<ProductData> allProducts,
      List<CategoryData> categories,
      List<DropDownItemData> dropDownCategories,
      List<DropDownItemData> dropDownBrands,
      String query,
      String categoryQuery,
      CategoryData? selectedCategory,
      OrderData? selectedOrder});
}

/// @nodoc
class _$ShopStateCopyWithImpl<$Res, $Val extends ShopState>
    implements $ShopStateCopyWith<$Res> {
  _$ShopStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProductsLoading = null,
    Object? isMoreProductsLoading = null,
    Object? isBrandsLoading = null,
    Object? isCategoriesLoading = null,
    Object? hasMore = null,
    Object? products = null,
    Object? allProducts = null,
    Object? categories = null,
    Object? dropDownCategories = null,
    Object? dropDownBrands = null,
    Object? query = null,
    Object? categoryQuery = null,
    Object? selectedCategory = freezed,
    Object? selectedOrder = freezed,
  }) {
    return _then(_value.copyWith(
      isProductsLoading: null == isProductsLoading
          ? _value.isProductsLoading
          : isProductsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreProductsLoading: null == isMoreProductsLoading
          ? _value.isMoreProductsLoading
          : isMoreProductsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isBrandsLoading: null == isBrandsLoading
          ? _value.isBrandsLoading
          : isBrandsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCategoriesLoading: null == isCategoriesLoading
          ? _value.isCategoriesLoading
          : isCategoriesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      allProducts: null == allProducts
          ? _value.allProducts
          : allProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      dropDownCategories: null == dropDownCategories
          ? _value.dropDownCategories
          : dropDownCategories // ignore: cast_nullable_to_non_nullable
              as List<DropDownItemData>,
      dropDownBrands: null == dropDownBrands
          ? _value.dropDownBrands
          : dropDownBrands // ignore: cast_nullable_to_non_nullable
              as List<DropDownItemData>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      categoryQuery: null == categoryQuery
          ? _value.categoryQuery
          : categoryQuery // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
      selectedOrder: freezed == selectedOrder
          ? _value.selectedOrder
          : selectedOrder // ignore: cast_nullable_to_non_nullable
              as OrderData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShopStateImplCopyWith<$Res>
    implements $ShopStateCopyWith<$Res> {
  factory _$$ShopStateImplCopyWith(
          _$ShopStateImpl value, $Res Function(_$ShopStateImpl) then) =
      __$$ShopStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isProductsLoading,
      bool isMoreProductsLoading,
      bool isBrandsLoading,
      bool isCategoriesLoading,
      bool hasMore,
      List<ProductData> products,
      List<ProductData> allProducts,
      List<CategoryData> categories,
      List<DropDownItemData> dropDownCategories,
      List<DropDownItemData> dropDownBrands,
      String query,
      String categoryQuery,
      CategoryData? selectedCategory,
      OrderData? selectedOrder});
}

/// @nodoc
class __$$ShopStateImplCopyWithImpl<$Res>
    extends _$ShopStateCopyWithImpl<$Res, _$ShopStateImpl>
    implements _$$ShopStateImplCopyWith<$Res> {
  __$$ShopStateImplCopyWithImpl(
      _$ShopStateImpl _value, $Res Function(_$ShopStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProductsLoading = null,
    Object? isMoreProductsLoading = null,
    Object? isBrandsLoading = null,
    Object? isCategoriesLoading = null,
    Object? hasMore = null,
    Object? products = null,
    Object? allProducts = null,
    Object? categories = null,
    Object? dropDownCategories = null,
    Object? dropDownBrands = null,
    Object? query = null,
    Object? categoryQuery = null,
    Object? selectedCategory = freezed,
    Object? selectedOrder = freezed,
  }) {
    return _then(_$ShopStateImpl(
      isProductsLoading: null == isProductsLoading
          ? _value.isProductsLoading
          : isProductsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreProductsLoading: null == isMoreProductsLoading
          ? _value.isMoreProductsLoading
          : isMoreProductsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isBrandsLoading: null == isBrandsLoading
          ? _value.isBrandsLoading
          : isBrandsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCategoriesLoading: null == isCategoriesLoading
          ? _value.isCategoriesLoading
          : isCategoriesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      allProducts: null == allProducts
          ? _value._allProducts
          : allProducts // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      dropDownCategories: null == dropDownCategories
          ? _value._dropDownCategories
          : dropDownCategories // ignore: cast_nullable_to_non_nullable
              as List<DropDownItemData>,
      dropDownBrands: null == dropDownBrands
          ? _value._dropDownBrands
          : dropDownBrands // ignore: cast_nullable_to_non_nullable
              as List<DropDownItemData>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      categoryQuery: null == categoryQuery
          ? _value.categoryQuery
          : categoryQuery // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
      selectedOrder: freezed == selectedOrder
          ? _value.selectedOrder
          : selectedOrder // ignore: cast_nullable_to_non_nullable
              as OrderData?,
    ));
  }
}

/// @nodoc

class _$ShopStateImpl extends _ShopState {
  const _$ShopStateImpl(
      {this.isProductsLoading = false,
      this.isMoreProductsLoading = false,
      this.isBrandsLoading = false,
      this.isCategoriesLoading = false,
      this.hasMore = true,
      final List<ProductData> products = const [],
      final List<ProductData> allProducts = const [],
      final List<CategoryData> categories = const [],
      final List<DropDownItemData> dropDownCategories = const [],
      final List<DropDownItemData> dropDownBrands = const [],
      this.query = '',
      this.categoryQuery = '',
      this.selectedCategory,
      this.selectedOrder})
      : _products = products,
        _allProducts = allProducts,
        _categories = categories,
        _dropDownCategories = dropDownCategories,
        _dropDownBrands = dropDownBrands,
        super._();

  @override
  @JsonKey()
  final bool isProductsLoading;
  @override
  @JsonKey()
  final bool isMoreProductsLoading;
  @override
  @JsonKey()
  final bool isBrandsLoading;
  @override
  @JsonKey()
  final bool isCategoriesLoading;
  @override
  @JsonKey()
  final bool hasMore;
  final List<ProductData> _products;
  @override
  @JsonKey()
  List<ProductData> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<ProductData> _allProducts;
  @override
  @JsonKey()
  List<ProductData> get allProducts {
    if (_allProducts is EqualUnmodifiableListView) return _allProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allProducts);
  }

// Todos los productos cargados
  final List<CategoryData> _categories;
// Todos los productos cargados
  @override
  @JsonKey()
  List<CategoryData> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<DropDownItemData> _dropDownCategories;
  @override
  @JsonKey()
  List<DropDownItemData> get dropDownCategories {
    if (_dropDownCategories is EqualUnmodifiableListView)
      return _dropDownCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dropDownCategories);
  }

  final List<DropDownItemData> _dropDownBrands;
  @override
  @JsonKey()
  List<DropDownItemData> get dropDownBrands {
    if (_dropDownBrands is EqualUnmodifiableListView) return _dropDownBrands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dropDownBrands);
  }

  @override
  @JsonKey()
  final String query;
  @override
  @JsonKey()
  final String categoryQuery;
  @override
  final CategoryData? selectedCategory;
  @override
  final OrderData? selectedOrder;

  @override
  String toString() {
    return 'ShopState(isProductsLoading: $isProductsLoading, isMoreProductsLoading: $isMoreProductsLoading, isBrandsLoading: $isBrandsLoading, isCategoriesLoading: $isCategoriesLoading, hasMore: $hasMore, products: $products, allProducts: $allProducts, categories: $categories, dropDownCategories: $dropDownCategories, dropDownBrands: $dropDownBrands, query: $query, categoryQuery: $categoryQuery, selectedCategory: $selectedCategory, selectedOrder: $selectedOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopStateImpl &&
            (identical(other.isProductsLoading, isProductsLoading) ||
                other.isProductsLoading == isProductsLoading) &&
            (identical(other.isMoreProductsLoading, isMoreProductsLoading) ||
                other.isMoreProductsLoading == isMoreProductsLoading) &&
            (identical(other.isBrandsLoading, isBrandsLoading) ||
                other.isBrandsLoading == isBrandsLoading) &&
            (identical(other.isCategoriesLoading, isCategoriesLoading) ||
                other.isCategoriesLoading == isCategoriesLoading) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._allProducts, _allProducts) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._dropDownCategories, _dropDownCategories) &&
            const DeepCollectionEquality()
                .equals(other._dropDownBrands, _dropDownBrands) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.categoryQuery, categoryQuery) ||
                other.categoryQuery == categoryQuery) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.selectedOrder, selectedOrder) ||
                other.selectedOrder == selectedOrder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isProductsLoading,
      isMoreProductsLoading,
      isBrandsLoading,
      isCategoriesLoading,
      hasMore,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_allProducts),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_dropDownCategories),
      const DeepCollectionEquality().hash(_dropDownBrands),
      query,
      categoryQuery,
      selectedCategory,
      selectedOrder);

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopStateImplCopyWith<_$ShopStateImpl> get copyWith =>
      __$$ShopStateImplCopyWithImpl<_$ShopStateImpl>(this, _$identity);
}

abstract class _ShopState extends ShopState {
  const factory _ShopState(
      {final bool isProductsLoading,
      final bool isMoreProductsLoading,
      final bool isBrandsLoading,
      final bool isCategoriesLoading,
      final bool hasMore,
      final List<ProductData> products,
      final List<ProductData> allProducts,
      final List<CategoryData> categories,
      final List<DropDownItemData> dropDownCategories,
      final List<DropDownItemData> dropDownBrands,
      final String query,
      final String categoryQuery,
      final CategoryData? selectedCategory,
      final OrderData? selectedOrder}) = _$ShopStateImpl;
  const _ShopState._() : super._();

  @override
  bool get isProductsLoading;
  @override
  bool get isMoreProductsLoading;
  @override
  bool get isBrandsLoading;
  @override
  bool get isCategoriesLoading;
  @override
  bool get hasMore;
  @override
  List<ProductData> get products;
  @override
  List<ProductData> get allProducts; // Todos los productos cargados
  @override
  List<CategoryData> get categories;
  @override
  List<DropDownItemData> get dropDownCategories;
  @override
  List<DropDownItemData> get dropDownBrands;
  @override
  String get query;
  @override
  String get categoryQuery;
  @override
  CategoryData? get selectedCategory;
  @override
  OrderData? get selectedOrder;

  /// Create a copy of ShopState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopStateImplCopyWith<_$ShopStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
