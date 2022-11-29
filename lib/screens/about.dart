import 'package:flutter/material.dart';
import 'home.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 161, 127, 206),
        title: const Text('About app'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 80,
            ),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'res/CHARA.png',
                    width: 240,
                    height: 240,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const Card(
                        color: Color.fromARGB(255, 161, 127, 206),
                        child: ListTile(
                          title: Text('CharaList is an application that is used to get information about the anime that is currently airing along with several episodes and detailed anime information, that we can receive '),
                          subtitle: Text('This Application is made to fulfill the final project of PPB Practicum'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

