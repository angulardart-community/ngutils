import 'package:io/io.dart';
import 'package:grinder/grinder.dart';

main(args) => grind(args);

@DefaultTask()
@Task('Run unit and component tests.')
void test() async {
  final manager = ProcessManager();

  final args = context.invocation.arguments;
  final lrm = args.getFlag('lrm'); // i.e. low resources mode
  final release = args.getFlag('release');
	// Options: chrome(default), firefox
  final String platform = args.getOption('platform') ?? 'chrome';

  var test = await manager.spawn(
    'dart',
    [
      'run',
      'build_runner',
      'test',
      if (lrm) '--low-resources-mode',
      if (release) '--release',
      '--',
      '--platform',
      platform,
    ],
    runInShell: true,
    workingDirectory: 'example',
  );
  await test.exitCode;
  await sharedStdIn.terminate();
}

@Task('Delete the build/ and .dart_tool/ directories.')
void clean() => defaultClean();
