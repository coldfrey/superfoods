import 'package:superfoods/app/data/models/model.dart';

abstract class IdentifierModel<T> extends Model {
  final String id;

  IdentifierModel(this.id)
      : assert(id.isNotEmpty, 'IdentifierModel: id must not be empty');
}
