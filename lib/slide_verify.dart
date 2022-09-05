import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_verify/paths/triangle_path.dart';

import 'enums.dart';

class SlideVerify extends StatefulWidget {
  const SlideVerify(
      {Key? key,
      this.imageFrom = ImageFrom.asset,
      this.imageUrl,
      this.widgetHeight = 300,
      this.widgetWidth = 400,
      this.slideVerifyShape = SlideVerifyShape.circle,
      this.ifMatches})
      : super(key: key);
  final double widgetWidth;
  final double widgetHeight;
  final String? imageUrl;
  final ImageFrom imageFrom;
  final SlideVerifyShape slideVerifyShape;
  final VoidCallback? ifMatches;

  @override
  State<SlideVerify> createState() => _SlideVerifyState();
}

class _SlideVerifyState extends State<SlideVerify> {
  double _left = 0;
  late double defaultTop = 0;
  late double defaultLeft = 0;

  @override
  void initState() {
    super.initState();
    defaultLeft = Random().nextInt(widget.widgetWidth.floor()) * 1.0;
    defaultTop = Random().nextInt(widget.widgetHeight.floor()) * 1.0;
  }

  Widget buildDraggableWidget() {
    return ClipPath(
      clipper:
          TriangleImagePath(top: defaultTop, left: defaultLeft, widgetSize: 40),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if ((_left - defaultLeft).abs() < 0.05 * defaultLeft) {
            if (widget.ifMatches != null) {
              widget.ifMatches!.call();
            } else {
              debugPrint(_left.toString());
            }
          }
        },
        onHorizontalDragUpdate: (details) {
          _left += details.delta.dx;
          if (_left < 0) {
            _left = 0;
          }
          if (_left > widget.widgetWidth - 40) {
            _left = widget.widgetWidth - 40;
          }
          setState(() {});
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.grab,
          child: SizedBox(
            width: widget.widgetWidth,
            height: widget.widgetHeight,
            child: Image(
              image: AssetImage(widget.imageUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widgetWidth,
      child: Column(
        children: [
          Container(
            width: widget.widgetWidth,
            height: widget.widgetHeight,
            color: Colors.orangeAccent,
            child: Stack(clipBehavior: Clip.none, children: [
              if (widget.imageUrl != null &&
                  widget.imageFrom == ImageFrom.asset)
                Positioned.fill(
                    child: Image(
                  image: AssetImage(widget.imageUrl!),
                  fit: BoxFit.cover,
                )),
              Positioned(
                  left: defaultLeft,
                  top: defaultTop,
                  child: ClipPath(
                    clipper: TrianglePath(),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.red,
                    ),
                  )),
              Positioned(
                  left: -defaultLeft + _left,
                  top: 0,
                  child: buildDraggableWidget()),
              Positioned(
                  left: -defaultLeft + _left,
                  top: 0,
                  child: CustomPaint(
                    painter: TriangleBorderPainter(
                        top: defaultTop, left: defaultLeft, widgetSize: 40),
                  )),
            ]),
          ),
          Stack(
            children: [
              Container(
                width: widget.widgetWidth,
                height: 20,
                color: Colors.grey,
              ),
              Positioned(
                left: _left,
                child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if ((_left - defaultLeft).abs() < 0.05 * defaultLeft) {
                        if (widget.ifMatches != null) {
                          widget.ifMatches!.call();
                        } else {
                          debugPrint(_left.toString());
                        }
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      _left += details.delta.dx;
                      if (_left < 0) {
                        _left = 0;
                      }
                      if (_left > widget.widgetWidth - 40) {
                        _left = widget.widgetWidth - 40;
                      }
                      setState(() {});
                    },
                    // onPanUpdate: (details) {
                    //   _left += details.delta.dx;
                    //   setState(() {});
                    // },
                    child: Container(
                      width: 40,
                      height: 30,
                      color: Colors.blue,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
