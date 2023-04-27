import 'package:flutter/material.dart';
import 'package:happ_client/src/screens/search/searchBar.dart';
import 'package:happ_client/src/screens/search/searchResults.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).padding.top;
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.white.withOpacity(1.0),
        // padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(height: statusBar),
            // Container(
            //   height: 20,
            //   // padding: EdgeInsets.only(top: statusBar),
            //   child: Center(
            //     // alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Search for users",
            //       style: TextStyle(
            //         // fontFamily: "Roboto",
            //         // fontStyle: FontStyle.,
            //         color: Colors.grey[800],
            //         fontSize: 15,
            //         fontWeight: FontWeight.w700,
            //         height: 1
            //       )
            //     ),
            //   )
            // ),
            const SearchBar(),
            const Expanded(
              child: SearchResults()
            )
          ],
        )
      )
    );
  }
}