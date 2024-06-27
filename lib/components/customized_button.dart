import 'package:flutter/material.dart';

class CustomizedButton extends StatefulWidget {
  final String text;
  final Function onTap;
  final double height;
  final double width;
  final IconData icon;
  Color? backgroundColor;
  final bool changeState;

  CustomizedButton(
      {required this.text,
      required this.height,
      required this.width,
      required this.icon,
      required this.onTap,
      this.backgroundColor,
      this.changeState = true});

  @override
  State<CustomizedButton> createState() => _CustomizedButtonState();
}

class _CustomizedButtonState extends State<CustomizedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.changeState) {
          setState(() {
            if (widget.backgroundColor != null) {
              widget.backgroundColor = null;
            } else {
              widget.backgroundColor = Colors.blue;
            }
          });
        }
        widget.onTap();
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
            border: widget.backgroundColor != null
                ? null
                : Border.all(width: 1.5, color: Colors.grey)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon,
                  color: widget.backgroundColor != null
                      ? Colors.white
                      : Colors.grey),
              SizedBox(width: 5.0),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: widget.backgroundColor != null
                        ? Colors.white
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
