

import 'package:json_annotation/json_annotation.dart';

part 'send_wave_model.g.dart';

@JsonSerializable()
class SendWaveModel{
  final int id;
  final int money;

  SendWaveModel({
    required this.id,
    required this.money,
  });

  factory SendWaveModel.fromJson(Map<String, dynamic> json) => _$SendWaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendWaveModelToJson(this);

}