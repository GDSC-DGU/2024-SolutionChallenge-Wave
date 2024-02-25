import 'package:json_annotation/json_annotation.dart';
import '../../common/model/common_response.dart';
import 'donation_model.dart';

part 'donation_response_model.g.dart';

@JsonSerializable()
class DonationResponseModel extends CommonResponse{
  final DonationResponseData? data;

  DonationResponseModel({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DonationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DonationResponseModelToJson(this);
}

@JsonSerializable()
class DonationResponseData {
  final int totalWave;
  final List<DonationModel> donateList;

  DonationResponseData({
    required this.totalWave,
    required this.donateList,
  });

  factory DonationResponseData.fromJson(Map<String, dynamic> json) =>
      _$DonationResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DonationResponseDataToJson(this);
}