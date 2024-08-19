import 'package:adasba_2024/data/datasources/indicador_datasource.dart';
import 'package:adasba_2024/domain/entities/indicador.dart';
import 'package:adasba_2024/domain/repositories/indicador_repository.dart';

class IndicadorRepositoryImpl implements IndicadorRepository {
  final IndicadorDataSource dataSource;
  IndicadorRepositoryImpl({required this.dataSource});

  @override
  Future<void> addIndicador(Indicador indicador) {
    return dataSource.addIndicador(indicador);
  }

  @override
  Future<void> deleteIndicador(int id) {
    return dataSource.deleteIndicador(id);
  }

  @override
  Future<List<Indicador>> getAllIndicadores(String codaleaOrg) {
    return dataSource.getAllIndicadores(codaleaOrg);
  }

  @override
  Future<Indicador> getSpecificIndicador(int id) {
    return dataSource.getSpecificIndicador(id);
  }

  @override
  Future<void> updateIndicador(Indicador indicador) {
    return dataSource.updateIndicador(indicador);
  }
}
