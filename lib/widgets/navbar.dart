import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget with PreferredSizeWidget {
  const Navbar({Key? key,
    required this.title,
    this.buttonLeft,
    this.buttonRight,
    this.map = const [],
    this.tabs = false,
    this.tabController,
  }) : super(key: key);

  final TabController? tabController;
  final String title;
  final bool tabs;
  final int? buttonLeft;
  final int? buttonRight;
  final List<Map<String, dynamic>>? map;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        title: TextView(
          text: title,
          fs: 17,
          fw: FontWeight.w800,
        ),
        leadingWidth: 74.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: (buttonLeft != null) ? DNavButton(
            itemCode: buttonLeft!.toInt(),
          ) : null,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: (buttonRight != null) ? DNavButton(
              itemCode: buttonRight!.toInt(),
              map: map,
            ) : null,
          ),
        ],
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE4E4E4), width: 1),
        ),
        bottom: tabs ?
        TabBar(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 10.0),
            controller: tabController,
            labelColor: const Color(0xFFF0674C),
            unselectedLabelColor: const Color(0xFF2D3A52),
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)
              ),
              color: Color.fromRGBO(240, 103, 76, 0.1),
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Exo2.0',
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            labelStyle: const TextStyle(
              fontFamily: 'Exo2.0',
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            tabs: const [
              Tab(
                text: 'Получения',
              ),
              Tab(
                text: 'Отправления',
              )

            ]
        ) : null
    );
  }

  @override
  Size get preferredSize =>
      (tabs) ? const Size.fromHeight(120) : const Size.fromHeight(65);
}


