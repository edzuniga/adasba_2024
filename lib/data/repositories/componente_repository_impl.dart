import 'package:adasba_2024/data/datasources/componente_datasource.dart';
import 'package:adasba_2024/domain/entities/componente.dart';
import 'package:adasba_2024/domain/repositories/componente_repository.dart';

class ComponenteRepositoryImpl implements ComponenteRepository {
  final ComponenteDataSource dataSource;
  ComponenteRepositoryImpl({required this.dataSource});

  @override
  Future<void> addComponente(Componente componente) {
    return dataSource.addComponente(componente);
  }

  @override
  Future<void> deleteComponente(int id) {
    return dataSource.deleteComponente(id);
  }

  @override
  Future<List<Componente>> getAllComponentes(String codaleaOrg) {
    return dataSource.getAllComponentes(codaleaOrg);
  }

  @override
  Future<Componente> getSpecificComponente(int id) {
    return dataSource.getSpecificComponente(id);
  }

  @override
  Future<void> updateComponente(Componente componente) {
    return dataSource.updateComponente(componente);
  }
}
