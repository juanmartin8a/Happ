import 'package:flutter/material.dart';
import 'package:happ_client/src/screens/search/searchBar.dart';
import 'package:happ_client/src/screens/search/searchResults.dart';

// class Search extends StatefulWidget {
//   const Search({Key? key}) : super(key: key);

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
// //   @override
//   Widget build(BuildContext context) {
    
//   }
// }

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).padding.top;
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.white.withOpacity(1.0),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(height: statusBar),
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