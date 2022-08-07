import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math'as math show Random;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}
const names=[
"mehedi",'rakiv',"sakaib","hasan",'omar','bangladesh'
];
extension RendomElement<T> on Iterable<T>{
  T getRendomElement ()=> elementAt(math.Random().nextInt(length));
} 

class NamesQubits extends Cubit<String?> {
  NamesQubits():super(null);

  void PicRandomNames()=>emit(names.getRendomElement());


  
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NamesQubits qubit;
  @override
  void initState() {
    qubit=NamesQubits();
    super.initState();
  }
  @override
  void dispose() {
    qubit.close();
    super.dispose();
  }
  @override
  Widget build(
    
    BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Qubits"),),
      body: StreamBuilder(
        stream: qubit.stream,
        
        builder: (context,snapshot){
        final button= TextButton(onPressed: ()=>
          qubit.PicRandomNames(),
        child:Text('Pick a random Name') );

        switch(snapshot.connectionState){
          
          case ConnectionState.none:
           return button;
          
          case ConnectionState.waiting:
         return button;
     
          case ConnectionState.active:
            return Column(
              children: [
                Text("${snapshot.data??''}"),
                
                button
              ],
            );
           
          case ConnectionState.done:
            return SizedBox();
           
        }

      }),
    );

    
  }
}