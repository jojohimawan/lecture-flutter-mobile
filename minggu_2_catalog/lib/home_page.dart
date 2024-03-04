import 'package:flutter/material.dart';
import 'package:flutter_application_1/book.dart';
import 'package:flutter_application_1/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Let's Learn\nand make your app",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ), 
                  ),
                  Image.asset(
                    "images/banner.png",
                    width: 100,
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Books",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                itemCount: listBook.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final book = listBook[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => DetailPage(book: book),
                        ),
                      );
                    },
                    child: 
                      Container(
                        width: double.infinity,
                        height: 90,
                        padding: EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6.0,
                              offset: Offset(0, 1),
                            )
                          ]
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              book.image,
                              width: 64,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(book.name),
                                Text(book.categoryBook)
                              ],
                            )
                          ],
                        ),
                      ),
                  );
                },
                
              )
            ],
          ),
        )
      ),
    );
  }
}