
import 'package:flutter/material.dart';

import '../screens/notes_screen.dart';

class WelcomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color(0xFFFFF8FC),

      body: SafeArea(

        child: Padding(

          padding: EdgeInsets.all(25),

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Container(

                width: 120,
                height: 120,

                decoration: BoxDecoration(

                  color: Color(0xFFF8D5E4),

                  shape: BoxShape.circle,
                ),

                child: Icon(

                  Icons.auto_awesome,

                  size: 60,

                  color: Color(0xFFD06C9F),
                ),
              ),

              SizedBox(height: 30),

              Text(

                'Hi, Shahd! 🌷',

                style: TextStyle(

                  fontSize: 32,

                  fontWeight: FontWeight.bold,

                  color: Color(0xFF3E3440),
                ),
              ),

              SizedBox(height: 15),

              Text(

                'What are you thinking about today?',

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 19,

                  color: Color(0xFF5E535B),
                ),
              ),

              SizedBox(height: 10),

              Text(

                'Write it down before it gets away. ✨',

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 14,

                  color: Color(0xFF9A8992),
                ),
              ),

              SizedBox(height: 35),

              Container(

                padding: EdgeInsets.all(18),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  border: Border.all(

                    color: Color(0xFFF1DCE7),
                  ),
                ),

                child: Row(

                  children: [

                    Icon(

                      Icons.favorite_border,

                      color: Color(0xFFD98BB6),
                    ),

                    SizedBox(width: 12),

                    Expanded(

                      child: Text(

                        'Your thoughts deserve a little space. 💕',

                        style: TextStyle(

                          color: Color(0xFF756B73),

                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 35),

              SizedBox(

                width: double.infinity,

                height: 55,

                child: ElevatedButton(

                  onPressed: () {

                    Navigator.pushReplacement(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>
                            NotesScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        Color(0xFFD98BB6),

                    foregroundColor:
                        Colors.white,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(17),
                    ),
                  ),

                  child: Row(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Text(

                        'Let’s Start',

                        style: TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 10),

                      Icon(
                        Icons.arrow_forward_rounded,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

