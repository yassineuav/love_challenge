import 'package:app/constants/constants.dart';
import 'package:app/theme/pallet.dart';
import 'package:app/tweet/create_tweet_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final appBar = UIConstants.appBar();
  int _page = 0;

  void onPageChange(int index){
    setState(() {
      _page = index;
    });
  }

  void onCreateTweet(){
    Navigator.push(context, CreateTweetScreen.route());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweet,
        child: const Icon(Icons.add, color: Pallet.whiteColor, size: 30,),

      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallet.backgroundNavigationBarColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                _page == 0 ?
                AssetsConstants.homeFilledIcon :
                AssetsConstants.homeOutlinedIcon,
                color: Pallet.whiteColor),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsConstants.searchIcon,
                color: Pallet.whiteColor),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                _page == 2 ?
                AssetsConstants.notifFilledIcon:
                AssetsConstants.notifOutlinedIcon,
                color: Pallet.whiteColor),
          ),
        ],
      ),
    );
  }
}
