import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flareline/components/sidebar/side_menu.dart';
import 'package:flareline/themes/global_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideBarWidger extends StatelessWidget {
  const SideBarWidger({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: sideBar,
      width: 280,
      child: Column(children: [
        _logoWidget(context),
        const SizedBox(
          height: 30,
        ),
        Expanded(child: _sideListWidget(context))
      ]),
    );
  }

  _logoWidget(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        SvgPicture.asset(
          'assets/logo/logo-icon.svg',
          height: 32,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          AppLocalizations.of(context)!.appName,
          style: const TextStyle(color: Colors.white, fontSize: 32),
        ))
      ],
    );
  }

  _sideListWidget(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/routes/menu_route_en.json'),
            builder: (context, snapshot) {
              // Decode the JSON
              List listMenu = json.decode(snapshot.data.toString());
              return ListView.separated(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  itemBuilder: (ctx, index) {
                    return itemBuilder(ctx, index, listMenu);
                  },
                  separatorBuilder: separatorBuilder,
                  itemCount: listMenu.length);
            }));
  }

  Widget itemBuilder(BuildContext context, int index, List listMenu) {
    var groupElement = listMenu.elementAt(index);
    List menuList = groupElement['menuList'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          groupElement['groupName'],
          style: const TextStyle(fontSize: 18, color: Colors.white60),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: menuList.map((e) => SideMenuWidget(e: e)).toList(),
        )
      ],
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const Divider(
      height: 10,
      color: Colors.transparent,
    );
  }
}
