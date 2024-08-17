import 'package:adasba_2024/data/datasources/grupo_datasource.dart';
import 'package:adasba_2024/domain/entities/grupo_beneficiario.dart';
import 'package:adasba_2024/domain/repositories/grupo_repository.dart';

class GrupoRepositoryImpl implements GrupoRepository {
  final GrupoDataSource gruposDataSource;

  GrupoRepositoryImpl({required this.gruposDataSource});

  @override
  Future<void> addGrupo(Grupo grupo) {
    return gruposDataSource.addGrupo(grupo);
  }

  @override
  Future<void> deleteGrupo(int id) {
    return gruposDataSource.deleteGrupo(id);
  }

  @override
  Future<List<Grupo>> getAllGrupos(String codaleaOrg) {
    return gruposDataSource.getAllGrupos(codaleaOrg);
  }

  @override
  Future<Grupo> getSpecificGrupo(int id) {
    return gruposDataSource.getSpecificGrupo(id);
  }

  @override
  Future<void> updateGrupo(Grupo grupo) {
    return gruposDataSource.updateGrupo(grupo);
  }
}
