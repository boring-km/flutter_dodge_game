import 'dart:ui';

class Line {

  Line(this.start, this.end, this.progress);

  Offset start;
  Offset end;
  double progress;
  bool isEnd = false;

  bool check() {
    final res = progress >= 1.0;
    if (!isEnd && res) {
      isEnd = true;
    }
    return res;
  }
}
