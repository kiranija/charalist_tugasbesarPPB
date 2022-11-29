import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 161, 127, 206),
        title: const Text('My Profile'),
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
                    'res/gambar.jpeg',
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
                          title: Text('Kirani Juli Andini'),
                          subtitle: Text('21120120120033'),
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(255, 161, 127, 206),
                        child: ListTile(
                          title: Text('Teknik Komputer 2020'),
                          subtitle: Text('Universitas Diponegoro'),
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
