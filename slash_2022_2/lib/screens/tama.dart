import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:slash_2022_2/utils/globals.dart';

class TamaScreen extends StatefulWidget {
  const TamaScreen({super.key});

  @override
  State<TamaScreen> createState() => _TamaScreenState();
}

class _TamaScreenState extends State<TamaScreen> {
  Duration duration =const Duration(seconds: 1);
  bool happy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Text("Score: $score", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                Stack(
                  children: [
                    newscores.isNotEmpty ? Draggable(
                      data: newscores.first,
                      feedback: /*SvgPicture.asset(
                        "assets/donut.svg",
                        width: 120,
                      ),*/
                      productTitle == 'Club-Mate' ?
                      Image.asset('assets/club_mate_pixel.png', width: 80,) : SvgPicture.asset(
                        "assets/donut.svg",
                        width: 120,
                      ),
                      childWhenDragging: /*SvgPicture.asset(
                        "assets/donut.svg ",
                        width: 80,
                        color: Colors.grey,
                      ),*/
                      productTitle == 'Club-Mate' ?
                      Image.asset('assets/club_mate_pixel.png', width: 80) : SvgPicture.asset(
                        "assets/donut.svg",
                        width: 120,
                      ),
                      child: /*SvgPicture.asset(
                        "assets/donut.svg",
                        width: 80,
                      )*/
                      productTitle == 'Club-Mate' ?
                      Image.asset('assets/club_mate_pixel.png', width: 80,) : SvgPicture.asset(
                        "assets/donut.svg",
                        width: 120,
                      ),
                    ) : Container()
                  ]
                ),
                SvgPicture.asset(
                  "assets/bowl.svg",
                  width: 80
                )
              ],
            )
          ),
          Center(
            child: DragTarget(
              onAccept: (int data) async {
                score += data;
                newscores.remove(data);
                setState(() {
                  happy = true;
                });
                Future.delayed(const Duration(milliseconds: 1800)).then((value) {
                  setState(() {
                    happy = false;
                  });
                });
              },
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected
              ) {
                return Container(
                  child: happy ? Image.asset(
                    "assets/happy.gif",
                    width: 280
                  ) : Image.asset(
                    "assets/idle.gif",
                    width: 280
                  )
                );
              }
            )
          ),
          // AnimatedPositioned(
          //   top: newdata ? 50.0 : (MediaQuery.of(context).size.height / 2) - 80.0,
          //   left: (MediaQuery.of(context).size.width / 2) - 20.0,
          //   duration: duration,
          //   curve: Curves.easeInOut,
          //   child: AnimatedOpacity(
          //     opacity: newdata ? 0.0 : 1.0,
          //     duration: duration,
          //     child: AnimatedOpacity(
          //       opacity: newdata ? 0.0 : 1.0,
          //       duration: duration,
          //       child: Text("XPPPPP", style: TextStyle(fontWeight: FontWeight.bold, color: newdata ? Colors.amber : Colors.transparent))
          //     )
          //   )
          // ),
        ]
      )
    );
  }
}