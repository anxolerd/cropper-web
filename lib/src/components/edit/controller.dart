import 'dart:html';
import 'dart:async';
import 'package:image/image.dart';

class Point {
  int x, y;
  Point(this.x, this.y);
}

class Shape {
  int x, y, w, h;
  String fill = 'rgba(127, 255, 212, .5)';

  Shape(this.x, this.y, this.w, this.h);

  void draw(CanvasRenderingContext2D ctx) {
    ctx.fillStyle = this.fill;
    ctx.fillRect(this.x, this.y, this.w, this.h);
  }

  bool contains(int mx, int my) {
    return (this.x <= mx) &&
        (this.x + this.w >= mx) &&
        (this.y <= my) &&
        (this.y + this.h >= my);
  }
}

class CanvasState {
  CanvasElement canvas;
  int width;
  int height;
  Image image;
  CanvasRenderingContext2D ctx;

  Shape shape;
  bool valid = false;
  bool dragging = false;

  var selection = null;
  int dragoffx = 0;
  int dragoffy = 0;

  final String selectionColor = '#CC0000';
  final int selectionWidth = 2;
  Timer updater;

  CanvasState(CanvasElement canvas, Image image) {
    this.canvas = canvas;
    this.width = canvas.width;
    this.height = canvas.height;
    this.ctx = canvas.context2D;

    this.image = image;

    this.updater =
        new Timer.periodic(const Duration(milliseconds: 30), (Timer timer) {
      this.draw();
    });

    canvas.addEventListener('selectstart', (event) {
      event.preventDefault();
      return false;
    }, false);

    canvas.addEventListener('mousedown', (event) {
      Point mouse = this.getMouse(event);
      if (this.shape?.contains(mouse.x, mouse.y)) {
        this.dragoffx = mouse.x - this.shape?.x;
        this.dragoffy = mouse.y - this.shape?.y;
        this.dragging = true;
        this.selection = this.shape;
        this.valid = false;
      } else if (this.selection != null) {
        // failed to select anything;
        // deseect anything selected;
        this.selection = null;
        this.valid = false;
      }
    }, true);

    canvas.addEventListener('mousemove', (event) {
      if (!this.dragging) return;
      Point mouse = this.getMouse(event);
      this.selection.x = mouse.x - this.dragoffx;
      this.selection.y = mouse.y - this.dragoffy;
      this.valid = false;
    }, true);

    canvas.addEventListener('mouseup', (event) {
      this.dragging = false;
    }, true);
  }

  void setShape(Shape shape) {
    this.shape = shape;
    this.valid = false;
  }

  void clear() {
    this.ctx.clearRect(0, 0, this.width, this.height);
  }

  void draw() {
    if (this.valid) {
      return;
    }

    this.clear();

    var imageData = canvas.context2D.createImageData(image.width, image.height);
    imageData.data.setRange(0, imageData.data.length, image.getBytes());
    canvas.context2D.putImageData(imageData, 0, 0);

    this.shape?.draw(this.ctx);

    if (this.selection != null) {
      this.ctx.strokeStyle = this.selectionColor;
      this.ctx.lineWidth = this.selectionWidth;
      ctx.strokeRect(
        this.selection.x,
        this.selection.y,
        this.selection.w,
        this.selection.h,
      );
    }

    this.valid = true;
  }

  Point getMouse(event) {
    return Point(event.client.x, event.client.y);
  }
}
