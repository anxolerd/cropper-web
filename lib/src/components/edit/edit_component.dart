import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:image/image.dart';
import 'package:cropper_web/src/image_service.dart';
import 'package:cropper_web/src/route_paths.dart' as paths;

@Component(
  selector: 'cr-edit',
  templateUrl: 'edit_component.html',
  directives: [coreDirectives, formDirectives],
)
class EditComponent implements OnInit {
  final ImageService _imageService;
  final Router _router;

  @ViewChild('canvas')
  CanvasElement canvas;

  Image image;

  @Input()
  int ratio;

  int _size;
  @Input()
  void set size(String newSize) {
    _size = int.parse(newSize);
  }

  String get size => _size.toString();

  EditComponent(this._imageService, this._router);

  void ngOnInit() {
    image = _imageService.getImage();
    if (image == null) {
      _router.navigate(paths.upload.toUrl());
      return;
    }
    canvas.setAttribute('width', image.width.toString());
    canvas.setAttribute('height', image.height.toString());
    var imageData = canvas.context2D.createImageData(image.width, image.height);
    imageData.data.setRange(0, imageData.data.length, image.getBytes());
    canvas.context2D.putImageData(imageData, 0, 0);

    ratio = 1;
    _size = image.height ~/ 2;
  }
}
