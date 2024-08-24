import 'package:adasba_2024/data/datasources/indicadores_por_set_datasource.dart';
import 'package:adasba_2024/domain/entities/indicadores_por_set.dart';
import 'package:adasba_2024/domain/repositories/indicadores_por_set_repository.dart';

class IndicadoresPorSetRepositoryImpl implements IndicadoresPorSetRepository {
  final IndicadoresPorSetDataSource dataSource;
  IndicadoresPorSetRepositoryImpl(this.dataSource);

  @override
  Future<void> addIndicadoresPorSet(IndicadoresPorSet indicadoresPorSet) {
    return dataSource.addIndicadoresPorSet(indicadoresPorSet);
  }

  @override
  Future<void> deleteIndicadoresPorSet(int id) {
    return dataSource.deleteIndicadoresPorSet(id);
  }

  @override
  Future<List<IndicadoresPorSet>> getAllIndicadoresPorIdSet(int idSet) {
    return dataSource.getAllIndicadoresPorIdSet(idSet);
  }
}
