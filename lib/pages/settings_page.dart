import 'package:flutter/material.dart';
import 'package:reminderapp/widgets/drawer.dart';
import 'package:reminderapp/widgets/header.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHeader(context),
      drawer: getDrawer(context),
      body: getBody(),
    );
  }

  Widget getBody() {
    return const Center(
      child: Text("Settings"),
    );
  }
}