import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String content;
  final String data;
  final String? image;
  const ListItem(
      {super.key,
      required this.firstname,
      required this.lastname,
      required this.content,
      required this.data,
      this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: image != null
                        ? Image.network(
                            image!,
                            height: 180,
                            width: 350,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/placeholder1.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress != null
                                  ? const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : child;
                            },
                          )
                        : Image.asset(
                            'assets/images/placeholder1.jpg',
                            fit: BoxFit.fill,
                            height: 180,
                            width: 350,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      firstname,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      lastname,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Icon(CupertinoIcons.delete)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  data,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  content,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    //   child: Container(
    //     color: Colors.amber,
    //     width: double.infinity,
    //     height: 200,
    //     child: Column(
    //       // crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         image != null
    //             ? Image.network(
    //                 image!,
    //                 height: 100,
    //                 width: 100,
    //                 fit: BoxFit.cover,
    //                 errorBuilder: (context, error, stackTrace) {
    //                   return Image.asset(
    //                     "assets/images/placeholder1.jpg",
    //                     height: 100,
    //                     width: 100,
    //                     fit: BoxFit.cover,
    //                   );
    //                 },
    //                 loadingBuilder: (context, child, loadingProgress) {
    //                   return loadingProgress != null
    //                       ? const Center(
    //                           child: CircularProgressIndicator.adaptive(),
    //                         )
    //                       : child;
    //                 },
    //               )
    //             : Image.asset(
    //                 'assets/images/placeholder1.jpg',
    //                 fit: BoxFit.fill,
    //                 height: 100,
    //                 width: double.infinity,
    //               ),
    //         Row(
    //           children: [
    //             Text(firstname, style: const TextStyle(fontSize: 18)),
    //             const SizedBox(width: 5),
    //             Text(lastname, style: const TextStyle(fontSize: 18)),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );