import 'dart:math';

import 'screen_util.dart';

extension SizeExtension on num {
  ///[ScreenUtil.setWidth]
  double get w => ScreenUtil().setWidth(this);

  ///[ScreenUtil.setHeight]
  double get h => ScreenUtil().setHeight(this);

  ///[ScreenUtil.radius]
  double get r => ScreenUtil().radius(this);

  ///[ScreenUtil.setSp]
  double get sp => ScreenUtil().setSp(this);

  ///smart size :  it check your value if it is bigger than your value set your value
  ///for example you have set 16.sm() , if for your screen 16.sp() bigger than 16 it will  set 16 not 16.sp()
  ///I think that it is good for save size balance on big sizes of screen
  double get sm => min(toDouble(), sp);

  ///Multiple of screen width
  double get sw => ScreenUtil().screenWidth * this;

  ///Multiple of screen height
  double get sh => ScreenUtil().screenHeight * this;
}
