import 'package:angular/angular.dart';
import 'package:image/image.dart';

@Injectable()
class ImageService {
  static Image _image;
  void setImage(imageBytes) {
    _image = decodeImage(imageBytes);
  }

  Image getImage() {
    return _image;
  }
}
