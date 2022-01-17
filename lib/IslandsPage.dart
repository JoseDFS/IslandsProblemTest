import 'dart:math';

import 'package:flutter/material.dart';

class IslandsPage extends StatefulWidget {
  final mSize;
  IslandsPage({@required this.mSize});

  @override
  State<StatefulWidget> createState() => _IslandsPage();
}

class _IslandsPage extends State<IslandsPage> {
  Random random = new Random();
  late List<List<num>> matrix;
  @override
  void initState() {
    matrix = new Iterable<List<num>>.generate(
            int.parse(widget.mSize),
            (i) => new Iterable<num>.generate(
                int.parse(widget.mSize), (j) => random.nextInt(2)).toList())
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(matrix);
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(4),
                    child: Row(children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ])),
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.0)),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: matrix.length,
                      ),
                      itemBuilder: _buildGridItems,
                      itemCount: matrix.length * matrix.length,
                      shrinkWrap: true,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text("Número de Islas: " + _nIslands(matrix),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ],
            ))));
  }

  String _nIslands(List<List<num>> matrix) {
    var matrixC = matrix.map((e) => e.toList()).toList();
    if (matrixC.length == 0) return "0";
    int nIslands = 0;
    for (int i = 0; i < matrixC.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrixC[i][j] == 1) {
          nIslands += neighbors(matrixC, i, j);
        }
      }
    }
    print(nIslands);
    return nIslands.toString();
  }

  int neighbors(List<List<num>> matrix, int i, int j) {
    var matrixN = new List<List<num>>.from(matrix);
    if (i < 0 ||
        i >= matrixN.length ||
        j < 0 ||
        j >= matrixN[i].length ||
        matrixN[i][j] == 0) return 0;
    matrixN[i][j] = 0;
    neighbors(matrixN, i + 1, j);
    neighbors(matrixN, i - 1, j);
    neighbors(matrixN, i, j + 1);
    neighbors(matrixN, i, j - 1);
    return 1;
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = matrix.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (matrix[x][y] == 1)
            matrix[x][y] = 0;
          else
            matrix[x][y] = 1;
        });
        print(matrix[x][y]);
      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Center(
            child: _itemBuild(x, y),
          ),
        ),
      ),
    );
  }

  Widget _itemBuild(int x, int y) {
    switch (matrix[x][y]) {
      case 1:
        return Icon(Icons.terrain, color: Colors.brown);
      case 0:
        return Icon(Icons.water, color: Colors.blue);
      default:
        return Text(matrix[x][y].toString());
    }
  }
}
