//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/grupo_beneficiario.dart';

abstract class GrupoRepository {
  Future<List<Grupo>> getAllGrupos(String codaleaOrg);
  Future<Grupo> getSpecificGrupo(int id);
  Future<void> addGrupo(Grupo grupo);
  Future<void> updateGrupo(Grupo grupo);
  Future<void> deleteGrupo(int id);
}
