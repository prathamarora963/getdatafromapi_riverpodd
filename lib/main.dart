import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodd/data_controller.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

//Create a variable using riverpod
final greetingprovider = StateProvider((ref) => 0);
//decalare the variable of changeNotifier
final incrementProvider = ChangeNotifierProvider((ref) => Incrementcounter());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyhomePage2(),
    );
  }
}

//Create class by using changeNotifier
class Incrementcounter extends ChangeNotifier {
  int _value = 0;
  int get value => _value;
  void increment() {
    _value++;
    notifyListeners();
  }
}

//To get the variable value by using consumerwidget
class  MyhomePage2 extends ConsumerWidget {
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen<StateController<int>>(greetingprovider.state, (previous, current) {
    // note: this callback executes when the provider value changes,
    // not when the build method is called
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Value is ${current.state}')),
    );
  });
  final watchs = ref.watch(getDataFuture); 
    return Scaffold(
      appBar: AppBar(title: Text(watchs.toString())),
      body: watchs.listDataModel.isEmpty ? Center(child: CircularProgressIndicator(),) : ListView.builder(itemCount: watchs.listDataModel.length,itemBuilder: (context,index){
        return Column(
          children: [
            Text(watchs.listDataModel[index].title)
          ],
        );
      })
    );
  }
}

//To get the variable value by using Consumer
class MyWidget extends StatefulWidget {
  
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final home = Provider((ref)=>0);
  void initState(){
    super.initState();
    print(home);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //Increment by using consumer
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final incrementnotifier = ref.watch(incrementProvider);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(incrementnotifier.value.toString()),
                ElevatedButton(
                    onPressed: () {
                      ref.read(incrementProvider).increment();
                    },
                    child: Text('increment'))
              ],
            );
          },
        ),
      ),
    );
  }
}
class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// 2. Extend [ConsumerState]
class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // 3. use ref.read() in the widget life-cycle methods
    final value = ref.read(greetingprovider);
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    // 3. use ref.watch() to get the value of the provider
    final value = ref.watch(greetingprovider);
    return Scaffold(
      body: Center(
        child: Text(
          'Value: $value',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
           
//           ],
//         ),
//       ),
//     // ailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
