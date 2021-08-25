import 'package:angular/angular.dart';
import 'package:ngutils/services.dart';

import 'package:example/app_component.template.dart' as ng;
import 'main.template.dart' as self;

@GenerateInjector(utilsProviders)
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: rootInjector);
}
