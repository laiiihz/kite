import 'package:path/path.dart';

const cPlatform = {
  'ios',
  'android',
  'windows',
  'linux',
  'macos',
  'web',
};

const cTemplate = {
  'app',
  'module',
  'package',
  'plugin',
  'skeleton',
};

const cIosLang = {
  'objC',
  'swift',
};

const cAndroidLang = {
  'java',
  'kotlin',
};

const defaultOrgName = 'com.example';

class CreateModel {
  final String appName;
  final String orgName;
  final Set<String> platforms;
  final String template;
  final String iosLang;
  final String androidLang;
  final String description;
  final String path;
  const CreateModel({
    required this.appName,
    required this.orgName,
    required this.platforms,
    required this.template,
    required this.iosLang,
    required this.androidLang,
    required this.description,
    required this.path,
  });

  CommandObj createCommand() {
    var exec = 'flutter';
    final args = <String>[];
    args.add('create');
    args.add('--org=$orgName');
    args.add('--platforms=${platforms.join(',')}');
    args.add('--ios-language=$iosLang');
    args.add('--android-language=$androidLang');
    args.add('--description=$description');
    args.add(join(path, appName));
    return CommandObj(exec: exec, args: args);
  }
}

class CommandObj {
  final String exec;
  final List<String> args;

  const CommandObj({
    required this.exec,
    required this.args,
  });
}
