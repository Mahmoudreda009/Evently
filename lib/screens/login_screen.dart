import 'package:evently_assignment/ui/utils/app_assets.dart' show AppAssets;
import 'package:evently_assignment/ui/utils/app_colors.dart';
import 'package:evently_assignment/ui/utils/app_styles.dart';
import 'package:evently_assignment/widgets/app_text_field.dart';
import 'package:evently_assignment/widgets/evently_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../google_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(AppAssets.logo, height: 100, width: 200),
              ),
              SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              AppTextField(
                hint: "Enter your email",
                prefixIcon: SvgPicture.asset(AppAssets.emailIcon),
              ),
              SizedBox(height: 16),
              AppTextField(
                hint: "Enter your password",
                prefixIcon: SvgPicture.asset(AppAssets.lockIcon),

                suffixIcon: SvgPicture.asset(AppAssets.eyeSlash),
              ),
              SizedBox(height: 8),
              Text(
                "Forget Password?",
                textAlign: TextAlign.end,
                style: AppTextStyles.blue14SemiBold.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 45),
              EventlyButton(text: "Login", onPress: () {}),
              SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account ?",
                    style: AppTextStyles.grey14Regular,
                  ),
                  Text(
                    "Signup ?",
                    style: AppTextStyles.blue14SemiBold.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("or", style: AppTextStyles.blue14SemiBold)],
              ),
              SizedBox(height: 45),
              EventlyButton(
                text: "Login with Google",
                onPress: () async {
                  try {
                    final userCredential = await signInWithGoogle();

                    print("userCredential == $userCredential");
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, 'HomeScreen');
                    }
                  } catch (e) {
                    print("Google Login Error: $e");
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => HomeScreen(),
                  //     ),
                  // );
                },
                textStyle:TextTheme.of(context).bodyMedium!.copyWith(color: Colors.white),
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(AppAssets.gmailIcon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
