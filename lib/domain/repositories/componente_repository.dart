//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/componente.dart';

abstract class ComponenteRepository {
  Future<List<Componente>> getAllComponentes(String codaleaOrg);
  Future<Componente> getSpecificComponente(int id);
  Future<void> addComponente(Componente componente);
  Future<void> updateComponente(Componente componente);
  Future<void> deleteComponente(int id);
}
