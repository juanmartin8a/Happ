import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top
          ),
          Container(
            height: 45,
            // color: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Juan's Birthday",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                        height: 1
                      )
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "thursday 28 of october, 2022",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        height: 1
                      )
                    ),
                  ],
                )
              ],
            )
          ),
          Expanded(
            // padding: EdgeInsets.symmetric(horizontal:8),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Container(
                  //   padding: const EdgeInsets.only(left:8, right: 8),
                  //   child: Text(
                  //     "birthdat party for Juan :0!! bring snacks and beberages",
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.grey[800],
                  //       // height: 1
                  //     )
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal:8),
                    // height: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                      aspectRatio: 4/3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Image.asset('assets/images/image2.jpeg', fit: BoxFit.cover)
                        ),
                      )
                    )
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 7,
                        width: 7,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle
                        )
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 7,
                        width: 7,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle
                        )
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 7,
                        width: 7,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "Birthday party at My place all of my friends and family are invited, it will be really cool",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                        // height: 1.1
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(30),
                  //   child: Container(
                  //     margin: EdgeInsets.symmetric(horizontal: 8),
                  //     padding: EdgeInsets.symmetric(vertical: 8),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[300],
                  //       borderRadius: BorderRadius.circular(30)
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //          Container(
                  //             padding: const EdgeInsets.only(left: 16, top: 4),
                  //             child: Text(
                  //               "Location",
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w700,
                  //                 color: Colors.grey[800],
                  //                 height: 1
                  //               )
                  //             ),
                  //           ),
                  //           const SizedBox(height: 4),
                  //           Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             padding: const EdgeInsets.symmetric(horizontal:8),
                  //             // height: MediaQuery.of(context).size.width,
                  //             child: AspectRatio(
                  //               aspectRatio: 16 / 9,
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(20),
                  //                 child: Container(
                  //                   decoration: const BoxDecoration(
                  //                     color: Colors.grey,
                  //                     // borderRadius: BorderRadius.circular(20)
                  //                   ),
                  //                   child: Image.asset('assets/images/image1.png', fit: BoxFit.cover)
                  //                 ),
                  //               )
                  //             )
                  //           ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                        height: 1
                      )
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal:8),
                    // height: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Image.asset('assets/images/image1.png', fit: BoxFit.cover)
                        ),
                      )
                    )
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "Organizers",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                        height: 1
                      )
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 90,
                          // color: Colors.red,
                          child: Stack(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                  color: Colors.grey
                                ),
                              ),
                              Positioned(
                                left: 25,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 4),
                                    color: Colors.grey
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 50,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 4),
                                    color: Colors.grey
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "+ 5 More",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                            height: 1
                          )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "Friends Coming",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                        height: 1
                      )
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              child: Text(
                                "Juan Martin",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                  height: 1
                                )
                              )
                            )
                          ],
                        )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              child: Text(
                                "Juan Martin",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                  height: 1
                                )
                              )
                            )
                          ],
                        )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              child: Text(
                                "Juan Martin",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                  height: 1
                                )
                              )
                            )
                          ],
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 100)
                ],
              ),
            )
          )
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.3,
          //   width: MediaQuery.of(context).size.width,
          //   // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Stack(
          //     children:  [
          //       // Container(
          //       //   height: MediaQuery.of(context).size.height * 0.12,
          //       //   decoration: BoxDecoration(
          //       //     gradient: LinearGradient(
          //       //       colors: [Colors.black.withOpacity(0.4), Colors.transparent],
          //       //       begin: Alignment.topCenter,
          //       //       end: Alignment.bottomCenter
          //       //     )
          //       //   ),
          //       // ),
          //       Container(
                  
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //             left: 12, 
          //             right: 12,
          //             // top: MediaQuery.of(context).padding.top,
          //           ),
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //             decoration: BoxDecoration(
          //               color: Colors.black.withOpacity(0.3),
          //               // shape: BoxShape.circle,
          //               borderRadius: BorderRadius.circular(30)
          //             ),
          //             child: const Text(
          //               "Event Name",
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.w700,
          //                 color: Colors.white,
          //                 // height: 1
          //               )
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ) 
          // ),
          // Expanded(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     // height: double.infinity,
          //     // color: Colors.grey,
          //     padding: EdgeInsets.symmetric(horizontal: 8),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const SizedBox(height: 4),
          //         Text(
          //           "October 28, 2022",
          //           style: TextStyle(
          //             color: Colors.grey[800],
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             height: 1,
          //           )
          //         ),
          //         const SizedBox(height: 8),
          //         Text(
          //           "Description...",
          //           style: TextStyle(
          //             color: Colors.grey[800],
          //             fontSize: 15,
          //             fontWeight: FontWeight.w600,
          //             height: 1,
          //           )
          //         ),
          //       ],
          //     ),
          //   )
          // )
        ],
      )
    );
  }
}