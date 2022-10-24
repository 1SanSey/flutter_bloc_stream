import 'package:flutter/material.dart';
import 'package:flutter_bloc_stream/color_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter BLoC with Stream',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ColorBloc _bloc = ColorBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter BLoC with Stream'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
            stream: _bloc.outputStateStream,
            initialData: Colors.deepOrangeAccent,
            builder: (context, AsyncSnapshot<Color> snapshot) {
              return AnimatedContainer(
                height: 100,
                width: 100,
                color: snapshot.data,
                duration: const Duration(milliseconds: 500),
              );
            }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: () {
                _bloc.inputEventSink.add(ColorEvent.eventOrange);
              }),
          const SizedBox(width: 10),
          FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: () {
                _bloc.inputEventSink.add(ColorEvent.eventGrey);
              }),
        ],
      ),
    );
  }
}
