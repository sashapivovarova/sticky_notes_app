import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_notes/page/loading_page.dart';
import 'package:sticky_notes/page/note_list_page.dart';

class OnBoardingPage extends StatelessWidget {
  static const routeName = '/';
  const OnBoardingPage({super.key});

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
            onDone: () {
              Navigator.pushNamed(context, '/list');
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
                title: 'Add',
                body: 'Add the note',
                image: Image.asset('assets/11.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Edit',
                body: 'Edit the note',
                image: Image.asset('assets/12.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Color',
                body: 'Color the note',
                image: Image.asset('assets/13.png'),
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
