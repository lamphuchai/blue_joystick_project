import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const borderRadius = 8.0;
    const radius = 20.0;
    return Dialog(
        insetPadding: const EdgeInsets.only(left: 40, right: 20),
        backgroundColor: Colors.transparent,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned.fill(
                top: 20,
                right: 20,
                child: ClipPath(
                  clipper: const _InvertedRoundedCornersClipper(
                      clockwise: true,
                      topLeft: true,
                      bottomLeft: true,
                      bottomRight: true,
                      borderRadius: borderRadius,
                      radius: radius),
                  child: ColoredBox(
                    color: theme.colorScheme.background,
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  constraints: const BoxConstraints(
                      maxHeight: radius * 2, maxWidth: radius * 2),
                  height: radius * 2,
                  width: radius * 2,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(top: radius * 2, right: radius),
                child: child),
          ],
        ));
  }
}

class _InvertedRoundedCornersClipper extends CustomClipper<Path> {
  const _InvertedRoundedCornersClipper(
      {required this.topLeft,
      required this.bottomLeft,
      required this.bottomRight,
      required this.clockwise,
      required this.radius,
      required this.borderRadius});
  final double radius;
  final double borderRadius;
  final bool topLeft;
  final bool bottomLeft;
  final bool bottomRight;

  final bool clockwise;
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(borderRadius, 0);

    path.lineTo(size.width - radius, 0);
    path.arcToPoint(Offset(size.width, radius),
        radius: Radius.circular(radius), clockwise: false);

    if (bottomRight) {
      path.lineTo(size.width, size.height - borderRadius);
      path.arcToPoint(Offset(size.width - borderRadius, size.height),
          radius: Radius.circular(borderRadius), clockwise: clockwise);
    } else {
      path.lineTo(size.width, size.height);
    }
    if (bottomLeft) {
      path.lineTo(borderRadius, size.height);
      path.arcToPoint(Offset(0, size.height - borderRadius),
          radius: Radius.circular(borderRadius), clockwise: clockwise);
    } else {
      path.lineTo(0, size.height);
    }
    if (topLeft) {
      path.lineTo(0, borderRadius);
      path.arcToPoint(Offset(borderRadius, 0),
          radius: Radius.circular(borderRadius), clockwise: clockwise);
      path.close();
    } else {
      path.lineTo(0, 0);
    }

    return path;
  }

  // @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
