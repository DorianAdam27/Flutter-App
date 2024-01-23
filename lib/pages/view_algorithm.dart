import 'package:flutter/material.dart';
import 'package:myapp/sorting_algorithms.dart';
import 'dart:async';

class ViewAlgorithmPage extends StatefulWidget {
  final String source;

  const ViewAlgorithmPage({Key? key, required this.source}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ViewAlgorithmPageState createState() => _ViewAlgorithmPageState();
}

class _ViewAlgorithmPageState extends State<ViewAlgorithmPage> {
  StreamController<List<int>> controller = StreamController<List<int>>();
  StreamController<double> speedController = StreamController<double>();

  bool _actionCompleted = false;
  double _speed = 1.0;
  bool _buttonsEnabled = true;
  bool _sortingInProgress = true;

  void _updateSpeed(double value) {
    if (_buttonsEnabled && value >= 0.25 && value <= 4) {
      setState(() {
        _speed = value;
        speedController.add(value);
      });
    }
  }

  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: (300 / _speed).round()));
  }

  Stream<List<Widget>> addItem(List<int> list) async* {
    int max = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] > max) {
        max = list[i];
      }
    }
    List<Widget> generatedWidgets = [];

    await for (var steppy in exeAlgorithm(list)) {
      List<Widget> widgets = [];

      for (int i = 0; i < steppy.length; i++) {
        widgets.add(SizedBox(
          width: 340 / (2 * steppy.length),
        ));

        widgets.add(Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: steppy[i] * (300 / max),
              width: 340 / (2 * steppy.length),
              color: const Color.fromARGB(255, 0, 0, 0),
            )
          ],
        ));
      }

      generatedWidgets = widgets;

      yield [Row(children: generatedWidgets)];

      await _delay();
    }
  }

  Stream<List<int>> exeAlgorithm(List<int> list) async* {
    controller.add(list);

    if (_sortingInProgress) {
      if (widget.source == "Selection") {
        yield* selection(list);
      } else if (widget.source == "Insertion") {
        yield* insertion(list);
      } else if (widget.source == "Bubble") {
        yield* bubble(list);
      } else if (widget.source == "Quick") {
        yield* quick(list);
      } else if (widget.source == "Merge") {
        yield* mergeSort(list);
      } else if (widget.source == "Bogo") {
        yield* bogo(list);
      } else if (widget.source == "Heap") {
        yield* heap(list);
      } else if (widget.source == "Shell") {
        yield* shell(list);
      }

      setState(() {
        _sortingInProgress = false;
      });
    }

    if (!_actionCompleted) {
      setState(() {
        _actionCompleted = true;
        _buttonsEnabled = false;
      });
    }
  }

  @override
  void dispose() {
    controller.close();
    speedController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    list.shuffle();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.source} Sorting",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 100, 128, 153),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(159, 255, 236, 1),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: StreamBuilder<List<Widget>>(
                  stream: addItem(list),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No data available"));
                    } else {
                      return Stack(
                        children: [
                          Row(
                            children: snapshot.data!,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                ),
                child: IconButton(
                  icon: const Icon(Icons.fast_rewind),
                  iconSize: 36.0,
                  onPressed: _actionCompleted
                      ? null
                      : () {
                          _updateSpeed(_speed * 0.5);
                        },
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "${_speed}x",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                ),
                child: IconButton(
                  icon: const Icon(Icons.fast_forward),
                  iconSize: 36.0,
                  onPressed: _actionCompleted
                      ? null
                      : () {
                          _updateSpeed(_speed * 2.0);
                        },
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
