import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _startAnimation = true;
  bool _showContent = false;
  bool _showResult = false;
  bool _isFake = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 0), () {
        setState(() {
          _startAnimation = false;
        });
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _showContent = true;
        });
      });
    });
  }

  Future<void> _submitNews() async {
    const url = 'https://ai-detection2.p.rapidapi.com/?text=';
    final text = _controller.text;
    final encodedText = Uri.encodeComponent(text);
    final apiUrl = '$url$encodedText';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-rapidapi-key': '6c1cd5d748msh56863d175e59cf5p18a897jsna7e50360dd29',
        'x-rapidapi-host': 'ai-content-detector1.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final fakeProbability = data['fake_probability'];

      setState(() {
        _showResult = true;
        _isFake = fakeProbability > 0.5;
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          // backgroundColor: Color.fromARGB(255, 207, 207, 207),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                top: _startAnimation ? -size.height * 0.15 : 0,
                right: _startAnimation ? -size.width * 0.5 : 0,
                child: Image(
                  image: AssetImage("assets/5.png"),
                  height: size.height * 0.15,
                  width: size.width * 0.5,
                  fit: BoxFit.fill,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                bottom: _startAnimation ? -size.height * 0.15 : 0,
                right: _startAnimation ? -size.width * 0.3 : 0,
                child: Image(
                  image: AssetImage("assets/6.png"),
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                  fit: BoxFit.fill,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                bottom: _startAnimation ? -size.height * 0.15 : 0,
                left: _startAnimation ? -size.width * 0.3 : 0,
                child: Image(
                  image: AssetImage("assets/4.png"),
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                  fit: BoxFit.fill,
                ),
              ),
              AnimatedOpacity(
                opacity: _showContent ? 1.0 : 0.0,
                curve: Curves.easeInOut,
                duration: Duration(seconds: 1),
                child: Container(
                  padding: EdgeInsets.only(
                      top: size.height * 0.035, left: size.width * 0.075),
                  width: size.width,
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fake News',
                        style: TextStyle(
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Newsreader',
                        ),
                      ),
                      Text(
                        'Predictor',
                        style: TextStyle(
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Newsreader',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: AnimatedOpacity(
                  opacity: _showContent ? 1.0 : 0.0,
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 2),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: size.width * 0.8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Enter Your News",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Material(
                          elevation: 1.5,
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            controller: _controller,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'Type your news text here...',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color.fromARGB(255, 207, 207, 207),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          child: Text('Clear'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.black; // hover color
                                }
                                return Color.fromARGB(
                                    255, 207, 207, 207); // default color
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.white; // hover text color
                                }
                                return Colors.black; // default text color
                              },
                            ),
                            splashFactory: InkRipple.splashFactory,
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey; // splash color
                                }
                                return Colors.transparent;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: _submitNews,
                          child: Text('Check'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.black; // hover color
                                }
                                return Color.fromARGB(
                                    255, 207, 207, 207); // default color
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.white; // hover text color
                                }
                                return Colors.black; // default text color
                              },
                            ),
                            splashFactory: InkRipple.splashFactory,
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey; // splash color
                                }
                                return Colors.transparent;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_showResult)
              Positioned(
                bottom: 90,
                right: size.width * 0.3,
                left: size.width * 0.3,
                child: AnimatedOpacity(
                  opacity: _showContent ? 1.0 : 0.0,
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 2),
                  child: Center(
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 30, left: 30),
                        decoration: BoxDecoration(
                          color: _isFake ? Colors.red : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _isFake ? 'Fake' : 'Real',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.0175),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                right: size.width * 0.2,
                left: size.width * 0.2,
                child: AnimatedOpacity(
                  opacity: _showContent ? 1.0 : 0.0,
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, right: 30, left: 30),
                      child: Column(
                        children: [
                          Text(
                            'All Rights Reserved by',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.height * 0.015),
                          ),
                          Text(
                            'QuadraBytes',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
