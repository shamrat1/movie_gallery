import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_gallery/models/home_response.dart';
import 'package:movie_gallery/repo/movie_repo.dart';
import 'package:movie_gallery/screens/home.dart';
import 'package:movie_gallery/screens/movie_details.dart';
import 'package:movie_gallery/utils/storage/shared_prefs.dart';
import 'package:movie_gallery/utils/theme/theme.dart';

import 'utils/constants/colors.dart';
import 'utils/constants/sizes.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _authenticated = false;

  @override
  void initState() {
    super.initState();
    // SharedPrefs.getBool("authenticated").then((val) {
    //   setState(() {
    //     _authenticated = val;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 801),
        splitScreenMode: false,
        minTextAdapt: true,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movie Gallery',
            theme: TAppTheme.lightTheme,
            // home: _authenticated ? const LandingPage() : const SigninPage(),
            home: const LandingPage(),
          );
        },
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFF679B),
                      Color(0xffFF7B51),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: TSizes.iconMd,
                ),
              ),
            )
          : null,
      body: PageView(
        controller: _pageController,
        onPageChanged: (val) => setState(() {
          _currentPage = val;
        }),
        children: const [
          HomePage(),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: TSizes.iconMd,
        icons: const [
          Icons.home_rounded,
          Icons.person,
        ],
        activeIndex: _currentPage,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        activeColor: TColors.primary,
        inactiveColor: TColors.darkGrey,
        onTap: (index) {
          setState(() {
            _currentPage = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          });
        },
      ),
    );
  }
}
