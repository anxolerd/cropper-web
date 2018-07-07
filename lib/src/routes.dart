import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'route_paths.dart' as paths;
import 'components/upload/upload_component.template.dart' as uct;
import 'components/edit/edit_component.template.dart' as edct;
import 'components/export/export_component.template.dart' as exct;

@Injectable()
class Routes {
  RoutePath get upload => paths.upload;
  RoutePath get edit => paths.edit;
  RoutePath get export => paths.export;

  final List<RouteDefinition> all = [
    RouteDefinition(
      path: paths.upload.path,
      component: uct.UploadComponentNgFactory,
    ),
    RouteDefinition(
      path: paths.edit.path,
      component: edct.EditComponentNgFactory,
    ),
    RouteDefinition(
      path: paths.export.path,
      component: exct.ExportComponentNgFactory,
    ),
    RouteDefinition.redirect(path: '', redirectTo: paths.upload.toUrl()),
  ];
}
