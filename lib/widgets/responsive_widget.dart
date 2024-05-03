import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget Function(DeviceType) builder;
  const ResponsiveWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      DeviceType type = DeviceType.WEB;
      if(constraints.maxWidth < 550){
        type = DeviceType.MOBILE;
      }
      else if(constraints.maxWidth>550 && constraints.maxWidth<1000){
        type = DeviceType.TABLET;
      }
      return builder(type);
    },
    );
  }
}

enum DeviceType{
  WEB,
  TABLET,
  MOBILE,
}
