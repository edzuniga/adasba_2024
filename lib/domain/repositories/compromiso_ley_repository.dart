//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/compromiso_ley.dart';

abstract class CompromisoLeyRepository {
  Future<List<CompromisoLey>> getAllCompromisosLey(String codaleaOrg);
  Future<CompromisoLey> getSpecificCompromisoLey(int id);
  Future<void> addCompromisoLey(CompromisoLey compromiso);
  Future<void> updateCompromisoLey(CompromisoLey compromiso);
  Future<void> deleteCompromisoLey(int id);
}
