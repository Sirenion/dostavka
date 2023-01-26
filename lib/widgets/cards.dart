import 'package:dostavka/screens/webview/webview.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';


class DCardSending extends StatelessWidget {
  const DCardSending({Key? key,
    required this.id,
    required this.title,
    required this.name,
    required this.status}) : super(key: key);

  final String id;
  final String title;
  final String name;
  final String status;

  @override
  Widget build(BuildContext context) {
    final s = getStatus(1, status);
    final ss = 1;
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: const Color(0xFFF6F7F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(text: id, fs: 13.0, fw: FontWeight.w600),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                  child: TextView(
                      text: title,
                      fw: FontWeight.w800
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                  child: TextView(
                      text: name,
                      color: const Color.fromRGBO(45, 58, 82, .5),
                      fs: 13.0,
                      fw: FontWeight.w600
                  ),
                ),
                if (ss != 0 && ss < 5) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    child: TextView(
                        text: s.item1,
                        color: s.item2,
                        fs: 13.0,
                        fw: FontWeight.w600
                    ),
                  ),
                ]
              ]
          ),
        ),
      ),
    );
  }
}

class DCardNotification extends StatelessWidget {
  const DCardNotification({Key? key,
    required this.id,
    required this.status,
    required this.date,
    this.payment = false,
    this.price = '0',
  }) : super(key: key);

  final String id;
  final int status;
  final String date;
  final bool payment;
  final String price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.all(0.0),
        color: const Color(0xFFF6F7F9),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewNotification(id: id, status: status),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                  child: TextView(
                      text: date,
                      color: const Color.fromRGBO(45, 58, 82, .5),
                      fs: 15.0,
                      fw: FontWeight.w400
                  ),
                ),
                if (payment) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    child: PayButton(price: price)
                  ),
                ]
              ]
          ),
        ),
      ),
    );
  }
}

class DCardMap extends StatelessWidget {
  const DCardMap({Key? key,
    required this.address,
    required this.range,
    this.selected = false,
  }) : super(key: key);

  final String address;
  final int range;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    String rText;
    switch(range) {
      case 0: {
        rText = "до 200 метров";
        break;
      }
      case 1: {
        rText = "до 500 метров";
        break;
      }
      case 2: {
        rText = "до 1 км";
        break;
      }
      case 3: {
        rText = "до 2 км";
        break;
      }
      case 4: {
        rText = "до 5 км";
        break;
      }
      case 5: {
        rText = "до 10 км";
        break;
      }
      case 6: {
        rText = "до 20 км";
        break;
      }
      case 7: {
        rText = "свыше 20 км";
        break;
      }
      default:
        rText = "недалеко";
        break;
    }
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: selected ? const Color(0xFFF0674C) : Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        color: const Color(0xFFF6F7F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                  child: TextView(
                      text: address,
                      fs: 15.0,
                      fw: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Exo2.0',
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                          color: Color(0xFF2D3A52),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: rText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFF0674C),
                            ),
                          ),
                          const TextSpan(
                            text: ' от получателя',
                          ),
                        ]
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}


class PayButton extends StatelessWidget {
  const PayButton({Key? key, required this.price}) : super(key: key);

  final String price;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WebViewApp(),
        ),
      ),
      color: Colors.transparent,
      minSize: 19.0,
      padding: const EdgeInsets.all(0.0),
      disabledColor: CupertinoColors.quaternarySystemFill,
      pressedOpacity: 0.5,
      child: RichText(
        text: TextSpan(
            style: const TextStyle(
              fontFamily: 'Exo2.0',
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
              color: Color(0xFFF0674C),
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Оплатить ' + price,
              ),
              const TextSpan(
                text: ' ₽',
                style: TextStyle(
                  fontFamily: '',
                ),
              ),
            ]
        ),
      ),
    );
  }
}

class DCardDelivery extends StatelessWidget {
  const DCardDelivery({
    Key? key,
    required this.name,
    required this.cost,
    required this.days,
    required this.logo,
    this.selected = false
  }) : super(key: key);

  final String name;
  final String cost;
  final int days;
  final String logo;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    String day;

    if (days % 10 >= 2 && days % 10 <= 4) {
      day = '$days дня';
    } else if ((days % 10 >= 5 && days % 10 <= 9) ||
        days % 10 == 0 ||
        (days % 100 >= 11 && days % 100 <= 19)) {
      day = '$days дней';
    } else {
      day = '$days день';
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: selected ? const Color(0xffF0674C) : Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: const Color(0xFFF6F7F9),
        child: Container(
          margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20.0),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 38.0,
                  child: Image.network('https://testarea.dostavka.info/static/$logo', fit: BoxFit.contain),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: name,
                      fw: FontWeight.w600,
                      fs: 17,
                    ),
                    TextView(text: day)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [TextViewRuble(
                        price: cost,
                      fs: 17,
                      fw: FontWeight.w600,
                      color: const Color(0xffF0674C),
                    )],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

Tuple2<String,Color> getStatus(int s, String stat) {
  String sText = 'Обрабатывается';
  Color sColor = const Color(0xFFFFA24C);
  switch (s) {
    case 1:
      {
        sText = stat;
        sColor = const Color(0xFF1EC15F);
        break;
      }
    case 2:
      {
        sText = stat;
        sColor = const Color(0xFFFFA24C);
        break;
      }
    case 3:
      {
        sText = stat;
        sColor = const Color(0xFF1999E1);
        break;
      }
    case 4:
      {
        sText = stat;
        sColor = const Color(0xFF7B61FF);
        break;
      }
    default:
      break;
  }
  return Tuple2<String, Color>(sText, sColor);
}


