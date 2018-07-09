import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:cropper_web/src/image_service.dart';
import 'package:cropper_web/src/route_paths.dart' as paths;

@Component(
  selector: 'cr-upload',
  templateUrl: 'upload_component.html',
  directives: [coreDirectives],
)
class UploadComponent {
  final ImageService _imageService;
  final Router _router;
  bool loading;

  UploadComponent(this._imageService, this._router);

  void onUploadButtonClicked(event) async {
    final files = event.target.files;
    if (files.length == 0) return;
    loading = true;
    final bytes = await this._readFile(files[0]);
    this._imageService.setImage(bytes);
    loading = false;
    _router.navigate(paths.edit.toUrl());
  }

  Future<List<int>> _readFile(file) async {
    final FileReader reader = new FileReader();
    reader.readAsArrayBuffer(file);
    final event = await reader.onLoadEnd.first;
    return reader.result;
  }
}
