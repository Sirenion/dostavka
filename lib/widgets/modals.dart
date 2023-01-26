import 'package:dostavka/blocs/city_search/city_search_bloc.dart';
import 'package:dostavka/blocs/city_search/city_search_events.dart';
import 'package:dostavka/blocs/city_search/city_search_states.dart';
import 'package:dostavka/blocs/create_sending/create_sending_bloc.dart';
import 'package:dostavka/blocs/profile/profile_bloc.dart';
import 'package:dostavka/custom_icons.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/screens/sendings/report.dart';
import 'package:dostavka/screens/sendings_create/box_size.dart';
import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/text_field.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/street_search/street_search_bloc.dart';
import '../blocs/street_search/street_search_events.dart';
import '../blocs/street_search/street_search_states.dart';
import '../connectors/suggest.dart';
import '../models/hive_connection/getters.dart';

class DBottomSheetMore extends StatelessWidget {
  const DBottomSheetMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: const Color(0xFFF6F7F9),
        padding: const EdgeInsets.all(15.0),
        child: const Icon(
          CustomIcons.more,
          color: Color(0xFF2D3A52),
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  margin: const EdgeInsets.all(20.0),
                  child: Wrap(
                    children: const [
                      DBottomSheetMoreItem(num: 0),
                      DBottomSheetMoreItem(num: 1),
                      DBottomSheetMoreItem(num: 2),
                      DBottomSheetMoreItem(num: 3, border: false),
                    ],
                  ),
                );
              });
        });
  }
}

class DBottomSheetMoreItem extends StatelessWidget {
  const DBottomSheetMoreItem({Key? key, required this.num, this.border = true})
      : super(key: key);

  final int num;
  final bool border;

  @override
  Widget build(BuildContext context) {
    String text = 'Ошибка';
    IconData i = CustomIcons.warning;
    Color c = const Color(0xFF2D3A52);
    VoidCallback? onTap;
    switch (num) {
      case 0:
        {
          i = CustomIcons.download;
          text = 'Скачать накладную';
          break;
        }
      case 1:
        {
          i = CustomIcons.warning;
          text = 'Сообщить о проблеме...';
          onTap = () {
            Navigator.of(context).pop();
            Navigator.of(context).push(ReportProblem.route());
          };
          break;
        }
      case 2:
        {
          i = CustomIcons.document;
          text = 'Оформить возврат...';
          break;
        }
      case 3:
        {
          i = CustomIcons.delete;
          text = 'Удалить отправление';
          c = const Color(0xFFF04C4C);
          break;
        }
      default:
        {
          onTap = () {
            Navigator.of(context).pop();
          };
          break;
        }
    }
    return Container(
        child: ListTile(
          leading: Icon(
            i,
            color: c,
          ),
          title: TextView(
            text: text,
            color: c,
            fw: FontWeight.w600,
          ),
          onTap: onTap,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          border: border
              ? const Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFFE2E5EA)))
              : null,
        ));
  }
}

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key, required this.isError, required this.text})
      : super(key: key);
  final bool isError;
  final String text;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard>
    with TickerProviderStateMixin {
  bool visible = true;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    // _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animation,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E5EA), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: widget.isError ? 'Ошибка' : 'Успешно',
                fs: 15,
                fw: FontWeight.w600,
                color: widget.isError ? const Color(0xFFF0674C) : const Color(0xFF1EC15F),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextView(text: widget.text),
            ],
          ),
        )

/*Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE2E5EA), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: isError ? 'Ошибка' : 'Успешно',
                              fs: 15,
                              fw: FontWeight.w600,
                              color: isError ? Color(0xFFF0674C) : Color(0xFF1EC15F),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 5)),
                            TextView(text: text),
                          ],
                        ))
*/

        );
  }
}

Future<void> showError(BuildContext context, String text,
    [bool isError = true]) async {
  OverlayEntry? entry;
  entry = OverlayEntry(builder: (context) {
    return Positioned(
        top: 60,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        child: GestureDetector(
            onTap: () {
              entry!.remove();
            },
            child: NotificationCard(text: text, isError: isError)));
  });

  Overlay.of(context)?.insert(entry);

  Future.delayed(const Duration(seconds: 2), () {
    entry!.remove();
  });
}

class DFloatNotification extends StatelessWidget {
  const DFloatNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DModalPassword extends StatelessWidget {
  const DModalPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(CustomIcons.warning),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    titlePadding: EdgeInsets.zero,
                    title: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: Color(0xFFE2E5EA))),
                        ),
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const TextView(
                              text: 'Пароль',
                              fw: FontWeight.w800,
                              fs: 17.0,
                            ),
                            IconButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              icon: const Icon(CustomIcons.close),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            )
                          ],
                        )),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    contentPadding: const EdgeInsets.only(bottom: 10.0),
                    content: SingleChildScrollView(
                        child: Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                      child: const TextView(
                        text:
                            'Используется для защиты пользователя',
                        fw: FontWeight.w600,
                      ),
                    )));
              });
        });
  }
}

class DModalSenderPassword extends StatelessWidget {
  const DModalSenderPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String password = ' ';

    return BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(),
        child: AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: Container(
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xFFE2E5EA))),
              ),
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 5,
                    child: TextView(
                      text: 'Пароль для отправителей',
                      fw: FontWeight.w800,
                      fs: 17.0,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      icon: const Icon(CustomIcons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              )),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: const EdgeInsets.all(20.0),
          content:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DTextFieldSecondary(
                    label: 'Введите пароль',
                    onChanged: (value) {
                      password = value;
                      BlocProvider.of<ProfileBloc>(context)
                          .add(ProfileModalPasswordConfirm(password: value));
                    }),
                const Padding(padding: EdgeInsets.symmetric(vertical: 7.0)),
                CupertinoButtonPrimary(
                    textLabel: 'Сохранить',
                    proceed: true,
                    callback: (state is ProfileModalPasswordSuccess)
                        ? () {
                            Navigator.pop(context, true);
                          }
                        : null)
              ],
            );
          }),
        ));
  }
}

class DModalDiscount extends StatelessWidget {
  const DModalDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String promoCode = ' ';
    return BlocProvider<CreateSendingBloc>(
        create: (_) => CreateSendingBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: AlertDialog(
                titlePadding: EdgeInsets.zero,
                title: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFFE2E5EA))),
                    ),
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TextView(
                          text: 'Промокод на скидку',
                          fw: FontWeight.w800,
                          fs: 17.0,
                        ),
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          icon: const Icon(CustomIcons.close),
                          color: const Color(0xFF2D3A52),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                contentPadding: const EdgeInsets.all(20.0),
                content: BlocBuilder<CreateSendingBloc, CreateSendingState>(
                    builder: (context, state) {
                  VoidCallback? callback = (state is CreateSendingPromoSuccess)
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : null;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DTextFieldSecondary(
                          isError: (promoCode == ' ')
                              ? false
                              : (state is CreateSendingPromoError &&
                                      state.promo.isEmpty)
                                  ? true
                                  : false,
                          label: 'Введите промокод',
                          onChanged: (value) {
                            promoCode = value;
                            BlocProvider.of<CreateSendingBloc>(context)
                                .add(CreateSendingPromoConfirm(promo: value));
                          }),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.0)),
                      CupertinoButtonPrimary(
                        textLabel: 'Применить',
                        proceed: true,
                        callback: callback,
                      )
                    ],
                  );
                }))));
  }
}

class DModalCity extends StatelessWidget {
  DModalCity({
    Key? key,
    required this.order,
  }) : super(key: key);

  final int order;
  late var res;

  @override
  Widget build(BuildContext context) {
    List<String> entries = [];
    var s = false;
    TextEditingController editingController = TextEditingController();
    return BlocProvider<CitySearchBloc>(
        create: (context) => CitySearchBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: NotificationListener<
                DraggableScrollableNotification>(
                onNotification: (notification) {
                  if (notification.extent > 0.8) {
                    BlocProvider.of<CitySearchBloc>(
                        notification.context)
                        .add(
                        const CitySearchDragModalStateChangedEvent(
                            true));
                    s = true;
                  } else {
                    BlocProvider.of<CitySearchBloc>(
                        notification.context)
                        .add(const CitySearchDragModalStateChangedEvent(
                        false));
                    s = false;
                  }
                  return false;
                },
                child: DraggableScrollableSheet(
                    maxChildSize: 0.9,
                    minChildSize: 0.6,
                    initialChildSize: 0.6,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return BlocProvider.value(
                          value: BlocProvider.of<CitySearchBloc>(
                              context),
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  )),
                              padding:
                              const EdgeInsets.symmetric(
                                  vertical: 10.0),
                              child:
                              BlocBuilder<CitySearchBloc,
                                  CitySearchState>(
                                  builder: (context, state) {
                                    return Column(children: [
                                      headerBuilder(s, context),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 20.0,
                                            right: 20.0),
                                        child: DAutoCompleteTextField(
                                          label: 'Город назначения...',
                                          controller: editingController,
                                          onChanged: (value) {
                                            BlocProvider.of<
                                                CitySearchBloc>(context)
                                                .add(CitySearch(
                                                search: value));
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: FutureBuilder(
                                              future: (getCity(
                                                  editingController.text == ''
                                                      ? 'г.'
                                                      : editingController.text
                                                      .toString())),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Map<String,
                                                      List<
                                                          dynamic>>> snapshot) {
                                                if (snapshot.hasData &&
                                                    snapshot.data != null) {
                                                  if (snapshot
                                                      .data!["suggestions"]!
                                                      .isNotEmpty) {
                                                    entries.clear();
                                                    for (int j = 0; j < snapshot
                                                        .data!["suggestions"]!
                                                        .length; j++) {
                                                      if (snapshot
                                                          .data!["suggestions"]![j]["data"]["city"] !=
                                                          null) {
                                                        entries.add(
                                                            snapshot
                                                                .data!["suggestions"]![j]["data"]["city"]
                                                                .toString());
                                                      }
                                                    }
                                                    res = snapshot.data!["suggestions"]!;
                                                    return listBuilder(
                                                        scrollController,
                                                        entries,
                                                        editingController.text);
                                                  } else {
                                                    return Container();
                                                  }
                                                } else {
                                                  return Container();
                                                }
                                              }
                                          )
                                      )
                                    ]);
                                  })));
                    }))));
  }



  Future<Map<String, List<dynamic>>> getCity(String city) async{
    var sugg = Getters.getSuggest().values.first;
    var param = { 'value': 'city' };
    var response = Suggest.create();
    final data = await response.getAddressSuggest("Token ${sugg.token}", city, param, param);
    final res = Map<String, List<dynamic>>.from(data.body);
    return res;
  }

  List<String> search(String query, List<String> list) {
    final cities = list.where((element) {
      final e = element.toLowerCase();
      final s = query.toLowerCase();
      return e.contains(s);
    }).toList();
    return cities;
  }

  List<TextSpan> textBuilder(String entry, String text) {
    List<TextSpan> l = <TextSpan>[];
    var s = text.toLowerCase();
    var e = entry.toLowerCase();
    int idx = e.indexOf(s);
    var t = entry.split('');
    List<String> a = <String>[];
    if (idx >= 0) {
      for (int j = 0; j < idx; j++) {
        a.add(t[j]);
      }
      l.add(TextSpan(
        text: a.join(''),
        style: const TextStyle(
          fontFamily: 'Exo2.0',
          fontWeight: FontWeight.w400,
          fontSize: 15.0,
          color: Color.fromRGBO(45, 58, 82, .3),
        ),
      ));
      a.clear();
      for (int j = idx; j < idx + text.length; j++) {
        a.add(t[j]);
      }
      l.add(TextSpan(
        text: a.join(''),
        style: const TextStyle(
          fontFamily: 'Exo2.0',
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
          color: Color.fromRGBO(45, 58, 82, 1),
        ),
      ));
      a.clear();
      for (int j = idx + text.length; j < t.length; j++) {
        a.add(t[j]);
      }
      l.add(TextSpan(
        text: a.join(''),
        style: const TextStyle(
          fontFamily: 'Exo2.0',
          fontWeight: FontWeight.w400,
          fontSize: 15.0,
          color: Color.fromRGBO(45, 58, 82, .3),
        ),
      ));
    }
    return l;
  }

  Widget listBuilder(ScrollController scrollController, List<String> entries, String text) {
    var o = entries;
    if (text.isNotEmpty) {
      o = search(text, entries);
    }
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      itemCount: o.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: (text.isNotEmpty)
                ? RichText(
                    text: TextSpan(children: textBuilder(o[index], text)))
                : TextView(
                    text: o[index],
                    fs: 15.0,
                    fw: FontWeight.w600,
                  ),
            contentPadding: const EdgeInsets.all(0.0),
            onTap: () {
              switch(order) {
                case 1: {
                  var croco = Getters.getCreateOrder().values.first;
                  Update.editCreateOrder(croco, from: res[index]);
                  break;
                }
                case 2: {
                  var croco = Getters.getCreateOrder().values.first;
                  Update.editCreateOrder(croco, to: res[index]);
                  break;
                }
                default: {
                  break;
                }
              }
              Navigator.pop(context, o[index]);
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          child: Container(
            color: const Color(0xFFE2E5EA),
            width: double.infinity,
            height: 1,
          ),
        );
      },
    );
  }

  Widget headerBuilder(bool state, BuildContext context) {
    if (state) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: ListTile(
            leading: const Icon(
              CustomIcons.close,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            title: const TextView(
              text: 'Выбрать город назначения',
              fw: FontWeight.w800,
              fs: 17.0,
            ),
            contentPadding: const EdgeInsets.all(0.0),
          ),
        ),
        SizedBox(
          child: Container(
            color: const Color(0xFFE2E5EA),
            width: double.infinity,
            height: 1,
          ),
        ),
      ]);
    } else {
      return const SizedBox();
    }
  }
}

class DModalCityButton extends StatelessWidget {
  const DModalCityButton({
    Key? key,
    required this.controller,
    this.label = 'Город',
    this.isError = false,
    this.order = 0,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final int order;
  final bool isError;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DTextDropdown(
        controller: controller,
        label: label,
        isError: isError,
        onChanged: onChanged,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => DModalCity(order: order)).then((value) {
          (value != null) ? controller.text = value : controller.text = '';
        });
      },
    );
  }
}

class DModalStreet extends StatelessWidget {
  DModalStreet({
    Key? key,
    required this.order,
    required this.city
  }) : super(key: key);

  final int order;
  late var res;
  final String city;

  @override
  Widget build(BuildContext context) {
    List<String> entries = [];
    var s = false;

    TextEditingController editingController = TextEditingController();
    return BlocProvider<StreetSearchBloc>(
        create: (context) => StreetSearchBloc(),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: NotificationListener<
                DraggableScrollableNotification>(
                onNotification: (notification) {
                  if (notification.extent > 0.8) {
                    BlocProvider.of<StreetSearchBloc>(
                        notification.context)
                        .add(
                        const StreetSearchDragModalStateChangedEvent(
                            true));
                    s = true;
                  } else {
                    BlocProvider.of<StreetSearchBloc>(
                        notification.context)
                        .add(const StreetSearchDragModalStateChangedEvent(
                        false));
                    s = false;
                  }
                  return false;
                },
                child: DraggableScrollableSheet(
                    maxChildSize: 0.9,
                    minChildSize: 0.6,
                    initialChildSize: 0.6,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return BlocProvider.value(
                          value: BlocProvider.of<StreetSearchBloc>(
                              context),
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  )),
                              padding:
                              const EdgeInsets.symmetric(
                                  vertical: 10.0),
                              child:
                              BlocBuilder<StreetSearchBloc,
                                  StreetSearchState>(
                                  builder: (context, state) {
                                    return Column(children: [
                                      headerBuilder(s, context),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 20.0,
                                            right: 20.0),
                                        child: DAutoCompleteTextField(
                                          label: 'Улица...',
                                          controller: editingController,
                                          onChanged: (value) {
                                            BlocProvider.of<
                                                StreetSearchBloc>(context)
                                                .add(StreetSearch(
                                                search: value));
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: FutureBuilder(
                                              future: (getStreet(city== ''
                                                  ? 'г.' : city,
                                                  editingController.text == ''
                                                      ? ''
                                                      : editingController.text
                                                      .toString(), )),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Map<String,
                                                      List<
                                                          dynamic>>> snapshot) {
                                                if (snapshot.hasData &&
                                                    snapshot.data != null) {
                                                  if (snapshot
                                                      .data!["suggestions"]!
                                                      .isNotEmpty) {
                                                    entries.clear();
                                                    for (int j = 0; j < snapshot
                                                        .data!["suggestions"]!
                                                        .length; j++) {
                                                      if (snapshot
                                                          .data!["suggestions"]![j]["value"] !=
                                                          null) {
                                                        entries.add(
                                                            snapshot
                                                                .data!["suggestions"]![j]["value"]
                                                                .toString());
                                                      }
                                                    }
                                                    res = snapshot.data!["suggestions"]!;
                                                    return listBuilder(
                                                        scrollController,
                                                        entries,
                                                        editingController.text);
                                                  } else {
                                                    return Container();
                                                  }
                                                } else {
                                                  return Container();
                                                }
                                              }
                                          )
                                      )
                                    ]);
                                  })));
                    }))));
  }



  Future<Map<String, List<dynamic>>> getStreet(String city, String str) async{
    var sugg = Getters.getSuggest().values.first;
    // var param = { 'value': 'city' };
    var response = Suggest.create();
    final data = await response.getAddressSuggest("Token ${sugg.token}", "${city}, ${str}", {}, {});
    final res = Map<String, List<dynamic>>.from(data.body);
    return res;
  }

  List<String> search(String query, List<String> list) {
    final cities = list.where((element) {
      final e = element.toLowerCase();
      final s = query.toLowerCase();
      return e.contains(s);
    }).toList();
    return cities;
  }

  List<TextSpan> textBuilder(String entry, String text) {
    List<TextSpan> l = <TextSpan>[];
    var s = text.toLowerCase();
    var e = entry.toLowerCase();
    int idx = e.indexOf(s);
    var t = entry.split('');
    List<String> a = <String>[];
    if (idx >= 0) {
      for (int j = 0; j < idx; j++) {
        a.add(t[j]);
      }
      l.add(TextSpan(
        text: a.join(''),
        style: const TextStyle(
          fontFamily: 'Exo2.0',
          fontWeight: FontWeight.w400,
          fontSize: 15.0,
          color: Color.fromRGBO(45, 58, 82, .3),
        ),
      ));
      a.clear();
      for (int j = idx; j < idx + text.length; j++) {
        a.add(t[j]);
      }
      l.add(TextSpan(
        text: a.join(''),
        style: const TextStyle(
          fontFamily: 'Exo2.0',
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
          color: Color.fromRGBO(45, 58, 82, 1),
        ),
      ));
      a.clear();
      for (int j = idx + text.length; j < t.length; j++) {
        a.add(t[j]);
      }
      l.add(TextSpan(
        text: a.join(''),
        style: const TextStyle(
          fontFamily: 'Exo2.0',
          fontWeight: FontWeight.w400,
          fontSize: 15.0,
          color: Color.fromRGBO(45, 58, 82, .3),
        ),
      ));
    }
    return l;
  }

  Widget listBuilder(ScrollController scrollController, List<String> entries, String text) {
    var o = entries;
    if (text.isNotEmpty) {
      o = search(text, entries);
    }
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      itemCount: o.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: (text.isNotEmpty)
                ? RichText(
                text: TextSpan(children: textBuilder(o[index], text)))
                : TextView(
              text: o[index],
              fs: 15.0,
              fw: FontWeight.w600,
            ),
            contentPadding: const EdgeInsets.all(0.0),
            onTap: () {
              switch(order) {
                case 1: {
                  var croco = Getters.getCreateOrder().values.first;
                  Update.editCreateOrder(croco, from: res[index]);
                  break;
                }
                case 2: {
                  var croco = Getters.getCreateOrder().values.first;
                  Update.editCreateOrder(croco, to: res[index]);
                  break;
                }
                default: {
                  break;
                }
              }
              Navigator.pop(context, o[index]);
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          child: Container(
            color: const Color(0xFFE2E5EA),
            width: double.infinity,
            height: 1,
          ),
        );
      },
    );
  }

  Widget headerBuilder(bool state, BuildContext context) {
    if (state) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: ListTile(
            leading: const Icon(
              CustomIcons.close,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            title: const TextView(
              text: 'Выбрать улицу',
              fw: FontWeight.w800,
              fs: 17.0,
            ),
            contentPadding: const EdgeInsets.all(0.0),
          ),
        ),
        SizedBox(
          child: Container(
            color: const Color(0xFFE2E5EA),
            width: double.infinity,
            height: 1,
          ),
        ),
      ]);
    } else {
      return const SizedBox();
    }
  }
}

class DModalStreetButton extends StatelessWidget {
  const DModalStreetButton({
    Key? key,
    required this.controller,
    this.label = 'Улица',
    this.isError = false,
    this.order = 0,
    this.onChanged,
    required this.city
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final int order;
  final String city;
  final bool isError;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DTextDropdown(
        controller: controller,
        label: label,
        isError: isError,
        onChanged: onChanged,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => DModalStreet(order: order, city: city,)).then((value) {
          (value != null) ? controller.text = value : controller.text = '';
        });
      },
    );
  }
}

class GeneralBottomModalButton extends StatelessWidget {
  const GeneralBottomModalButton({
    Key? key,
    required this.controller,
    this.isError = false,
    this.onChanged,
    this.label = 'Габариты',
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool isError;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DTextDropdown(
        controller: controller,
        label: label,
        isError: isError,
        onChanged: onChanged,
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const GeneralBottomModal(),
        ).then((value) {
          (value != null) ? controller.text = value : controller.text = '';
        });
      },
    );
  }
}

class CargoItem {
  String name;
  double height;
  double width;
  double length;
  double weigh;
  Image logo;

  CargoItem(
      {this.name = "",
      this.height = 0.0,
      this.width = 0.0,
      this.length = 0.0,
      this.weigh = 0.0,
      this.logo = const Image(image: AssetImage('images/letter.png'))});
}

class GeneralBottomModal extends StatelessWidget {
  const GeneralBottomModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CargoItem> list = [
      CargoItem(
          name: 'Документы',
          height: 22.0,
          width: 1,
          length: 30.0,
          weigh: 0.2,
          logo: const Image(image: AssetImage('images/letter.png'))),
      CargoItem(
          name: 'Как коробка от смартфона',
          height: 12.0,
          width: 9.0,
          length: 17.0,
          weigh: 1.0,
          logo: const Image(image: AssetImage('images/phone_box.png'))),
      CargoItem(
          name: 'Как коробка от утюга',
          height: 12.0,
          width: 9.0,
          length: 17.0,
          weigh: 1.0,
          logo: const Image(image: AssetImage('images/iron_box.png'))),
      CargoItem(
          name: 'Как коробка от обуви',
          height: 25.0,
          width: 15.0,
          length: 33.0,
          weigh: 7.0,
          logo: const Image(image: AssetImage('images/shoe_box.png'))),
      CargoItem(
          name: 'Как коробка от микроволновки',
          height: 35.0,
          width: 30.0,
          length: 42.0,
          weigh: 15.0,
          logo: const Image(image: AssetImage('images/microwave_box.png'))),
    ];
    return Container(
      color: Colors.white,
      height: 532.0,
      child: Column(
        children: [
          Container(
            color: const Color(0xFF737373),
            height: 36.0,
            width: double.infinity,
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: CupertinoColors.white,
                ),
                child: Center(
                  child: Container(
                    width: 30.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3.0),
                      color: const Color(0xffe4e4e4),
                    ),
                  ),
                )),
          ),
          Expanded(
              child: ListView.separated(
            itemCount: list.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: list[index].logo,
                title: TextView(
                  text: list[index].name,
                  fs: 15.0,
                ),
                subtitle: TextView(
                  text: 'Размеры: ${prettify(list[index].length)}'
                      'x${prettify(list[index].height)}'
                      'x${prettify(list[index].width)}см '
                      'Вес: - ${prettify(list[index].weigh)}кг',
                  fs: 15.0,
                  color: const Color.fromRGBO(45, 58, 82, .5),
                ),
                onTap: () {
                  Navigator.pop(
                      context,
                      '${prettify(list[index].length)}'
                      'x${prettify(list[index].height)}'
                      'x${prettify(list[index].width)}см '
                      'Вес: - ${prettify(list[index].weigh)}кг');
                },
              );
            },
          )),
          SizedBox(
            child: Container(
              color: const Color(0xFFE2E5EA),
              width: double.infinity,
              height: 1,
            ),
          ),
          ListTile(
              title: const Center(
                child: TextView(
                  text: 'Выберу самостоятельно',
                  fs: 15.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7.0),
              onTap: () {
                Navigator.of(context)
                    .push(BoxSize.route())
                    .then((value) => {Navigator.pop(context, value)});
              }),
        ],
      ),
    );
  }

  String prettify(double d) =>
      d.toStringAsFixed(1).replaceFirst(RegExp(r'\.?0*$'), '');
}
