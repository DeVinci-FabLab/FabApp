import 'package:fabapp/pages/auth/sign_up.dart';
import 'package:flutter/material.dart';

import 'package:fabapp/pages/auth/partners.dart';
import 'package:fabapp/pages/auth/sign_in.dart';
import 'package:fabapp/constants/consts.dart';
import 'package:fabapp/pages/auth/logohome.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const LogoHome(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    height: 380,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Constants.devinciColorLigth,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: TabBar(
                                  unselectedLabelColor: Colors.white,
                                  labelColor: Colors.black,
                                  indicatorColor: Colors.white,
                                  indicatorWeight: 2,
                                  indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  controller: tabController,
                                  tabs: const [
                                    Tab(
                                      text: 'Connexion',
                                      height: 30,
                                    ),
                                    Tab(
                                      text: 'Inscription',
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              const SignInFields(),
                              SignUpFields(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Partners(),
            ],
          ),
        ),
      ),
    );
  }
}
