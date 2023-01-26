import 'package:dostavka/widgets/navbar.dart';
import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';

class Tracking extends StatelessWidget {
  const Tracking({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const Tracking());
  }

  @override
  Widget build(BuildContext context) {
    List<String> tracks = [
      'Принят (офис СДЭК)',
      'Создан (офис СДЭК)',
      'Отправлен в пункт назначения'
    ];
    return Scaffold(
      appBar: const Navbar(
        title: 'Отслеживание',
        buttonLeft: 0,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
          itemCount: tracks.length,
          itemBuilder: (BuildContext context, int index) {
            return TrackTile(
                track: Track(
                    data: tracks[index],
                    isLast: (index == (tracks.length - 1))
                )
            );
          }
      ),
    );
  }
}

class Track {
  final String data;
  final String date;
  final bool isLast;

  Track({required this.data, required this.isLast, this.date = '14 сентября 14:30'});
}

class TrackTile extends StatelessWidget {
  const TrackTile({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 61,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 13,
                  width: 13,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                          width: 2,
                          color: !track.isLast
                              ? const Color.fromRGBO(45, 58, 82, .5)
                              : const Color(0xffF0674C))),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                if (!track.isLast)
                  Container(
                      height: 38,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(1)),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(45, 58, 82, .5))
                      )
                  )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: track.data,
                fs: 17,
                color: !track.isLast
                    ? const Color(0xFF2D3A52)
                    : const Color(0xffF0674C),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextView(
                text: track.date,
                fs: 13,
                color: const Color.fromRGBO(45, 58, 82, .5),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
            ],
          )
        ],
      ),
    );
  }
}
