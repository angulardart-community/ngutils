library services;

import 'package:angular/di.dart';
import 'src/title_service.dart';
import 'src/meta_service.dart';

export 'src/meta_service.dart';
export 'src/title_service.dart';

const utilsProviders = [
	titleProvider,
	metaProvider,
];

const titleProvider = ClassProvider(TitleService);
const metaProvider = ClassProvider(MetaService);