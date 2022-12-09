import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/svg_icon_model.dart';
import 'package:shoplistapp/data/remote_data_sources/svg_icon_remote_data_source.dart';

@injectable
class SvgIconRepository {
  SvgIconRepository(this._svgIconRemoteDataSource);
  final SvgIconRemoteDataSource _svgIconRemoteDataSource;

  Stream<List<SvgIconModel>> getSvgIconStream(String productGroup) {
    return _svgIconRemoteDataSource.getSvgIconStream().map((querySnapshots) =>
        querySnapshots.docs
            .map((svgIcons) => SvgIconModel.fromJson(svgIcons))
            .where((element) => element.productGroup == productGroup)
            .toList());
  }
}
