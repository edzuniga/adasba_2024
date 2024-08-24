import 'package:adasba_2024/domain/entities/indicadores_por_set.dart';

class IndicadoresPorSetModel extends IndicadoresPorSet {
  IndicadoresPorSetModel({
    super.id,
    required super.idSet,
    required super.idIndicador,
  });

  factory IndicadoresPorSetModel.fromJson(Map<String, dynamic> json) =>
      IndicadoresPorSetModel(
        id: json['id'] is int ? json['id'] : int.parse(json['id']),
        idSet: json['id_set'],
        idIndicador: json['id_indicador'],
      );

  Map<String, dynamic> toJson() => {
        'id_set': idSet,
        'id_indicador': idIndicador,
      };

  IndicadoresPorSetModel copyWith({
    int? id,
    int? idSet,
    int? idIndicador,
  }) =>
      IndicadoresPorSetModel(
        id: id ?? this.id,
        idSet: idSet ?? this.idSet,
        idIndicador: idIndicador ?? this.idIndicador,
      );

  factory IndicadoresPorSetModel.fromIndicadoresPorSet(
          IndicadoresPorSet indicadoresPorSet) =>
      IndicadoresPorSetModel(
        id: indicadoresPorSet.id,
        idSet: indicadoresPorSet.idSet,
        idIndicador: indicadoresPorSet.idIndicador,
      );
}
