import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:routime_app/app/app_widget.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) {},
        ),
      ],
      child: const AppWidget(),
    );
  }
}
