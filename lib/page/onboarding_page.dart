import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  static const routeName = '/';
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showSkipButton: true,
      skip: const Text(
        'Skip',
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
      onSkip: () {
        Navigator.pushNamed(context, '/list');
      },
      done: const Text(
        'Start',
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
      onDone: () {
        Navigator.pushNamed(context, '/list');
      },
      next: const Text(
        'Next',
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
      dotsContainerDecorator: const BoxDecoration(
        color: Colors.black,
      ),
      dotsDecorator: DotsDecorator(
        color: Colors.white,
        activeColor: Colors.pink,
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
          title: 'Home',
          body: 'You can look everything',
          image: Image.asset('assets/11.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Search',
          body: 'You can search everything',
          image: Image.asset('assets/12.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Shopping cart',
          body: 'You can buy everything',
          image: Image.asset('assets/13.png'),
          decoration: getPageDecoration(),
        ),
      ],
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.pink,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.pink,
      ),
      imagePadding: EdgeInsets.only(
        top: 40,
      ),
      pageColor: Colors.black,
    );
  }
}
