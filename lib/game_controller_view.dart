import 'package:flutter/material.dart';

class GameControllerWidget extends StatelessWidget {
  final VoidCallback? onPressedLeft;
  final VoidCallback? onPressedRight;
  final VoidCallback? onPressedTop;
  final VoidCallback? onPressedBottom;

  final VoidCallback? onPressedA;
  final VoidCallback? onPressedB;

  const GameControllerWidget(
      {super.key,
      required this.onPressedLeft,
      required this.onPressedRight,
      required this.onPressedTop,
      required this.onPressedBottom,
      required this.onPressedA,
      required this.onPressedB});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50, child: getCrossController());
  }

  Widget getNintendoController() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder()),
                  icon: const Icon(Icons.north),
                  onPressed: onPressedTop),
              const Spacer(),
              const SizedBox(width: 20),
              const Spacer(),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder()),
                  onPressed: onPressedA,
                  child: const Text("A")),
            ],
          ),
          const SizedBox(width: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder()),
                  icon: const Icon(Icons.west),
                  onPressed: onPressedLeft),
              const Spacer(),
              IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder()),
                  icon: const Icon(Icons.east),
                  onPressed: onPressedRight),
              const SizedBox(width: 20),
              const Spacer(),
              const Spacer()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder()),
                  icon: const Icon(Icons.south),
                  onPressed: onPressedBottom),
              const Spacer(),
              const SizedBox(width: 20),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder()),
                  onPressed: onPressedB,
                  child: const Text("B")),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }

  Widget getCrossController() {
    return GridView.count(childAspectRatio: 1, crossAxisCount: 3, children: [
      const Spacer(),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Colors.white, shape: const CircleBorder()),
          icon: const Icon(Icons.north),
          onPressed: onPressedTop),
      const Spacer(),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Colors.white, shape: const CircleBorder()),
          icon: const Icon(Icons.west),
          onPressed: onPressedLeft),
      const Spacer(),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Colors.white, shape: const CircleBorder()),
          icon: const Icon(Icons.east),
          onPressed: onPressedRight),
      const Spacer(),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Colors.white, shape: const CircleBorder()),
          icon: const Icon(Icons.south),
          onPressed: onPressedBottom),
      const Spacer()
    ]);
  }
}
