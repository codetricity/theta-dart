import 'package:apitest/commands/reset.dart';
import 'package:args/command_runner.dart';
// import 'package:theta/theta.dart';
import 'dart:io';
// import 'pretty.dart';

class ResetCli extends Command {
  @override
  final name = 'reset';

  @override
  final description =
      'Reset camera settings. Camera will turn off. Need to reconnect';

  ResetCli() {
    // argParser
    //   ..addFlag('battery', help: 'battery charge level', negatable: false);
  }

  @override
  void run() async {
    //TODO: move to library. move print statement outside of library
    await reset();
    exit(0);
  }
}
