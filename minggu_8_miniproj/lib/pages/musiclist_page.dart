import 'package:flutter/material.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key});

  @override
  State<MusicListPage> createState() => MusicListPageState();
}

class MusicListPageState extends State<MusicListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                      'Music List',
                      style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.w500)
                      ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/play');
                    },
                    leading: Image.network(
                      'https://upload.wikimedia.org/wikipedia/en/f/f6/Juice_Wrld_-_Legends_Never_Die.png',
                      height: 48,
                    ),
                    title: const Text(
                      'Wishing Well',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text(
                      'Juice',
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }
              )
                    
            ],
          ),
        ),
      ),
    );
  }
}