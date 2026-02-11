import 'package:evently_assignment/providers/theme_provider.dart';
import 'package:evently_assignment/ui/utils/app_assets.dart';
import 'package:evently_assignment/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // themeProv.isDark()? : ,
    final themeProv = Provider.of<ThemeProvider>(context, listen: false);
    final List<Map<String, String>> data = [
      {
        "image": themeProv.isDark() ? AppAssets.one : AppAssets.onBoardingOne,
        "title": "Find Events That Inspire You",
        "desc":
        "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
      },
      {
        "image": themeProv.isDark() ? AppAssets.two: AppAssets.onBoardingTwo,
        "title": "Effortless Event Planning",
        "desc":
        "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
      },
      {
        "image": themeProv.isDark() ? AppAssets.three: AppAssets.onBoardingThree,
        "title": "Connect with Friends & Share Moments",
        "desc":
        "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
      },
    ];

  return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(AppAssets.logo, width: 200, height: 200)],
        ),
        actions: [
          if (currentIndex != data.length - 1)
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "LoginScreen");
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                  color: Theme.of(context).cardColor,
                ),
                child: Text(
                  "Skip",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
        ],
        leading: currentIndex > 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex--;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              )
            : SizedBox(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    data[currentIndex]["image"]!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  data.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: currentIndex == index ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                data[currentIndex]["title"]!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                ),
              ),

              SizedBox(height: 12),

              Text(
                data[currentIndex]["desc"]!,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (currentIndex < data.length - 1) {
                      setState(() => currentIndex++);
                    } else {
                      Navigator.pushNamed(context, "LoginScreen");
                    }
                  },
                  child: Text(
                    currentIndex == data.length - 1 ? "Get started" : "Next",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
