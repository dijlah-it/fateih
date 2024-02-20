import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Constants {
  static const Color themeColor = Color.fromARGB(255, 19, 158, 141);
  static const Color itemColor = Color.fromARGB(255, 53, 233, 126);
  static const Color backgroundColor = Color.fromARGB(255, 14, 51, 43);
  static const Color secondColor = Color.fromARGB(255, 206, 190, 135);
  static int activeHomePage = 0;

  static const LinearGradient appGradient = LinearGradient(
    colors: [
      Constants.themeColor,
      Constants.itemColor,
    ],
  );
}

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    super.key,
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : _painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        _child = child,
        _callback = onPressed,
        _radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: const BoxConstraints(minWidth: 88, minHeight: 48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required this.strokeWidth,
      required this.radius,
      required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class StartBG extends StatelessWidget {
  const StartBG({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          './assets/images/startBG.png',
          fit: BoxFit.fill,
          width: size.width,
          height: size.height,
        ),
        //Pattern
        Positioned(
          top: 0,
          child: Image.asset(
            './assets/images/pattern.png',
            fit: BoxFit.fill,
            width: size.width,
            height: 340,
          ),
        ),
        // LOGO
        Positioned(
          top: 150,
          child: Image.asset(
            './assets/images/logo.png',
            fit: BoxFit.fill,
            width: 150,
            height: 150,
          ),
        ),
      ],
    );
  }
}

class LoginInput extends StatelessWidget {
  final String labelText;
  final TextInputType inputType;
  const LoginInput({
    super.key,
    required this.labelText,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        keyboardType: inputType,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: labelText,
          border: const GradientOutlineInputBorder(
            gradient: Constants.appGradient,
            width: 1,
          ),
          labelStyle: const TextStyle(
            color: Constants.themeColor,
          ),
        ),
      ),
    );
  }
}
