import 'package:adasba_2024/data/datasources/fuente_datasource.dart';
import 'package:adasba_2024/domain/entities/fuente.dart';
import 'package:adasba_2024/domain/repositories/fuente_repository.dart';

class FuenteRepositoryImpl implements FuenteRepository {
  final FuenteDatasource dataSource;
  FuenteRepositoryImpl({required this.dataSource});

  @override
  Future<void> addFuente(Fuente fuente) {
    return dataSource.addFuente(fuente);
  }

  @override
  Future<void> deleteFuente(int id) {
    return dataSource.deleteFuente(id);
  }

  @override
  Future<List<Fuente>> getAllFuentes(String codaleaOrg) {
    return dataSource.getAllFuentes(codaleaOrg);
  }

  @override
  Future<Fuente> getSpecificFuente(int id) {
    return dataSource.getSpecificFuente(id);
  }

  @override
  Future<void> updateFuente(Fuente fuente) {
    return dataSource.updateFuente(fuente);
  }
}
