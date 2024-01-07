import 'package:bloc_cubits_1o1_counter_animation/core/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class PlayPauseAnimation extends StatefulWidget {
  const PlayPauseAnimation({Key? key}) : super(key: key);

  @override
  _PlayPauseAnimationState createState() => _PlayPauseAnimationState();
}

class _PlayPauseAnimationState extends State<PlayPauseAnimation> {
  final String animationURL = 'assets/animations/water-bar.riv';
  Artboard? _waterLevelBoard;
  SMINumber? Level;
  StateMachineController? stateMachineController;

  @override
  void initState() {
    super.initState();

    rootBundle.load(animationURL).then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "State Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          Level =
              stateMachineController!.findInput<double>('Level') as SMINumber;

          // for (var e in stateMachineController!.inputs) {
          //   debugPrint(e.runtimeType.toString());
          //   debugPrint("name${e.name}End");
          // }
        }

        setState(() => _waterLevelBoard = artboard);
      },
    );
  }

  void incrementLevel(val) {
    Level?.change(val.toDouble());
  }

  final counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, double>(
      bloc: counterCubit,
      builder: (context, counter) => Scaffold(
        body: Center(
          child: _waterLevelBoard != null
              ? Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      child: Rive(
                        artboard: _waterLevelBoard!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 3.0,
                            trackShape: const RoundedRectSliderTrackShape(),
                            activeTrackColor: Colors.lightBlue.shade500,
                            inactiveTrackColor: Colors.lightBlue.shade100,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 14.0,
                              pressedElevation: 8.0,
                            ),
                            thumbColor: Colors.pinkAccent,
                            overlayColor: Colors.pink.withOpacity(0.2),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 32.0,
                            ),
                            tickMarkShape: const RoundSliderTickMarkShape(),
                            activeTickMarkColor: Colors.pinkAccent,
                            inactiveTickMarkColor: Colors.white,
                            valueIndicatorShape:
                                const PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: Colors.black,
                            valueIndicatorTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          child: SizedBox(
                            width: 400,
                            child: Slider(
                              min: 0.0,
                              max: 100.0,
                              value: counterCubit.getSliderValue(),
                              label: '${counter.round()}',
                              onChanged: (value) {
                                incrementLevel(counterCubit.assignValue(value));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 20,
                  width: 20,
                  color: Colors.amber,
                ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // setState(() {
        //     incrementLevel(counterCubit.getCubit());
        //     // });
        //   },
        //   child: const Icon(
        //     Icons.add,
        //   ),
        // ),
      ),
    );
  }
}
