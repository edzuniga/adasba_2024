//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/proyecto.dart';

abstract class ProyectoRepository {
  Future<List<Proyecto>> getAllProyectos(String codaleaOrg);
  Future<Proyecto> getSpecificProyecto(int id);
  Future<void> addProyecto(Proyecto proyecto);
  Future<void> updateProyecto(Proyecto proyecto);
  Future<void> deleteProyecto(int id);
}
