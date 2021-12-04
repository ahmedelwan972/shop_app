import 'package:ayop01/modules/shop_app/shop_login/shop_login.dart';
import 'package:ayop01/shared/components/components.dart';
import 'package:ayop01/shared/network/local/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late String image;
  late String title;
  late String text;

  BoardingModel({
    required this.image,
    required this.title,
    required this.text,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/image/onboarding_1.PNG',
      title: 'Boarding 1 Tilte',
      text: 'Boarding 1 Text',
    ),
    BoardingModel(
      image: 'assets/image/onboarding_2.PNG',
      title: 'Boarding 2 Tilte',
      text: 'Boarding 2 Text',
    ),
    BoardingModel(
      image: 'assets/image/onboarding_3.PNG',
      title: 'Boarding 3 Tilte',
      text: 'Boarding 3 Text',
    ),
  ];
  var pageController = PageController();
  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value)
    {
      if(value) navigateAndFinish(context, ShopLogin());
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submit,
              child: Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) => buildItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index)
                  {
                    if(index == boarding.length -1)
                      {
                        setState(() {
                          isLast= true;
                        });
                      } else
                        {
                          isLast=false;
                        }
                  },
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5,
                      activeDotColor: Colors.teal,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLast)
                      {
                        submit();
                      }
                      else
                        {
                          pageController.nextPage(
                              duration: Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }

                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  buildItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${model.image}'),
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.text}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
}
