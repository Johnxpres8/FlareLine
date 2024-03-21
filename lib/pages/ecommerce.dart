import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_flutter_admin_dashboard/components/card/white_card.dart';
import 'package:free_flutter_admin_dashboard/components/charts/bar_chart.dart';
import 'package:free_flutter_admin_dashboard/components/chats.dart';
import 'package:free_flutter_admin_dashboard/components/charts/circular_chart.dart';
import 'package:free_flutter_admin_dashboard/components/charts/line_chart.dart';
import 'package:free_flutter_admin_dashboard/components/charts/map_chart.dart';
import 'package:free_flutter_admin_dashboard/components/tables/TopChannel.dart';

class EcommercePage extends StatelessWidget {
  const EcommercePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: SingleChildScrollView(
          child: Column(children: [
        _cardPages(),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          height: 350.h,
          child: Row(
            children: [
              Expanded(
                child: _lineChart(),
                flex: 2,
              ),
              Expanded(
                child: _barChart(),
                flex: 1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          height: 350.h,
          child: Row(
            children: [
              Expanded(
                child: WhiteCard(
                  child: CircularhartWidget(),
                ),
                flex: 2,
              ),
              Expanded(
                child: WhiteCard(
                  child: MapChartWidget(),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
            height: 380.h,
            child: Row(
              children: [
                Expanded(
                  child: TopChannelWidget(),
                  flex: 2,
                ),
                Expanded(child: ChatsWidget(), flex: 1),
              ],
            ))
      ])),
    );
  }

  _cardPages() {
    return Row(
      children: [
        _itemCardWidget(
            Icons.data_object, '\$3.456K', 'Total views', '0.43%', true),
        _itemCardWidget(
            Icons.shopping_cart, '\$45.2K', 'Total Profit', '0.43%', true),
        _itemCardWidget(Icons.group, '2.450', 'Total Product', '0.43%', true),
        _itemCardWidget(
            Icons.security_rounded, '3.456', 'Total Users', '0.43%', false),
      ],
    );
  }

  _itemCardWidget(IconData icons, String text, String subTitle,
      String percentText, bool isGrow) {
    return Expanded(
        child: WhiteCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Container(
                width: 36.w,
                height: 36.w,
                alignment: Alignment.center,
                child: Icon(icons),
                color: Colors.grey.shade200,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              children: [
                Text(
                  subTitle,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
                Spacer(),
                Text(
                  percentText,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: isGrow ? Colors.green : Colors.lightBlue),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Icon(
                  isGrow ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isGrow ? Colors.green : Colors.lightBlue,
                  size: 12.w,
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  _lineChart() {
    return WhiteCard(
      child: LineChartWidget(),
    );
  }

  _barChart() {
    return WhiteCard(child: BarChartWidget());
  }
}
