import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/book.dart';

class DetailPage extends StatelessWidget {
  final Book book;
  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: Image.asset(
                  book.image,
                  width: 120,
                ),
              )
            ),
          ),

          // JUDUL BUKU
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                book.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          // INFO BUKU
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bookInfo(book.rate.toString(), "Rating"),
              bookInfo(book.page.toString(), "Page"),
              bookInfo(book.language, "Language"),
            ],
          ),
          // DESKRIPSI BUKU
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: bookDescription(book.description),
          ),
        ],
      ),
    );
  }

  Widget bookInfo(String value, String info) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          info,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget bookDescription(String description) {
    return Column(
      children: [
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal
          ),
        ),
      ],
    );
  }

}