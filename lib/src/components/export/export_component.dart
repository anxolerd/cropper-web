import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:cropper_web/src/image_service.dart';
import 'package:angular_router/angular_router.dart';
import 'package:cropper_web/src/route_paths.dart' as paths;
import 'package:image/image.dart';

@Component(
  selector: 'cr-export',
  templateUrl: 'export_component.html',
  directives: [coreDirectives],
)
class ExportComponent implements OnInit {
  final ImageService _imageService;
  final Router _router;
  List<String> slices;

  ExportComponent(this._imageService, this._router);

  void ngOnInit() {
    slices = _imageService.getSlices().map(this.toBase64).toList();
    if (slices.length == 0) {
      _router.navigate(paths.edit.toUrl());
    }
  }

  String toBase64(Image image) {
    final prefix = 'data:image/png;base64';
    var data = BASE64.encode(encodePng(image));
    return '${prefix},${data}';
  }
}
