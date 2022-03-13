import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MiddleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Vx.black,
          child: Flex(
              direction: context.isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                "Koromo's\n"
                    .richText
                    .withTextSpanChildren(
                        ["Favorite Photo".textSpan.yellow400.make()])
                    .xl4
                    .white
                    .make(),
                20.widthBox,
                Expanded(
                    child: VxSwiper(
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  items: [
                    ProjectWidget(title: "宣伝写真",photo: 'images/1.JPG',),
                    ProjectWidget(title: "ハウス",photo: 'images/8.JPG',),
                    ProjectWidget(title: "膝上",photo: 'images/9.jpg',),
                    ProjectWidget(title: 'ぶち上げ',photo: 'images/10.jpg',),
                    ProjectWidget(title: "HP写真",photo: 'images/2.JPG',),
                  ],
                  height: 170,
                  viewportFraction: context.isMobile ? 0.75 : 0.4,
                  autoPlay: true,
                  autoPlayAnimationDuration: 1.seconds,
                ))
              ]).p64().h(context.isMobile ? 500 : 300),
        ),
      ],
    );
  }
}

class ProjectWidget extends StatelessWidget {
  final String? title;
  final String? photo;

  const ProjectWidget({Key? key,
    required this.title,
    required this.photo
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(photo!),
        title!.text.bold.white.xl.wide.fade
            .make()
            .box
        .alignBottomLeft
            .p8
            .roundedFull
            // .neumorphic(color: Vx.yellow400, elevation: 5, curve: VxCurve.flat)
            .alignCenter
            .square(100)
            .make()
            .py16(),
      ],
    );
  }
}
