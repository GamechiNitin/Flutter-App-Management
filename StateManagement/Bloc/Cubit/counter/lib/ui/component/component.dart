import 'package:flutter/material.dart';

class SliderComponent extends StatelessWidget {
  const SliderComponent({super.key, required this.seed, this.onChanged});
  final double seed;
 final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: seed.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: " / Seed",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  // color: Colors.black,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalDivider(
                width: 12,
                thickness: 2,
                color: Colors.lightBlue,
              ),
              ...List.generate(
                5,
                (index) => SizedBox(
                  child: VerticalDivider(
                    indent: 6,
                    width: 12,
                  ),
                ),
              ),
              VerticalDivider(
                width: 12,
                thickness: 2,
                color: Colors.redAccent,
              ),
              ...List.generate(
                5,
                (index) => SizedBox(
                  child: VerticalDivider(
                    indent: 6,
                    width: 12,
                  ),
                ),
              ),
              VerticalDivider(
                width: 12,
                thickness: 2,
                color: Colors.redAccent,
              ),
              ...List.generate(
                5,
                (index) => SizedBox(
                  child: VerticalDivider(
                    indent: 6,
                    width: 12,
                  ),
                ),
              ),
              VerticalDivider(
                width: 12,
                thickness: 2,
                color: Colors.redAccent,
              ),
              ...List.generate(
                5,
                (index) => SizedBox(
                  child: VerticalDivider(
                    indent: 6,
                    width: 14,
                  ),
                ),
              ),
              VerticalDivider(
                width: 14,
                thickness: 2,
                color: Colors.lightBlue,
              ),
            ],
          ),
        ),
        Slider(
          min: 0,
          max: 100,
          value: seed,
          divisions: 200,
          label: seed.toString(),
          activeColor: Colors.blue,
          mouseCursor: MaterialStateMouseCursor.clickable,
          thumbColor: Colors.lightGreen,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
