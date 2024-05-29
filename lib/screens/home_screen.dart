import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/constant/app_color.dart';
import 'package:painter/widgets/my_home_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Offset?> points = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: AppColor.backgroundLinearGradient,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onPanDown: (DragDownDetails details) {
                      setState(() {
                        points.add(details.localPosition);
                      });
                    },
                    onPanUpdate: (DragUpdateDetails details) {
                      setState(() {
                        points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (DragEndDetails details) {
                      setState(() {
                        points.add(null);
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomPaint(
                        painter: MyHomePainter(
                          points: points,
                          selectedColor: selectedColor,
                          strokeWidth: strokeWidth,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            selectColor();
                          },
                          icon: Icon(
                            Icons.color_lens,
                            color: selectedColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.layers_clear,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void selectColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Color Picker'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
