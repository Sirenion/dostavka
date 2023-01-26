import 'package:dostavka/widgets/buttons.dart';
import 'package:dostavka/widgets/cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({Key? key,
    required this.text,
    this.color = const Color(0xFF2D3A52),
    this.fs = 15.0,
    this.fw = FontWeight.w400
  }) : super(key: key);

  final String text;
  final Color color;
  final double fs;
  final FontWeight fw;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Exo2.0',
        fontWeight: fw,
        fontSize: fs,
        color: color,
        decoration: TextDecoration.none
      ),
    );
  }
}

class TextViewNotification extends StatelessWidget {
  const TextViewNotification({Key? key,
    required this.id,
    required this.status
  }) : super(key: key);

  final String id;
  final int status;
  @override
  Widget build(BuildContext context) {
    final s = getStatus(status, "");
    return RichText(
       text: TextSpan(
         style: const TextStyle(
            fontFamily: 'Exo2.0',
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
            color: Color(0xFF2D3A52),
         ),
         children: <TextSpan>[
            const TextSpan(text: 'Отправление '),
           TextSpan(
             text: id,
             style: const TextStyle(
                 fontWeight: FontWeight.w600
             ),
           ),
           const TextSpan(
             text: ' теперь имеет статус ',
           ),
           TextSpan(
             text: '«' + s.item1 + '»',
             style: TextStyle(
                 fontWeight: FontWeight.w600,
                 color: s.item2,
             ),
           ),
         ]
       ),
    );
  }
}

class TextViewRuble extends StatelessWidget {
  const TextViewRuble({Key? key,
    required this.price,
    this.color = const Color(0xFFF0674C),
    this.fs = 15.0,
    this.fw = FontWeight.w400

  }) : super(key: key);

  final String price;
  final Color color;
  final double fs;
  final FontWeight fw;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            fontFamily: 'Exo2.0',
            fontWeight: fw,
            fontSize: fs,
            color: color,
          ),
          children: <TextSpan>[
            TextSpan(text: price),
            const TextSpan(
              text: ' ₽',
              style: TextStyle(
                fontFamily: '',
              ),
            ),
          ]
      ),
    );
  }
}

class TextViewField extends StatelessWidget {
  const TextViewField({Key? key,
        required this.name,
        required this.info,
        this.isPrice = false,
        this.showOnMap = false,
        this.actionOnMap,
      }) : super(key: key);

  final String name;
  final String info;
  final bool isPrice;
  final bool showOnMap;
  final VoidCallback? actionOnMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFFE2E5EA)),
          )
      ),
      padding: const EdgeInsets.symmetric(vertical: 17.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: TextView(
              text: name,
              color: const Color.fromRGBO(45, 58, 82, .5),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isPrice) ...[
                  TextViewRuble(
                      price: info,
                      fs: 15,
                      fw: FontWeight.w600,
                      color: const Color.fromRGBO(45, 58, 82, 1),
                  ),
                ] else ...[
                  TextView(
                    text: info,
                    fw: FontWeight.w600,
                  ),
                ],
                if (showOnMap) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DTextButton(
                      text: 'Показать на карте',
                      onPressed: actionOnMap,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextViewFieldSecondary extends StatelessWidget {
  const TextViewFieldSecondary(
      {Key? key,
        required this.text
      }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFFE2E5EA)),
          )
      ),
      padding: const EdgeInsets.symmetric(vertical: 17.0),
      child: TextView(
        text: text,
        fw: FontWeight.w600,
      ),
    );
  }
}



