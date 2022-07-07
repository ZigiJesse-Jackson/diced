import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const Diced());
}

class Diced extends StatelessWidget {
  const Diced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Diced',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Akshar',
                fontSize: 20,
                letterSpacing: 1.5),
          ),
          backgroundColor: Colors.red,
        ),
        body: const DicedPage(),
      ),
    );
  }
}

class DicedPage extends StatelessWidget {
  const DicedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const dice_board();
  }
}

class dice_board extends StatefulWidget {
  const dice_board({Key? key}) : super(key: key);

  @override
  State<dice_board> createState() => _dice_boardState();
}

class _dice_boardState extends State<dice_board> {

  bool turn = true;
  int dice_1 = 1;
  int dice_2 = 2;
  int player = 1;
  String statement = 'Player Turn';
  int plays = 0;

  // check if player turn is valid
  bool check_player(int player, bool turn) {
    // check if player 1 turn is valid
    if (player == 1 && turn == false) {
      setState(() {
        statement = 'Player 2 turn! Player 1 cannot play';
      });
      return false;
    }

    // check if player 2 turn is valid
    if (player == 2 && turn == true) {
      setState(() {
        statement = 'Player 1 turn! Player 2 cannot play';
      });
      return false;
    }
    return true;
  }

  // check result of game between player 1 and 2
  void winner() {
    if (dice_2 > dice_1) {
      setState(() {
        statement = 'Player 2 wins!\nPlayer 1 turn';
        turn = true;
        player = 1;
        plays = 0;
      });
      return;
    }
    if (dice_1 == dice_2) {
      setState(() {
        statement = 'Draw! Player 1 turn';
        turn = true;
        player = 1;
        plays = 0;
      });
      return;
    } else {
      setState(() {
        statement = 'Player 1 wins!\nPlayer 2 turn';
        turn = false;
        player = 1;
        plays = 0;
      });
    }

    return;
  }

  // user clicks first dice
  void play_1() {
    int play = Random().nextInt(6) + 1;

    if (!check_player(1, turn)) {
      return;
    }

    if (turn) {
      setState(() {
        dice_1 = play;
        turn = false;
        plays++;
      });
    }
    return;
  }

  // User clicks second dice
  void play_2() {
    int play = Random().nextInt(6) + 1;

    if (!check_player(2, turn)) {
      return;
    }

    if (!turn) {
      setState(() {
        dice_2 = play;
        turn = true;
        plays++;
      });
    }
    if (plays == 2) {
      winner();
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextButton(
                    onPressed: play_1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'images/dice$dice_1.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  const Text(
                    'Player 1',
                    style: TextStyle(
                      fontFamily: 'Alegreya-light',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  TextButton(
                    onPressed: play_2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/dice$dice_2.png'),
                    ),
                  ),
                  const Text(
                    'Player 2',
                    style: TextStyle(
                      fontFamily: 'Alegreya-light',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '$statement',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamily: 'Alegreya-light',
              letterSpacing: 2,
            ),
          ),
        ),
        //TextButton(onPressed: onPressed, child: child)
      ],
    );
  }
}