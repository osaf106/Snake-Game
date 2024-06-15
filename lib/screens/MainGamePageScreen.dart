import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/screens/SnakeGamePage.dart';

class MainGamePageScreen extends StatefulWidget {
  const MainGamePageScreen({super.key});

  @override
  State<MainGamePageScreen> createState() => _MainGamePageScreenState();
}

class _MainGamePageScreenState extends State<MainGamePageScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x181818BB),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_main_page.jpg"),
                fit: BoxFit.fitHeight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Snake Game",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700
              ),
            ),
            const Text(
              "Created by Osaf Ahmad Sial",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(height: 70,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SnakeGamePage()));
              },
              child: Container(
                width: 130,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: const Center(
                    child: Text("Play",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    )
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              width: 130,
              height: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: ()
                {
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: const Text("Haat Gandu"),
                      content: const Text("Score q Dakhna a"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("ok"))
                      ],
                    );
                  });
                },
                child: const Center(
                    child: Text("Score",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    )
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              width: 130,
              height: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: ()
                {
                  if(Platform.isAndroid)
                  {
                    SystemNavigator.pop();
                  }
                  else
                  {
                    exit(0);
                  }
                },
                child: const Center(
                    child: Text("Exit",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
