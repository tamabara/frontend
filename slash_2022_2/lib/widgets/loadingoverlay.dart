// Packages
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


// Controller
class LoadingController {
  Duration mindisplayduration;
  Duration animationduration;
  DateTime? starttime;
  OverlayEntry? overlayEntry;
  late RxBool started;

  LoadingController({this.mindisplayduration = const Duration(milliseconds: 1000), this.animationduration = const Duration(milliseconds: 250)});

  void show(BuildContext context) {
    starttime = DateTime.now();
    started = RxBool(false);
  
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) => _LoadingOverlay(
      animationduration: animationduration,
      loadingController: this
    ));
    if (overlayEntry != null) {
      overlayState?.insert(overlayEntry!);
    }
    Future.delayed(const Duration(milliseconds: 50)).then((value) { started.value = true;});
  }

  Future<void> hide() async {
    if (DateTime.now().difference(starttime!) < animationduration) {
      await Future.delayed(animationduration - DateTime.now().difference(starttime!));
    }
    if (DateTime.now().difference(starttime!) < mindisplayduration) {
      await Future.delayed(mindisplayduration - DateTime.now().difference(starttime!));
    }
    started.value = false;
    await Future.delayed(animationduration);
    if (overlayEntry != null && overlayEntry!.mounted) {
      overlayEntry?.remove();
    }
  }

  void dispose() {
    if (overlayEntry != null && overlayEntry!.mounted) {
      overlayEntry?.remove();
    }
  }
}


// Overlay
class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay({super.key, required this.animationduration, required this.loadingController});

  final Duration animationduration;
  final LoadingController loadingController;

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
  
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() => AnimatedOpacity(
        opacity: loadingController.started.value ? 1.0: 0.0,
        duration: animationduration,
        child: Stack(
          children: [

            // Loading Background
            const Opacity(
              opacity: 0.7, 
              child: ModalBarrier(dismissible: false, color: Colors.black)
            ),

            // Loading Animation
            Opacity(
              opacity: 1.0, 
              child: Center(
                child: Container(
                  width: 170,
                  height: 170,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Image.asset("assets/plantanim.gif")
                      ),
                      const Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ]
                  )
                )
              )
            )
          ],
        )
      ))
    );
  }
}
