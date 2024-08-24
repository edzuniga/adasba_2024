//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/indicadores_por_set.dart';

abstract class IndicadoresPorSetRepository {
  Future<List<IndicadoresPorSet>> getAllIndicadoresPorIdSet(int idSet);
  Future<void> addIndicadoresPorSet(IndicadoresPorSet indicadoresPorSet);
  Future<void> deleteIndicadoresPorSet(int id);
}
