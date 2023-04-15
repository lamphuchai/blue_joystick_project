import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 100;
    // Tính toán bán kính thực sự dựa trên giá trị bán kính và chiều dài
    double actualRadius = radius;
    double actualLength = radius / 4;

    double startAngle1 = -135 * math.pi / 180;

    // double endAngle1 = (math.pi / 2) + (1 / 3 * (math.pi / 2));
    double endAngle1 = (math.pi / 2);

    // Vẽ đoạn đường tròn thứ nhất
    Paint circlePaint1 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 4, size.height / 2),
            radius: actualRadius),
        startAngle1,
        endAngle1,
        false,
        circlePaint1);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 4, size.height / 2),
            radius: actualRadius - 30),
        startAngle1,
        endAngle1,
        false,
        circlePaint1);

    // Vẽ đoạn đường tròn thứ hai

    double startAngle2 = -315 * math.pi / 180;
    double endAngle2 = (math.pi / 2);

    Paint circlePaint2 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width * 3 / 4, size.height / 2),
            radius: actualRadius),
        startAngle2,
        endAngle2,
        false,
        circlePaint2);
    // final double radius1 = 100; // Bán kính của đường tròn thứ nhất
    // final double radius2 = 70; // Bán kính của đường tròn thứ hai
    // final double startAngle =
    //     math.pi / 2; // Góc bắt đầu của đường tròn là 90 độ
    // final double sweepAngle =
    //     math.pi / 4; // Góc duy chuyển của đường tròn là 45 độ

    // final Rect rect1 = Rect.fromCircle(
    //   center: Offset(size.width / 2, size.height / 2),
    //   radius: radius1,
    // );

    // final Rect rect2 = Rect.fromCircle(
    //   center: Offset(size.width / 2, size.height / 2),
    //   radius: radius2,
    // );

    // final Paint paint = Paint()
    //   ..color = Colors.blue // Màu sắc của đường tròn và line
    //   ..style = PaintingStyle.stroke // Kiểu vẽ
    //   ..strokeWidth = 2; // Độ rộng của đường vẽ

    // final Paint redPaint = Paint()
    //   ..color = Colors.red // Màu sắc của khoảng chung
    //   ..style = PaintingStyle.fill; // Kiểu vẽ

    // // Vẽ đường tròn thứ nhất
    // canvas.drawArc(rect1, startAngle, sweepAngle, false, paint);

    // // Vẽ đường tròn thứ hai
    // canvas.drawArc(rect2, startAngle, sweepAngle, false, paint);

    // // Vẽ line đi kèm với đường tròn thứ nhất
    // canvas.drawLine(
    //     Offset(size.width / 2, size.height / 2), // Điểm bắt đầu của line
    //     Offset(size.width / 2,
    //         size.height / 2 - radius1), // Điểm kết thúc của line
    //     paint);

    // // Vẽ line đi kèm với đường tròn thứ hai
    // canvas.drawLine(
    //     Offset(size.width / 2, size.height / 2), // Điểm bắt đầu của line
    //     Offset(size.width / 2,
    //         size.height / 2 - radius2), // Điểm kết thúc của line
    //     paint);

    // // Tô màu đỏ cho khoảng chung của hai line
    // final Rect redRect = Rect.fromCircle(
    //   center: Offset(size.width / 2, size.height / 2),
    //   radius: radius1 - 0.5,
    // );
    // final Paint redPaint2 = Paint()
    //   ..color = Colors.black // Màu sắc của khoảng chung
    //   ..style = PaintingStyle.fill; //
    // canvas.drawArc(redRect, startAngle, sweepAngle, true, redPaint);

    // final Rect redRect1 = Rect.fromCircle(
    //   center: Offset(size.width / 2, size.height / 2),
    //   radius: radius1 - 30 - 1,
    // );
    // canvas.drawArc(redRect1, startAngle, sweepAngle, true, redPaint2);
    // canvas.drawArc(rect2, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


    // final paint = Paint()
    //   ..color = Colors.red
    //   ..strokeWidth = 2.0
    //   ..style = PaintingStyle.stroke;

    // final center = Offset(size.width / 2, size.height / 2);
    // final radius = size.width / 2 - paint.strokeWidth / 2;

    // canvas.drawCircle(center, 20, paint);