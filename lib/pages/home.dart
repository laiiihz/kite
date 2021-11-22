import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:kite/models/create_model.dart';
import 'package:kite/pages/about.dart';

enum PopMenus {
  about,
}

class HomePage extends StatefulWidget {
  static const String name = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _orgController = TextEditingController();
  final _desController = TextEditingController();
  final _platforms = {...cPlatform};
  var _template = 'app';
  var _iosLang = 'swift';
  var _androidLang = 'kotlin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kite'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: PopMenus.about,
                  child: Text('About'),
                ),
              ];
            },
            onSelected: (menu) {
              switch (menu) {
                case PopMenus.about:
                  Navigator.pushNamed(context, AboutPage.name);
                  break;
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'App Name',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _orgController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Org Name',
              hintText: 'com.example',
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.black26),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Platforms'),
                  Wrap(
                    children: cPlatform.map((e) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: _platforms.contains(e),
                            onChanged: (state) {
                              if (_platforms.contains(e)) {
                                _platforms.remove(e);
                              } else {
                                _platforms.add(e);
                              }
                              setState(() {});
                            },
                          ),
                          Text(e),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.black26),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Template'),
                  Wrap(
                    children: cTemplate.map((e) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            groupValue: _template,
                            value: e,
                            onChanged: (state) {
                              _template = e;
                              setState(() {});
                            },
                          ),
                          Text(e),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.black26),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('iOS language'),
                  Wrap(
                    children: cIosLang.map((e) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            groupValue: _iosLang,
                            value: e,
                            onChanged: (state) {
                              _iosLang = e;
                              setState(() {});
                            },
                          ),
                          Text(e),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.black26),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Android language'),
                  Wrap(
                    children: cAndroidLang.map((e) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            groupValue: _androidLang,
                            value: e,
                            onChanged: (state) {
                              _androidLang = e;
                              setState(() {});
                            },
                          ),
                          Text(e),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _desController,
            minLines: 1,
            maxLines: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'description',
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var dir = await getDirectoryPath();
          if (dir == null) return;
          var model = CreateModel(
            appName: _nameController.text,
            orgName: _orgController.text,
            platforms: _platforms,
            template: _template,
            iosLang: _iosLang,
            androidLang: _androidLang,
            description: _desController.text,
            path: dir,
          );
          var command = model.createCommand();
          final cancel = BotToast.showLoading();
          await Process.run(command.exec, command.args);
          cancel();
        },
      ),
    );
  }
}
