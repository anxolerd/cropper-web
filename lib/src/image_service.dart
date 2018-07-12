import 'dart:async';
import 'package:angular/angular.dart';
import 'package:image/image.dart';

@Injectable()
class ImageService {
  static Image _image;
  static List<Image> slices = new List<Image>();
  void setImage(imageBytes) {
    _image = decodeImage(imageBytes);
  }

  Image getImage() => _image;
  List<Image> getSlices() => slices;

  Future<void> slice(int x, int y, int height, int n) {
    int sliceWidth = height;

    slices.clear();
    for (int cut = x; cut < x + sliceWidth * n; cut += sliceWidth) {
      slices.add(copyCrop(_image, cut, y, sliceWidth, sliceWidth));
    }
  }
}
