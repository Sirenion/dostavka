import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Этапы
class DStep extends StatelessWidget {
  const DStep({Key? key,
    required this.state,
    required this.value
  }) : super(key: key);

  final int state;
  final int value;

  /*
   int state (0 - неактивный,1 - активный прошлый,2 - активный на данный момент)
   int value (1,2,3)
  */

  @override
  Widget build(BuildContext context) {
    Color colorCircle;
    Color colorCircleText;
    Color colorText;
    String text;


    switch(state){
      case 0:
        {
          colorCircle = const Color(0xFFE2E5EA);
          colorCircleText = const Color.fromRGBO(45, 58, 82, .5);
          colorText = const Color.fromRGBO(45, 58, 82, .5);
          break;
        }
      case 1:
        {
          colorCircle = const Color(0xFFE2E5EA);
          colorCircleText = const Color(0xFF2D3A52);
          colorText = const Color(0xFF2D3A52);
          break;
        }
      case 2:
        {
          colorCircle = const Color(0xFF2D3A52);
          colorCircleText = const Color(0xFFFFFFFF);
          colorText = const Color(0xFF2D3A52);
          break;
        }
      default:
        {
          colorCircle = const Color(0xFFE2E5EA);
          colorCircleText = const Color.fromRGBO(45, 58, 82, .5);
          colorText = const Color.fromRGBO(45, 58, 82, .5);
          break;
        }
    }

    switch(value){
      case 1:
        {
          text = 'Посылка';
          break;
        }
      case 2:
        {
          text = 'Варианты';
          break;
        }
      case 3:
        {
          text = 'Отправка';
          break;
        }
      default:
        {
          text = 'Посылка';
          break;
        }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorCircle,
          ),
          child: Center(
              child: TextView(
                text: '$value',
                fs: 13.0,
                color: colorCircleText,
              )),
        ),
        TextView(
          text: text,
          fs: 13.0,
          color: colorText
        )
      ],
    );
  }
}
