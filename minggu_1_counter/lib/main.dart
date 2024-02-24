import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Minggu 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _staticNrp = '3122600007';
  String _nrp = '';

  int _oddNum = 1;
  int _evenNum = 0;

  List<Widget> _triangleRow = [];

  void _handleStates() {
    setState(() {
      if (_nrp == _staticNrp) {
        _resetState();
      } else {
        _nrp += _staticNrp[_nrp.length];
        _oddNum += 2;
        _evenNum += 2;
        _handleTriangleRow();
      }
    });
  }

  void _resetState() {
    _nrp = '';
    _oddNum = 1;
    _evenNum = 0;
    _triangleRow = [];
  }

  void _handleTriangleRow() {
    _triangleRow.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _addTriangleRowChildren(),
    ));
  }

  List<Widget> _addTriangleRowChildren() {
    List<Widget> rowChildren = [];

    // for (int i = 0; i < _nrp.length; i++) {
    //   rowChildren.add(Text(
    //     "*",
    //     style: Theme.of(context).textTheme.headlineLarge,
    //   ));
    // }

    List.generate(
        _nrp.length,
        (index) => rowChildren.add(Text(
              "*",
              style: Theme.of(context).textTheme.headlineLarge,
            )));

    return rowChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Odd Counter:'),
            Text(
              '$_oddNum',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text('Even Counter:'),
            Text(
              '$_evenNum',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text(
              'NRP Counter',
            ),
            Text(
              _nrp,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text(
              'Triangle',
            ),
            Column(
              children: _triangleRow,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleStates,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
