import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_notes/page/loading_page.dart';
import 'package:sticky_notes/page/note_list_page.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = '/';
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  Future<bool> haveSeenIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('haveSeenIntro') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: haveSeenIntro(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.error != null) {
          return const SplashScreen();
        }
        if (snapshot.data != null) {
          return const NoteListPage();
        } else {
          return IntroductionScreen(
            showSkipButton: true,
            skip: const Text(
              'Skip',
            ),
            onSkip: () {
              Navigator.pushNamed(context, '/list');
            },
            done: const Text(
              'Start',
            ),
            // onDone: () {
            //   Navigator.pushNamed(context, '/list');
            // },
            onDone: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('haveSeenIntro', true);
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return const NoteListPage();
              }));
            },
            next: const Text(
              'Next',
            ),
            dotsDecorator: DotsDecorator(
              activeSize: const Size(
                30,
                10,
              ),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
            ),
            pages: [
              PageViewModel(
                title: 'How to add',
                body: 'Touch the plus button!',
                image: Image.asset(
                  'assets/add.png',
                ),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'How to color',
                body: 'Touch the palette button!',
                image: Image.asset('assets/color.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'How to save',
                body: 'Touch the save button!',
                image: Image.asset('assets/save.png'),
                decoration: getPageDecoration(),
              ),
            ],
          );
        }
      },
    );
  }
}

PageDecoration getPageDecoration() {
  return const PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyTextStyle: TextStyle(
      fontSize: 18,
    ),
    imagePadding: EdgeInsets.only(
      top: 40,
    ),
  );
}
