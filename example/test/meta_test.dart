// @TestOn('browser')

// import 'package:angular/angular.dart';
// import 'package:angular_test/angular_test.dart';
// import 'package:ngutils/services.dart';
// import 'package:test/test.dart';

// import 'package:example/app_component.dart';
// import 'package:example/app_component.template.dart' as ng;

// @GenerateInjector([
// 	ClassProvider(TitleService),
// ])
// final InjectorFactory rootInjector = ng.rootInjector$Injector;

// void main() {
//   final testBed =
//       NgTestBed.forComponent<AppComponent>(ng.AppComponentNgFactory);
//   NgTestFixture<AppComponent> fixture;

//   setUp(() async {
//     fixture = await testBed.create();
//   });

//   tearDown(disposeAnyRunningTest);

//   test('heading', () {
//     expect(fixture.text, contains('My First AngularDart App'));
//   });

//   // Testing info: https://angulardart.dev/guide/testing
// }
