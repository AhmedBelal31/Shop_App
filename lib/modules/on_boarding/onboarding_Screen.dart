import 'package:flutter/material.dart';
import 'package:shop_app/Network/local/Chache_Helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../component/component.dart';
import '../../style/color.dart';
import '../shop_app_login/shop_login_screen.dart';

class BoardingModel {
  final String image;

  final String title;

  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // const OnBoarding_Screen({Key? key}) : super(key: key);
  var pageController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> list = [
      BoardingModel(
          image: "lib/assets/images/onboarding1.jpg",
          title: "On Board 1 Title ",
          body: "On Board 1 body"),
      BoardingModel(
          image: "lib/assets/images/shopping1.png",
          title: "On Board 2 Title",
          body: "On Board 2 body"),
      BoardingModel(
          image: "lib/assets/images/shopping2.jpg",
          title: "On Board 3 Title",
          body: "On Board 3 body"),
    ];

    void onSubmit() {
      Cache_Helper.saveDataToSharedPref(key: 'onboarding', value: true)
          .then((value) {
        if (value == true) {
          NavigateAndRep(context, LoginScreen());
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  onSubmit();
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                      color: defaultColor, fontWeight: FontWeight.bold),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(list[index]),
                  itemCount: list.length,
                  onPageChanged: (index) {
                    if (index == list.length - 1) {
                      setState(() {
                        isLast = true;
                        // print("isLast");
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 5,
                      expansionFactor: 4,
                      activeDotColor: defaultColor,
                    ),
                    controller: pageController,
                    onDotClicked: (index) {
                      // print(index);
                    },
                    count: list.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast == true) {
                        // NavigateAndRep(context, shopLogin());
                        onSubmit();
                      } else {
                        pageController.nextPage(
                            duration: const Duration(microseconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildBoardingItem(BoardingModel obj) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(obj.image),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(obj.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
        ),
        Text(obj.body,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
