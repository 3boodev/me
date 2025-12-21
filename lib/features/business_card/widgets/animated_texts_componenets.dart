import 'package:flutter/material.dart';


class AnimatedImageContainer extends StatefulWidget {
  const AnimatedImageContainer({Key? key, this.height = 300, this.width = 250,required this.image})
      : super(key: key);
  final double? width;
  final double? height;
  final String? image;
  @override
  AnimatedImageContainerState createState() => AnimatedImageContainerState();
}
class AnimatedImageContainerState extends State<AnimatedImageContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true); // Repeat the animation loop
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = _controller.value;
            return Transform.translate(
              offset: Offset(0, 2 * value), // Move the container up and down
              child: Container(
                height: widget.height!,
                width: widget.width!,
                padding: const EdgeInsets.all(20 / 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(colors: [
                    Colors.pinkAccent,
                    Colors.blue,
                  ]),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.pink,
                      offset: Offset(-2, 0),
                      blurRadius: 20,
                    ),
                    BoxShadow(
                      color: Colors.blue,
                      offset: Offset(2, 0),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(
                    widget.image??'assets/images/profile.png',
                    height:  MediaQuery.sizeOf(context).width * 0.3
                       ,
                    width: MediaQuery.sizeOf(context).width * 0.3
                       ,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 15,
        ),
        Text('Abdullah Alamary',style: Theme.of(context).textTheme.titleSmall,),
        const SizedBox(height: 20/4,),
        const Text('Senior Mobile Engineer',    textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w200,
              height: 1.5
          ),),
      ],
    );
  }
}
