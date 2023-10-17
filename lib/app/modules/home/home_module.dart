import 'package:routime_app/app/core/modules/routime_module.dart';
import 'package:routime_app/app/modules/home/home_page.dart';

class HomeModule extends RoutimeModule {
  HomeModule()
      : super(
          bindings: [],
          routers: {
            '/home': (context) => const HomePage(),
          },
        );
}
