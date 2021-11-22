import 'package:flutter/material.dart';
import 'package:kite/utils/info_util.dart';

class AboutPage extends StatefulWidget {
  static const String name = '/about';
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, state) {
          return [
            const SliverAppBar(
              title: Text('About'),
              floating: true,
              pinned: true,
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<String>(
                  future: InfoUtil.flutterDoctor(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(snapshot.data ?? '');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
