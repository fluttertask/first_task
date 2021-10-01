import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  const CustomAppBar({this.color, Key? key, this.actions, this.leading, this.title, this.bottom, this.bottomHeight }) : super(key: key);

  final Color? color;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? title;
  final Widget? bottom;
  final double? bottomHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color?? Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 24,
              ),
              child: SafeArea(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: leading
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Align(child: title)
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: actions?? [],
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),
          if (bottom != null) SizedBox(
            height: bottomHeight?? 0,
            child: bottom,
          )
        ],
      ),
    );
  }
}