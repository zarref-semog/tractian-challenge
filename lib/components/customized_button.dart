import 'package:flutter/material.dart';

class CustomizedButton extends StatefulWidget {
  final String text;
  final Function onTap;
  final double height;
  final double width;
  final IconData icon;
  final Color? backgroundColor;
  final bool changeState;

  CustomizedButton({
    required this.text,
    required this.height,
    required this.width,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.changeState = true,
  });

  @override
  State<CustomizedButton> createState() => _CustomizedButtonState();
}

class _CustomizedButtonState extends State<CustomizedButton> {
  Color? _backgroundColor;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _backgroundColor = widget.backgroundColor;
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      _backgroundColor = _isFocused ? Colors.blue : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_isFocused) {
              _focusNode.unfocus();
            } else {
              FocusScope.of(context).requestFocus(_focusNode);
            }
          });
          widget.onTap();
        },
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: _backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
            border: _backgroundColor != null
                ? null
                : Border.all(width: 1.5, color: Colors.grey),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: _backgroundColor != null ? Colors.white : Colors.grey,
                ),
                SizedBox(width: 5.0),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _backgroundColor != null
                        ? Colors.white
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
