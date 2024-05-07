import 'package:flutter/material.dart';
import 'package:sakny/componantes/componantes.dart';

class QuarterButton extends StatelessWidget {
  const QuarterButton(
      {super.key, required this.buttonText, required this.onTap});

  final String buttonText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8, top: 6),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              20,
            ),
            onTap: onTap,
            child: Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: defaultColor, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                buttonText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
