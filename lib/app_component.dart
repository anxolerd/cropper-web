import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'src/routes.dart';
import 'src/image_service.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: const [
    'app_component.css',
  ],
  directives: [routerDirectives],
  providers: [ClassProvider(Routes)],
)
class AppComponent {
  final title = 'Cropper';
  final Routes routes;

  AppComponent(this.routes);
}
