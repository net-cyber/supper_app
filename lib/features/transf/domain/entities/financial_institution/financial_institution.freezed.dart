// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_institution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FinancialInstitution _$FinancialInstitutionFromJson(Map<String, dynamic> json) {
  return _FinancialInstitution.fromJson(json);
}

/// @nodoc
mixin _$FinancialInstitution {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this FinancialInstitution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FinancialInstitution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinancialInstitutionCopyWith<FinancialInstitution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialInstitutionCopyWith<$Res> {
  factory $FinancialInstitutionCopyWith(FinancialInstitution value,
          $Res Function(FinancialInstitution) then) =
      _$FinancialInstitutionCopyWithImpl<$Res, FinancialInstitution>;
  @useResult
  $Res call(
      {String id,
      String name,
      String code,
      String type,
      String? logoUrl,
      String? description,
      bool active});
}

/// @nodoc
class _$FinancialInstitutionCopyWithImpl<$Res,
        $Val extends FinancialInstitution>
    implements $FinancialInstitutionCopyWith<$Res> {
  _$FinancialInstitutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinancialInstitution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? type = null,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialInstitutionImplCopyWith<$Res>
    implements $FinancialInstitutionCopyWith<$Res> {
  factory _$$FinancialInstitutionImplCopyWith(_$FinancialInstitutionImpl value,
          $Res Function(_$FinancialInstitutionImpl) then) =
      __$$FinancialInstitutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String code,
      String type,
      String? logoUrl,
      String? description,
      bool active});
}

/// @nodoc
class __$$FinancialInstitutionImplCopyWithImpl<$Res>
    extends _$FinancialInstitutionCopyWithImpl<$Res, _$FinancialInstitutionImpl>
    implements _$$FinancialInstitutionImplCopyWith<$Res> {
  __$$FinancialInstitutionImplCopyWithImpl(_$FinancialInstitutionImpl _value,
      $Res Function(_$FinancialInstitutionImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialInstitution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? type = null,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? active = null,
  }) {
    return _then(_$FinancialInstitutionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialInstitutionImpl implements _FinancialInstitution {
  const _$FinancialInstitutionImpl(
      {required this.id,
      required this.name,
      required this.code,
      required this.type,
      this.logoUrl,
      this.description,
      this.active = true});

  factory _$FinancialInstitutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialInstitutionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final String type;
  @override
  final String? logoUrl;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'FinancialInstitution(id: $id, name: $name, code: $code, type: $type, logoUrl: $logoUrl, description: $description, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialInstitutionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, code, type, logoUrl, description, active);

  /// Create a copy of FinancialInstitution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialInstitutionImplCopyWith<_$FinancialInstitutionImpl>
      get copyWith =>
          __$$FinancialInstitutionImplCopyWithImpl<_$FinancialInstitutionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialInstitutionImplToJson(
      this,
    );
  }
}

abstract class _FinancialInstitution implements FinancialInstitution {
  const factory _FinancialInstitution(
      {required final String id,
      required final String name,
      required final String code,
      required final String type,
      final String? logoUrl,
      final String? description,
      final bool active}) = _$FinancialInstitutionImpl;

  factory _FinancialInstitution.fromJson(Map<String, dynamic> json) =
      _$FinancialInstitutionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;
  @override
  String get type;
  @override
  String? get logoUrl;
  @override
  String? get description;
  @override
  bool get active;

  /// Create a copy of FinancialInstitution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinancialInstitutionImplCopyWith<_$FinancialInstitutionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
