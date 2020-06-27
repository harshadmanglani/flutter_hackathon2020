import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter95/flutter95.dart';

//categories of the retro quizzes

class PastHome extends StatefulWidget {
  @override
  _PastHomeState createState() => _PastHomeState();
}

class _PastHomeState extends State<PastHome> {
  dynamic fontStyle = GoogleFonts.galada(textStyle: TextStyle(fontSize: 35.0));
  dynamic retroFont =
      GoogleFonts.ibmPlexMono(textStyle: TextStyle(fontSize: 20.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold95(
        title: "The Past",
        toolbar: Toolbar95(actions: [
          Item95(
            label: 'Leaderboard',
            onTap: (context) {
              Navigator.pushNamed(context, '/leaderboard');
            },
          ),
          Item95(
            label: '',
          ),
          Item95(
            label: 'Quizzes',
            menu: _buildMenu(context),
          ),
          Item95(
            label: '',
          ),
          Item95(
            label: 'Facts',
            onTap: (context) {},
          ),
        ]),
        body: retroBody());
  }
}

Widget retroBody() {
  return Container(
    child: Column(
      children: <Widget>[],
    ),
  );
}

Menu95 _buildMenu(BuildContext context) {
  return Menu95(
    items: [
      MenuItem95(
        value: 1,
        label: 'Tech',
      ),
      MenuItem95(
        value: 2,
        label: 'Cars',
      ),
    ],
    onItemSelected: (item) {
      if (item == 1) {
        Navigator.pushNamed(context, '/retrotech');
      } else if (item == 2) {
        Navigator.pushNamed(context, '/retrocars');
      }
    },
  );
}

// skeletons

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RetroTech extends StatefulWidget {
  @override
  _RetroTechState createState() => _RetroTechState();
}

class _RetroTechState extends State<RetroTech> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RetroCars extends StatefulWidget {
  @override
  _RetroCarsState createState() => _RetroCarsState();
}

class _RetroCarsState extends State<RetroCars> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// expired code

// Container(
//   child: Column(
//     children: <Widget>[
//       CustomButton(
//         fontSizeForText: 20.0,
//         routeName: '/leaderboard',
//         text: 'LEADERBOARD',
//         originalContext: context,
//       ),

// ExpansionTile(
//     initiallyExpanded: true,
//     title: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         new Expanded(child: Text('QUIZZES', style: retroFont)),
//       ],
//     ),
//     children: <Widget>[
//       CustomButton(
//         routeName: '/retrotech',
//         text: 'Tech',
//         originalContext: context,
// )
// ]),
// ],
// ),
// ),
