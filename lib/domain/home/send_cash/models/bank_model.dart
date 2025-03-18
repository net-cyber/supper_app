import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_model.freezed.dart';
part 'bank_model.g.dart';

@freezed
class BankModel with _$BankModel {
  const factory BankModel({
    required String id,
    required String name,
    required String logoPath,
    required double exchangeRate,
    @Default(0.0) double giftPercentage,
  }) = _BankModel;

  factory BankModel.fromJson(Map<String, dynamic> json) => _$BankModelFromJson(json);
} 