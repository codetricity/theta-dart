import 'package:apitest/get_last_image_url.dart';
import 'package:apitest/thumbnails/get_thumb.dart';
import 'package:args/command_runner.dart';
// import 'package:theta/theta.dart';
import 'dart:io';
// import 'pretty.dart';
import 'package:dcli/dcli.dart';

class ThumbGetCli extends Command {
  @override
  final name = 'thumbGet';

  @override
  final description =
      'Print image thumbnail byte data to screen. Pass URL of the file';

  ThumbGetCli() {
    argParser
      //TODO: add option to get last file
      ..addOption('url',
          help: 'Example: --url=http://192.168.1.1/files/../R0010307.JPG');
    // argParser
    //   ..addFlag('battery', help: 'battery charge level', negatable: false);
  }

  @override
  void run() async {
    if (!argResults.wasParsed('url')) {
      var lastUrl = await getLastImageUrl();
      await getThumb(lastUrl);
      print(red(
          'No URL specified. Using last image taken. Specify file with --url=http://192...'));
      exit(0);
    } else {
      //TODO: move to library. move print statement outside of library
      await getThumb(argResults['url']);
      exit(0);
    }
  }
}