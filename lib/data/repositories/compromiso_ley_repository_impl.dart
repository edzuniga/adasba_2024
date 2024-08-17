import 'package:adasba_2024/data/datasources/compromiso_ley_datasource.dart';
import 'package:adasba_2024/domain/entities/compromiso_ley.dart';
import 'package:adasba_2024/domain/repositories/compromiso_ley_repository.dart';

class CompromisoLeyRepositoryImpl implements CompromisoLeyRepository {
  final CompromisoLeyDataSource compromisoLeyDataSource;

  CompromisoLeyRepositoryImpl({required this.compromisoLeyDataSource});

  @override
  Future<void> addCompromisoLey(CompromisoLey compromisoLey) {
    return compromisoLeyDataSource.addCompromisoLey(compromisoLey);
  }

  @override
  Future<void> deleteCompromisoLey(int id) {
    return compromisoLeyDataSource.deleteCompromisoLey(id);
  }

  @override
  Future<List<CompromisoLey>> getAllCompromisosLey(String codaleaOrg) {
    return compromisoLeyDataSource.getAllCompromisosLey(codaleaOrg);
  }

  @override
  Future<CompromisoLey> getSpecificCompromisoLey(int id) {
    return compromisoLeyDataSource.getSpecificCompromisoLey(id);
  }

  @override
  Future<void> updateCompromisoLey(CompromisoLey compromisoLey) {
    return compromisoLeyDataSource.updateCompromisoLey(compromisoLey);
  }
}
