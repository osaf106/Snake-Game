import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/screens/FoodPixel.dart';
import 'package:snake_game/screens/blank_pixel.dart';
import 'package:snake_game/screens/snake_pixel.dart';

import 'MainGamePageScreen.dart';

class SnakeGamePage extends StatefulWidget {
  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

enum snake_Direction { UP, DOWN, LEFT, RIGHT }

class _SnakeGamePageState extends State<SnakeGamePage> {
// Grid Dimention boundry
  int rowSizeOfBountry = 10;
  int totolNumberOfBountry = 100;
  int currentScore = 0;
  bool isGameStart = false;
  Timer? timeget;

// Snake Postion
  List<int> snakePosition = [0, 1, 2];

  // Food for Snake
  int foodPosition = 55;

  void EatingFood() {
    currentScore++;
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(totolNumberOfBountry);
    }
  }

  // Start Game
  void startGame() {
    isGameStart = true;
    timeget = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        moveSnake();

        // Game Over
        if (gameOver()) {
          timer.cancel();
          showDialog(
              context: context,
              //barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Game Over"),
                  content: Text("Your Score is : " + currentScore.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          newGame();
                          Navigator.pop(context);
                        },
                        child: Text("ok"))
                  ],
                );
              });
        }
      });
    });
  }

  // Game Pause
  void pauseGame() {
    if (timeget != null) {
      timeget!.cancel();
    }
    isGameStart = false;
  }

  // Snake Direction
  var CurrentDirection = snake_Direction.RIGHT;

  // Move Direction
  void moveSnake() {
    if (CurrentDirection == snake_Direction.RIGHT) {
      // If Snake at right wall, new to repeat
      if (snakePosition.last % rowSizeOfBountry == 9) {
        // Add a new head
        snakePosition.add(snakePosition.last + 1 - rowSizeOfBountry);
      } else {
        snakePosition.add(snakePosition.last + 1);
      }
    } else if (CurrentDirection == snake_Direction.LEFT) {
      if (snakePosition.last % rowSizeOfBountry == 9) {
        // Add a new head
        snakePosition.add(snakePosition.last - 1 + rowSizeOfBountry);
      } else {
        snakePosition.add(snakePosition.last - 1);
      }
    } else if (CurrentDirection == snake_Direction.UP) {
      if (snakePosition.last < rowSizeOfBountry) {
        snakePosition
            .add(snakePosition.last - rowSizeOfBountry + totolNumberOfBountry);
      } else {
        snakePosition.add(snakePosition.last - rowSizeOfBountry);
      }
    } else if (CurrentDirection == snake_Direction.DOWN) {
      if (snakePosition.last + rowSizeOfBountry > totolNumberOfBountry) {
        snakePosition
            .add(snakePosition.last + rowSizeOfBountry - totolNumberOfBountry);
      } else {
        snakePosition.add(snakePosition.last + rowSizeOfBountry);
      }
    }

    if (snakePosition.last == foodPosition) {
      EatingFood();
    } else {
      snakePosition.removeAt(0);
    }
  }

  bool gameOver() {
    List<int> bodyOfSnake = snakePosition.sublist(0, snakePosition.length - 1);
    if (bodyOfSnake.contains(snakePosition.last)) {
      return true;
    }
    return false;
  }

  void newGame() {
    setState(() {
      snakePosition = [0, 1, 2];
      foodPosition = 55;
      currentScore = 0;
      CurrentDirection = snake_Direction.RIGHT;
      isGameStart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: ScreenWidth < 420 ? 420 : ScreenWidth,
          height: ScreenHeight > 1000 ? 1000 : ScreenHeight,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainGamePageScreen()));
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Current Score",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        currentScore.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 40),
                      ),
                    ],
                  ),
                ],
              )),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white)),
                  child: GestureDetector(
                    onVerticalDragUpdate: (detail) {
                      if (detail.delta.dy > 0 &&
                          CurrentDirection != snake_Direction.UP) {
                        CurrentDirection = snake_Direction.DOWN;
                      } else if (detail.delta.dy < 0 &&
                          CurrentDirection != snake_Direction.DOWN) {
                        CurrentDirection = snake_Direction.UP;
                      }
                    },
                    onHorizontalDragUpdate: (detail) {
                      if (detail.delta.dx > 0 &&
                          CurrentDirection != snake_Direction.LEFT) {
                        CurrentDirection = snake_Direction.RIGHT;
                      } else if (detail.delta.dx < 0 &&
                          CurrentDirection != snake_Direction.RIGHT) {
                        CurrentDirection = snake_Direction.LEFT;
                      }
                    },
                    child: GridView.builder(
                        itemCount: totolNumberOfBountry,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: rowSizeOfBountry),
                        itemBuilder: (context, index) {
                          if (snakePosition.contains(index)) {
                            if (snakePosition.last == index) {
                              return const SnakeLastPixel();
                            }
                            return const SnakePixel();
                          } else if (foodPosition == index) {
                            return const FoodPixel();
                          } else {
                            return const BlankPixel();
                          }
                        }),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                      width: 360,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 40,),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: MaterialButton(
                                  onPressed: () {
                                    pauseGame();
                                  },
                                  color: isGameStart == false? Colors.grey : Colors.green,
                                  child: const Text(
                                    "Pause",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                  onPressed: () {
                                    if (CurrentDirection !=
                                        snake_Direction.DOWN) {
                                      CurrentDirection = snake_Direction.UP;
                                    }
                                  },
                                  color: Colors.pink,
                                  child: const Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                    size: 24,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: MaterialButton(
                                    onPressed: () {
                                      if (CurrentDirection !=
                                          snake_Direction.RIGHT) {
                                        CurrentDirection = snake_Direction.LEFT;
                                      }
                                    },
                                    color: Colors.pink,
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: MaterialButton(
                                  onPressed: () {
                                    isGameStart ? () {} : startGame();
                                  },
                                  color:
                                      isGameStart == true ? Colors.grey : Colors.green,
                                  child: const Text(
                                    "Play",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: MaterialButton(
                                    onPressed: () {
                                      if (CurrentDirection !=
                                          snake_Direction.LEFT) {
                                        CurrentDirection =
                                            snake_Direction.RIGHT;
                                      }
                                    },
                                    color: Colors.pink,
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                              onPressed: () {
                                if (CurrentDirection != snake_Direction.UP) {
                                  CurrentDirection = snake_Direction.DOWN;
                                }
                              },
                              color: Colors.pink,
                              child: const Icon(
                                Icons.arrow_downward,
                                color: Colors.white,
                                size: 24,
                              )),
                        ],
                      )
                      // Center(
                      //   child: MaterialButton(
                      //     onPressed: startGame,
                      //     color: Colors.red,
                      //     child: const Text("Play"),
                      //   ),
                      // ),
                      )),
            ],
          ),
        ));
  }
}
