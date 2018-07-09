import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:cropper_web/app_component.template.dart' as ng;

import 'package:cropper_web/src/image_service.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  routerProvidersHash,
  ClassProvider(ImageService),
])
final InjectorFactory injector = self.injector$Injector;
void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
