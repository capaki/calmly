import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class meditationSession extends StatelessWidget {
  final int sessionNum;
  final String sessionTitle;
  final VoidCallback press;
  final ValueChanged<int> sessionClicked;
  final bool isPlaying;
  const meditationSession({
    Key? key,
    required this.sessionNum,
    required this.sessionTitle,
    required this.press,
    required this.sessionClicked,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        //padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 23,
              spreadRadius: -20,
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              press();
              sessionClicked(sessionNum);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 42,
                    width: 43,
                    decoration: BoxDecoration(
                      color: isPlaying ? Colors.white : kBlueColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: kBlueColor),
                    ),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: isPlaying ? kBlueColor : Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "session $sessionNum - $sessionTitle",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                          fontSize: 20,
                          color: kBlackColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
