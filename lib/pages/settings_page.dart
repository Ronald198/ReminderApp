import 'package:flutter/material.dart';
import 'package:reminderapp/pages/settingsSubpages/theme_settings_page.dart';
import 'package:reminderapp/widgets/drawer.dart';
import 'package:reminderapp/widgets/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> getPrefs() async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Widget getBody() {
    return FutureBuilder(
      future: getPrefs(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
        {
          if (snapshot.data != true)
          {
            return const Center(
              child: Text("Error while fetching settings data..."),
            );
          }
          
          return ListView(
            children: [
              const Padding( // OVERALL
                padding:  EdgeInsets.all(8.0),
                child: Text("Overall settings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => 
                      const ThemeSettingsPage(),
                    )
                  );
                },
                child: const ListTile(
                  title:  Text("App's theme"),
                  trailing: Icon(Icons.arrow_right, size: 36,),
                ),
              ),
              const Divider(), // HOMEPAGE
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text("Home page", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              // ),
              // SwitchListTile(
              //   title: const Text("Read out loud", style: TextStyle(fontWeight: FontWeight.bold)),
              //   subtitle: const Text("Read song when you click play"),
              //   value: readSongWhenPlay,
              //   onChanged: (value) async {
              //     final SharedPreferences prefs = await SharedPreferences.getInstance();
              //     await prefs.setBool("readSongWhenPlay", value);
        
              //     setState(() {
              //       readSongWhenPlay = value;
              //     });
              //   }
              // ),
              // SwitchListTile(
              //   title: const Text("Translate", style: TextStyle(fontWeight: FontWeight.bold)),
              //   subtitle: const Text("Translate song when using keyword"),
              //   value: translateSong,
              //   onChanged: (value) async {
              //     final SharedPreferences prefs = await SharedPreferences.getInstance();
              //     await prefs.setBool("translateSong", value);
        
              //     setState(() {
              //       translateSong = value;
              //     });
              //   }
              // ),
              // const Divider(), // TOP ITEMS PAGE
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text("Top items page", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              // ),
              // SwitchListTile(
              //   title: const Text("Show item images"),
              //   value: showTopItemImage,
              //   onChanged: (value) async {
              //     final SharedPreferences prefs = await SharedPreferences.getInstance();
              //     await prefs.setBool("showTopItemImage", value);
        
              //     setState(() {
              //       showTopItemImage = value;
              //     });
              //   }
              // ),
              // SwitchListTile(
              //   title: const Text("Use top quality images"),
              //   value: showTopQualityImage,
              //   onChanged: (value) async {
              //     final SharedPreferences prefs = await SharedPreferences.getInstance();
              //     await prefs.setBool("showTopQualityImage", value);
        
              //     setState(() {
              //       showTopQualityImage = value;
              //     });
              //   }
              // ),
            ],
          );
        }
        else if (snapshot.hasError)
        {
          return const Center(
            child: Text("Error while fetching settings data..."),
          );
        }
        else
        {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text("Loading data..."),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}