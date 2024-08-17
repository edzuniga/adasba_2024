import 'package:adasba_2024/domain/entities/fuente.dart';

abstract class FuenteRepository {
  Future<List<Fuente>> getAllFuentes(String codaleaOrg);
  Future<Fuente> getSpecificFuente(int id);
  Future<void> addFuente(Fuente fuente);
  Future<void> updateFuente(Fuente fuente);
  Future<void> deleteFuente(int id);
}
