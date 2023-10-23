import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:quiz/model/model_quiz.dart';
import 'package:quiz/screen/screen_result.dart';
import 'package:quiz/widget/widget_candidates.dart';

class QuizScreen extends StatefulWidget {
  final List<Quiz>? quizs;
  const QuizScreen({super.key, this.quizs});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<int> _answers = [-1, -1, -1];
  List<bool> _answerState = [false, false, false, false];
  int _currentIndex = 0;
  final SwiperController _controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black),
            ),
            width: width * 0.85,
            height: height * 0.5,
            child: Swiper(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.quizs!.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizs![index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q${_currentIndex + 1}.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: _buildCandidates(width, quiz),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: ButtonTheme(
              minWidth: width * 0.5,
              height: height * 0.05,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepOrangeAccent)),
                onPressed: _answers[_currentIndex] == -1
                    ? null
                    : () {
                        if (_currentIndex == widget.quizs!.length - 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                      answers: _answers,
                                      quizs: widget.quizs!)));
                        } else {
                          _answerState = [false, false, false, false];
                          _currentIndex += 1;
                          _controller.next();
                        }
                      },
                child: _currentIndex == widget.quizs!.length - 1
                    ? const Text(
                        '결과보기',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        '다음문제',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> children = [];
    for (int i = 0; i < 4; i++) {
      children.add(
        CandWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                } else {
                  _answerState[j] = false;
                }
              }
            });
          },
        ),
      );
      children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }
    return children;
  }
}
