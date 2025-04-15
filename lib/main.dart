import 'dart:async';

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
        primarySwatch: Colors.blue,
      ),
      home: const Horloge(),
    );
  }
}

class Horloge extends StatefulWidget {
  const Horloge({super.key});

  @override
  State<Horloge> createState() => _HorlogeState();
}

class _HorlogeState extends State<Horloge> {
  String _hCourant = "00";
  String _mCourant = "00";
  String _sCourant = "00";

  late Timer _timerHorloge;
  bool _startHorloge = false;

  void demarrerHorloge() {
    if (_startHorloge == true) {
      _timerHorloge = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _hCourant = DateTime.now().hour.toString().padLeft(2, '0');
          _mCourant = DateTime.now().minute.toString().padLeft(2, '0');
          _sCourant = DateTime.now().second.toString().padLeft(2, '0');
        });
      });
    }
  }
  void arreterHorloge(){
    if (_startHorloge == false) {
      _timerHorloge.cancel();
    }
  }

  ElevatedButton buildStartButton() {
    return ElevatedButton(
      onPressed: () {
        if(_startHorloge == false) {
          setState(() {
            _startHorloge = true;
          });
          demarrerHorloge();
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.blue, // <-- Button color
      ),
      child: const Icon(
        Icons.play_arrow,
        size: 25,
        color: Colors.white,
      ),
    );
  }

  ElevatedButton buildPauseButton() {
    return ElevatedButton(
      onPressed: () {
        if(_startHorloge == true) {
          setState(() {
            _startHorloge = false;
          });
          arreterHorloge();
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50),
        backgroundColor: Colors.red, // <-- Button color
      ),
      child: const Icon(
        Icons.pause,
        size: 25,
        color: Colors.white,
      ),
    );
  }

  Column buildAffichageHorraire(value, texte) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value.toString(),
          style: TextStyle(fontSize: 50),
        ),
        Text(
          texte,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Row buildHeureCourante() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildAffichageHorraire(_hCourant, 'heures'),
        const SizedBox(
          width: 20,
        ),
        buildAffichageHorraire(_mCourant, 'minutes'),
        const SizedBox(
          width: 20,
        ),
        buildAffichageHorraire(_sCourant, 'secondes'),
      ],
    );
  }

  Row buildLigneControle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildStartButton(),
        buildPauseButton(),
      ],
    );
  }

  Column buildColonneCentrale() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildHeureCourante(),
        buildLigneControle(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: buildColonneCentrale(),
        ),
      ),
    );
  }
}
