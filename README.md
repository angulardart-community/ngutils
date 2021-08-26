# NgUtils

A collection of services and (in the future) components that helps you create beautiful and performant AngularDart websites easily.

- [NgUtils](#ngutils)
	- [Services](#services)
		- [`TitleService`](#titleservice)
		- [`MetaService`](#metaservice)

## Services

Most services are app-wide services, so it's recommended to use the [root injector](https://angulardart.xyz/guide/dependency-injection#root-injector-providers) instead of injecting them into components. Use `utilsProviders` to inject all services provided by `ngutils` into your app, or use each service's own `ClassProvider`.

For info on how to use services, see ["Register a service provider"](https://angulardart.xyz/guide/dependency-injection#register-a-service-provider) from the AngularDart docs.

```dart
import 'package:angular/angular.dart';
import 'package:mywebsite/app_component.template.dart' as ng;
import 'package:ngutils/services.dart';

import 'main.template.dart' as self;

// Inject everything.
@GenerateInjector(
  utilsProviders, 
)
// Or inject only the services you need.
@GenerateInjector([
	titleProvider,
	metaProvider,
])
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: rootInjector);
}
```

### `TitleService`

Provider: `titleProvider`.

A service that can be used to get and set the title of a current HTML document.

Usage:

```dart
final currentPageTitle = titleSerivce.getTitle();
titleService.setTitle('My Awesome Website');
```

### `MetaService`

Provider: `metaProvider`.

A serivce that can be used to get, add, change, and remove `<meta>` tags.

Usage:

```dart
metaService.addTag('name="description"', 'My awesome website.');
metaService.addTag('property="og:description"', 'My awesome website.');

metaService.setTag('og:title', 'AngularDart Documentation');

metaService.removeTag('twitter:card');
metaService.removeTags(['twitter:site', 'twitter:description']);

metaService.getTag('og:url'); // Returns a `MetaElement`.
metaService.getTags(['og:image', 'twitter:image']); // Returns `List<MetaElement>`.
```
