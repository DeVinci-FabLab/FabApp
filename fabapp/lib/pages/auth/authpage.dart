import 'package:flutter/material.dart';

import 'package:fabapp/pages/auth/partners.dart';
import 'package:fabapp/pages/auth/sign_in.dart';
import 'package:fabapp/constants/consts.dart';
import 'package:fabapp/pages/auth/logohome.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              LogoHome(),
              SignInUpMenu(),
              Partners(),
            ],
          ),
        ),
      ),
    );
  }
}


class SignInUpMenu extends StatefulWidget {
  const SignInUpMenu({super.key});

  @override
  State<SignInUpMenu> createState() => _SignInUpMenuState();
}

class _SignInUpMenuState extends State<SignInUpMenu>
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: SizedBox(
          height: 380,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Constants.devinciColorLigth,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TabBar(
                        unselectedLabelColor: Colors.white,
                        labelColor: Colors.black,
                        indicatorColor: Colors.white,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9),
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
                    SignInFields(),
                    const SizedBox(
                      height: 50,
                      width: 50,
                      child: Text('page d\'inscription'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
