import 'package:adasba_2024/data/datasources/set_indicadores_datasource.dart';
import 'package:adasba_2024/domain/entities/set_indicador.dart';
import 'package:adasba_2024/domain/repositories/set_indicador_repository.dart';

class SetIndicadoresRepositoryImpl implements SetIndicadoresRepository {
  final SetIndicadoresDataSource dataSource;
  SetIndicadoresRepositoryImpl({required this.dataSource});

  @override
  Future<void> addSetIndicador(SetIndicador setIndicador) {
    return dataSource.addSetIndicador(setIndicador);
  }

  @override
  Future<void> deleteSetIndicador(int id) {
    return dataSource.deleteSetIndicador(id);
  }

  @override
  Future<List<SetIndicador>> getAllSetIndicadores(String codaleaOrg) {
    return dataSource.getAllSetIndicadores(codaleaOrg);
  }

  @override
  Future<SetIndicador> getSpecificSetIndicador(int id) {
    return dataSource.getSpecificSetIndicador(id);
  }

  @override
  Future<void> updateSetIndicador(SetIndicador setIndicador) {
    return dataSource.updateSetIndicador(setIndicador);
  }
}
