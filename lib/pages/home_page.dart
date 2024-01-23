import 'package:flutter/material.dart';
import 'package:myapp/pages/view_algorithm.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Image.asset("assets/selection_algorithm_image.png",
                      width: 175.0, height: 175.0),
                  //iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ViewAlgorithmPage(source: 'Selection'),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Image.asset("assets/bubble_algorithm_image.png",
                      width: 175.0, height: 175.0),
                  //iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ViewAlgorithmPage(source: 'Bubble'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Image.asset("assets/insertion_algorithm_image.png",
                      width: 175.0, height: 175.0),
                  //iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ViewAlgorithmPage(source: 'Insertion'),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Image.asset("assets/quick_algorithm_image.png",
                      width: 175.0, height: 175.0),
                  //iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ViewAlgorithmPage(source: 'Quick'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Image.asset("assets/merge_algorithm_image.png",
                      width: 175.0, height: 175.0),
                  //iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ViewAlgorithmPage(source: 'Merge'),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Image.asset("assets/bogo_algorithm_image.png",
                      width: 175.0, height: 175.0),
                  //iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ViewAlgorithmPage(source: 'Bogo'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Image.asset("assets/heap_algorithm_image.png",
                      width: 175.0, height: 175.0),
                  //iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ViewAlgorithmPage(source: 'Heap'),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Image.asset("assets/shell_algorithm_image.png",
                      width: 175.0, height: 175.0),
                  //iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ViewAlgorithmPage(source: 'Shell'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(
    title: const Text(
      "Sorting Algorithms",
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 100, 128, 153),
  );
}
