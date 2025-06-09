import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_page.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class OnboardingScreen extends ConsumerStatefulWidget {
   OnboardingScreen({super.key, required this.pages});

  List<OnboardingPage> pages;
 
  @override
  ConsumerState<OnboardingScreen> createState() => _MyOnboardingScreenState();
}

class _MyOnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  late bool _isLastPage;
  final double horizontalPadding = 20;
  final double topPadding = 80;
  final double bottomPadding = 20;
  final double buttonMinHeight = 56;
  final double buttonHorizontalPadding = 32;
  final buttonTextStyle = const TextStyle(fontSize: 18);
  final String startButtonText = nt.t.login;
  final String skipButtonText = nt.t.skip;
  final String nextButtonText = nt.t.next;

  // Define your list of pages. In our example we have 3 different pages
  
  @override
  void initState() {
    _isLastPage = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Here include the _onSkip(), _onNext(), _onContinue() code listed in the section buttons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                _isLastPage = index == widget.pages.length - 1;
              });
            },
            controller: _controller,
            children: widget.pages,
          ),
          Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: Align(
              alignment: Alignment.topCenter,
              //Stepper
              child: SmoothPageIndicator(
                controller: _controller,
                count: widget.pages.length,
                effect: SlideEffect(
                  dotColor: Colors.white.withOpacity(0.3),
                  activeDotColor: Colors.white,
                ),
                onDotClicked: (index) => _controller.animateToPage(
                  index,
                  duration: const Duration(microseconds: 350),
                  curve: Curves.easeIn,
                ),
              ),
            ),
          ),
          // Here include the stepper code listed in the section stepper
          // Here include the _isLastPage listed in the section buttons
          _isLastPage ? _getLastPageButtons() : _getPageButtons()
        ],
      ),
    );
  }

  void _onSkip() => _controller.jumpToPage(widget.pages.length);

  void _onNext() => _controller.nextPage(
      duration: const Duration(milliseconds: 350), curve: Curves.easeIn);

  void _onContinue() {
    if (context.mounted) {
      // go to sign in page after completing onboarding
      ref.read(nestAuthProvider.notifier).login();
    }
  }

  Widget _getPageButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            bottom: bottomPadding,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: _onSkip,
              child: Text(
                skipButtonText,
                style: buttonTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: horizontalPadding,
            bottom: bottomPadding,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: buttonMinHeight,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: _onNext,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: buttonHorizontalPadding,
                    right: buttonHorizontalPadding,
                  ),
                  child: Text(
                    nextButtonText,
                    style: buttonTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _getLastPageButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: bottomPadding,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            minimumSize: Size.fromHeight(buttonMinHeight),
          ),
          onPressed: _onContinue,
          child: Text(
            startButtonText,
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
