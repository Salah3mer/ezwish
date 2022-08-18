import 'package:bee/screens/login_screen/login_screen.dart';
import 'package:bee/shared/components/components.dart';
import 'package:bee/shared/network/local/cash_helper.dart';
import 'package:bee/shared/style/style.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/style/icon_broken.dart';

class OnBoardingScreen extends StatefulWidget {
  final String? title;
  final String? body;
  final String? image;

   OnBoardingScreen({this.title, this.body, this.image});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool? isLast = false;
  List<OnBoardingScreen> bord = [
    OnBoardingScreen(
      title: 'Shopping',
      body: 'We’re making shopping better',
      image: 'assets/image/Online Groceries-pana.png',
    ),
    OnBoardingScreen(
      title: 'For shoppers',
      body:
          'We’re on a mission to redefine how the world shops. We’ve already upgraded the way buyers check out and track their orders, and become one of the most downloaded apps in app stores. But there are so many more firsts to come.',
      image: 'assets/image/Ecommerce campaign-rafiki (1).png',
    ),
    OnBoardingScreen(
        title: 'For merchants',
        body:
            'We believe it’s time for buyers and merchants to be connected in ways they never have been before. For the millions of entrepreneurs and businesses out there, Shop is an audience and a mobile storefront at your fingertips.',
        image: 'assets/image/Business deal-rafiki.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 16,color: defColor),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => page(bord[index]),
              itemCount: bord.length,
              controller: pageController,
              onPageChanged: (int index) {
                if (index == bord.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                }else {
                  setState(() {
                    isLast = false;
                  });}
              },
            )),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: bord.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey.shade300,
                      activeDotColor: defColor,
                    )),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defColor,
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                    if (isLast == true) {
                      submit();
                    }
                  },
                  child: const  Icon(
                    IconBroken.Arrow___Right_2,
                    size: 30,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget page(OnBoardingScreen model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image!))),
          Text(
            model.title!,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(model.body!,
              style: const TextStyle(
                fontSize: 20,
              )),
          const SizedBox(
            height: 30,
          ),
        ],
      );

  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navegatTo(context,  LoginScreen());
    });
  }
}


