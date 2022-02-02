import 'package:flutter/material.dart';
import 'package:very_good_adventures/game/game.dart';

class TitleView extends StatelessWidget {
  const TitleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Hero(
                tag: 'logo',
                child: Image.asset('assets/images/title.png'),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  VeryGoodAdventuresPage.route(),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Play!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
