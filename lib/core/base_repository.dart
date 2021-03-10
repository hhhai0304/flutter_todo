import 'base_model.dart';

abstract class BaseRepository<T extends BaseModel> {
  Future<List<T>> selectAll();

  Future insertAll(List<T> data);
}
