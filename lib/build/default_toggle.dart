import 'package:flutter/material.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DefaultToggle extends StatefulWidget {
  final Function(String) onGenderChanged;

  const DefaultToggle({super.key, required this.onGenderChanged});

  @override
  State<DefaultToggle> createState() => _DefaultToggleState();
}

class _DefaultToggleState extends State<DefaultToggle> {
  final genderItems = ['Male', 'Female'];
  int choosedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
        fontSize: 9,
        isVertical: false,
        minWidth: 50.0,
        borderWidth: 0,
        borderColor: const [defaultColor],
        initialLabelIndex: choosedIndex,
        cornerRadius: 20.0,
        activeFgColor: Colors.black,
        inactiveBgColor: Colors.grey.shade200,
        inactiveFgColor: Colors.black,
        totalSwitches: 2,
        centerText: true,
        changeOnTap: true,
        multiLineText: false,
        labels: genderItems,
        activeBgColors: [
          [defaultColor, defaultColor.withOpacity(0.2)],
          [defaultColor.withOpacity(0.2), defaultColor]
        ],
        onToggle: (index) {
          if (index != null) {
            widget.onGenderChanged(genderItems[index]);
            setState(() {
              choosedIndex = index;
            });
          }
        });
  }
}
