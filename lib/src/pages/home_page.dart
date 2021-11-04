import 'package:flutter/material.dart';
import 'package:fringreso/src/pages/history_page.dart';
import 'package:fringreso/src/pages/profile_page.dart';
import 'package:fringreso/src/providers/ui_provider.dart';
import 'package:fringreso/src/widgets/custom_navigationbar.dart';
import 'package:fringreso/src/widgets/form_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationbar(),
      floatingActionButton: FormButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectdMenuOpt;

    switch (currentIndex) {
      case 0:
        return HistoryPage();
      case 1:
        return ProfilePage();
      default:
        return HistoryPage();
    }
  }
}
