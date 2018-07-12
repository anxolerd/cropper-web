import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:image/image.dart';
import 'package:cropper_web/src/image_service.dart';
import 'package:cropper_web/src/route_paths.dart' as paths;

import 'controller.dart';

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
  CanvasState canvasController;
  Shape cropSelection;

  int _ratio;
  @Input()
  void set ratio(int newRatio) {
    _ratio = newRatio;
    this.cropSelection?.w = this.cropSelection?.h * newRatio;
    this.canvasController?.setShape(this.cropSelection);
  }

  int get ratio => _ratio;

  int _size;
  @Input()
  void set size(String newSize) {
    _size = int.parse(newSize);
    this.cropSelection?.h = _size;
    this.cropSelection?.w = this.cropSelection?.h * ratio;
    this.canvasController?.setShape(this.cropSelection);
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

    ratio = 1;
    size = (image.height ~/ 2).toString();
    canvasController = new CanvasState(canvas, image);
    cropSelection = new Shape(0, 0, _size, _size * ratio);
    canvasController.setShape(cropSelection);
  }

  Future<void> doCrop() async {
    await _imageService.slice(
      this.cropSelection.x,
      this.cropSelection.y,
      this._size,
      this.ratio,
    );
    _router.navigate(paths.export.toUrl());
  }
}
