import 'dart:math';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'colors.dart';

class HeaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final nameWidget = "ころも"
    //     .text
    //     .white
    //     .xl6
    //     .lineHeight(1)
    //     .size(context.isMobile ? 15 : 20)
    //     .bold
    //     .make()
    //     .shimmer();
    return SafeArea(
      child: VxBox(
              child: VStack([
        ZStack(
          [
            PictureWidget(),
            Row(
              children: [
                VStack([
                  if (context.isMobile) 50.heightBox else 10.heightBox,
                  // CustomAppBar().shimmer(primaryColor: Coolors.accentColor),
                  10.heightBox,
                  // nameWidget,
                  20.heightBox,
                  // VxBox()
                  //     .color(Coolors.accentColor)
                  //     .size(60, 10)
                  //     .make()
                  //     .px4()
                  //     .shimmer(primaryColor: Coolors.accentColor),
                  30.heightBox,
                  // SocialAccounts(),
                ]).pSymmetric(
                  h: context.percentWidth * 10,
                  v: 32,
                ),
                Expanded(
                  child: VxResponsive(
                    medium: IntroductionWidget()
                        .pOnly(left: 120)
                        .h(context.percentHeight * 60),
                    large: IntroductionWidget()
                        .pOnly(left: 120)
                        .h(context.percentHeight * 60),
                    fallback: const Offstage(),
                  ),
                )
              ],
            ).w(context.screenWidth)
          ],
        )
      ]))
          .size(context.screenWidth, context.percentHeight * 60)
          .color(Coolors.secondaryColor)
          .make(),
    );
  }
}


class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        [
          " - Introduction".text.gray500.widest.make(),
          10.heightBox,
          "名前：ころも\n由来：天ぷらの衣みたいだから\n誕生日：2021/11/18\n犬種：マルチーズ×プードル\n性別：♂\n毛色：アプリコット"
              "出身地：茨城県"
              .text
              .white
              .xl3
              .maxLines(5)
              .make()
              .w(context.isMobile
                  ? context.screenWidth
                  : context.percentWidth * 40),
          20.heightBox,
        ].vStack(),
       SizedBox(
         height: MediaQuery.of(context).size.width*2,
         width: MediaQuery.of(context).size.width,
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Container(
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.white),
             child: Column(
               children: [
                 Text('歴史',style: TextStyle(fontSize: 30,color: Colors.black),),
                 histryCard('2022/3/4','犬を買うことを決心する'),
                 histryCard('2022/3/5','ペットショップ5店舗はしごしてクタクタに'),
                 histryCard('2022/3/5','1店舗目で出会った犬が運命だと思ったが別な人に取られ絶望する'),
                 histryCard('2022/3/5','ネットでころもに出会う。次の日に朝イチで埼玉まで遠征することを決意する'),
                 histryCard('2022/3/6','10時開店のため9時59分に店の前で待機'),
                 histryCard('2022/3/6','飼うことを即決')
               ],
             ),
           ),
         ),
       )
        // RaisedButton(
        //   onPressed: () {
        //     launch("https://mtechviral.com");
        //   },
        //   hoverColor: Vx.purple700,
        //   shape: Vx.roundedSm,
        //   color: Coolors.accentColor,
        //   textColor: Coolors.primaryColor,
        //   child: "Visit mtechviral.com".text.make(),
        // ).h(50)
      ],
      // crossAlignment: CrossAxisAlignment.center,
      alignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Card histryCard(String title,String subtitle) {
    return Card(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.all(Radius.circular(120)),
                 ),
                 elevation: 10,
                 color: brownColor,
                 child: ListTile(
                   leading: Icon(Icons.fiber_manual_record,color: Colors.black,),
                   title: Text(title,style: TextStyle(color: Colors.black),),
                   subtitle: Text(subtitle,style: TextStyle(color: Colors.black)),
                 ),
               );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.code,
      size: 50,
      color: Colors.brown[400],
    );
  }
}

class PictureWidget extends StatelessWidget {
  const PictureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      origin: Offset(context.percentWidth * 2, 0),
      transform: Matrix4.rotationY(pi),
      child: Image.asset(
        "images/1.JPG",
        fit: BoxFit.cover,
        height: context.percentHeight * 60,
      ),
    );
  }
}

class SocialAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        Icons.add,
        color: Colors.white,
      ).mdClick(() {
        launch("https://twitter.com/imthepk");
      }).make(),
      20.widthBox,
      Icon(
        Icons.add,
        color: Colors.white,
      ).mdClick(() {
        launch("https://instagram.com/codepur_ka_superhero");
      }).make(),
      20.widthBox,
      Icon(
        Icons.add,
        color: Colors.white,
      ).mdClick(() {
        launch("https://youtube.com/mtechviral");
      }).make(),
      20.widthBox,
      Icon(
        Icons.add,
        color: Colors.white,
      ).mdClick(() {
        launch("https://github.com/iampawan");
      }).make()
    ].hStack();
  }
}
