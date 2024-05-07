// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:particles_flutter/particles_flutter.dart';
//
// class AnimatingBg1 extends StatefulWidget {
//   const AnimatingBg1({super.key});
//
//   @override
//   _AnimatingBg1State createState() => _AnimatingBg1State();
// }
//
// class _AnimatingBg1State extends State<AnimatingBg1>
//     with TickerProviderStateMixin {
//   List<Color> colorList = [
//     const Color(0xff000000),
//     const Color(0xffcbbf25),
//     const Color(0xffb9b053),
//     const Color(0xffdcd9b4),
//     const Color(0xffffffff),
//   ];
//   List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
//   int index = 0;
//   Color bottomColor = const Color(0xffffffff);
//   Color topColor = const Color(0xff000000);
//   Alignment begin = Alignment.bottomCenter;
//   Alignment end = Alignment.topCenter;
//
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       const Duration(microseconds: 0),
//       () {
//         setState(
//           () {
//             bottomColor = const Color(0xffcbbf25);
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(seconds: 2),
//       onEnd: () {
//         setState(
//           () {
//             index = index + 1;
//             bottomColor = colorList[index % colorList.length];
//             topColor = colorList[(index + 1) % colorList.length];
//           },
//         );
//       },
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: begin,
//           end: end,
//           colors: [bottomColor, topColor],
//         ),
//       ),
//     );
//   }
// }
//
// class MyCustomWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: CircularParticle(
//         width: w,
//         height: h,
//         awayRadius: w / 5,
//         numberOfParticles: 150,
//         speedOfParticles: 1.5,
//         maxParticleSize: 7,
//         particleColor: Colors.white.withOpacity(.7),
//         awayAnimationDuration: const Duration(milliseconds: 600),
//         awayAnimationCurve: Curves.easeInOutBack,
//         onTapAnimation: true,
//         isRandSize: true,
//         isRandomColor: false,
//         connectDots: true,
// // randColorList: [
// // Colors.red.withAlpha(210),
// // Colors.white.withAlpha(210),
// // Colors.yellow.withAlpha(210),
// // Colors.green.withAlpha(210),
// // ],
//         enableHover: true,
//         hoverColor: Colors.black,
//         hoverRadius: 90,
//       ),
//     );
//   }
// }
