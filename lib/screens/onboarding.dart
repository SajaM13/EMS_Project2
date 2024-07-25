import 'package:eventsapp/Network/global.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:login_screen/Layout/Beauty_Store/halls_list_screen.dart';
// import 'package:login_screen/Shared/components.dart';
// import 'package:login_screen/Shared/network/local/Cache_helper.dart';
// import 'package:login_screen/Shared/styles/colors.dart';
// import 'package:login_screen/modules/login/hall_details.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// onboarding واقدر قلب بيناتن ثم نأخذ ليستا من هذا الكلاس ونضعها ضمن كلاس ال pageview أنشأنا هذا الكلاس مشان اقدر بدل المعلومات الموجودة بال
class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoarding_Screen extends StatefulWidget {
  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/image/on1.jpg',
        title: 'Supports Different Types Of Parties',
        body: 'Come Join Family And Friends '),
    BoardingModel(
        image: 'assets/image/on2.jpg',
        title: 'Book Your Perfect Day',
        body: 'Create The Ultimate daily Routine For The Best Life Ever'),
    BoardingModel(
        image: 'assets/image/on3.jpg',
        title: 'Details To Remember',
        body: 'How To Plan A Stress Free Party'),
  ];
  bool isLast = false;

  //onboardingللداتا يلي عندي يعني هون بكون سيفت ال  save مشان اعمل
  /* void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            //onPressed: submit,
            onPressed: () {
              //navigateAndFinish(context, halles_screen());
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                color: Color(0xFFFDD5D9),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller:
                    boardController, // (FloatingActionButton مشان اقدر اتحكم بحركة الويدجت من الزر (من

//loginتعطي الاندكس يلي وصلتلو من خلالها بقدرحدد الشرط للانتقال لسكرينة ال
                onPageChanged: (int index) {
                  //الموجودة كبسة الزر ستغير انتقالها set state شرط الوصول لاخر الليستاوبناء على ال
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(
                  //buildBoardingItem حطلع عنصر عنصر من اللليستا وابعتو لل
                  boarding[index],
                ),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    //indicatorتتيح استخدام
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: lightpink,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length),
                Spacer(), // يعطي مسافة فاضية بيناتن
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      Navigator.pushReplacementNamed(context, "login");
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: Color(0XFFD66E79),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
