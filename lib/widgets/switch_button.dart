import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget{
  final Icon onIcon;
  final Icon offIcon;
  final double iconSize;
  final void Function(bool) onPressed;

  const SwitchButton(this.onIcon, this.offIcon, this.iconSize, this.onPressed, {super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool activated = true;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: widget.iconSize,
        onPressed: (){
          setState(() {
            activated = !activated;
          });
          widget.onPressed(activated);
        },
        icon: activated ? widget.offIcon : widget.onIcon);
  }
}