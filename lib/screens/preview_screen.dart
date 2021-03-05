import 'package:flutter/material.dart';
import 'package:test_project/screens/menu_screen.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _resizePainterAnimation;
  Animation _resizeSizedBox;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    _resizePainterAnimation = Tween<double>(begin: 600.0, end: 300.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    _resizeSizedBox = Tween<double>(begin: 500.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            AnimatedBuilder(
                animation: _resizePainterAnimation,
                builder: (BuildContext context, snapshot) {
                  return CustomPaint(
                    size: Size(size.width, _resizePainterAnimation.value),
                    painter: MyPainter(
                        size: Size(size.width, _resizePainterAnimation.value)),
                  );
                }),
            ElevatedButton(
              //color: Color(0xFFFFCCFF),
              child: Icon(
                Icons.play_arrow,
                color: Color(0xFF333399),
                size: 50,
              ),
              onPressed: () {
                if (_controller.status == AnimationStatus.dismissed)
                  _controller.forward();
                else if (_controller.status == AnimationStatus.completed)
                  _controller.reverse();
              },
            ),
            AnimatedBuilder(
                animation: _resizeSizedBox,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: _resizePainterAnimation.value,
                  );
                }),
            TextButton(
              child: Text(
                "Продолжить",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MenuScreen()));
              },
            ),
            SizedBox(
              height: 500,
            )
          ],
        ),
      ),
    ));
  }
}

class MyPainter extends CustomPainter {
  MyPainter({@required this.size});
  final Size size;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color(0xFF66CCFF)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.80,
        size.width * 0.40, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.33,
        size.width * 0.70, size.height * 0.46);
    path.quadraticBezierTo(
        size.width * 0.87, size.height * 0.63, size.width, size.height * 0.35);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
