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
                "Koromo's works\n"
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
                    ProjectWidget(title: "Frontier Wallet"),
                    ProjectWidget(title: "Click2Chat"),
                    ProjectWidget(title: "QArt Fashion"),
                    ProjectWidget(title: "ReadyO"),
                    ProjectWidget(title: "Payoye"),
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

  const ProjectWidget({Key? key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('images/icon.png'),
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
