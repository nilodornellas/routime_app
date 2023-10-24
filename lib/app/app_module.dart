import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:routime_app/app/app_widget.dart';
import 'package:routime_app/app/core/auth/auth_provider.dart';
import 'package:routime_app/app/repositories/user/user_repository_impl.dart';
import 'package:routime_app/app/repositories/user/user_repositoy.dart';
import 'package:routime_app/app/services/user/user_service.dart';
import 'package:routime_app/app/services/user/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(create: (_) => FirebaseStorage.instance),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            firebaseAuth: context.read(),
            firebaseStorage: context.read(),
          ),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(userRepository: context.read()),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(
            firebaseAuth: context.read(),
            userService: context.read(),
          )..loadListener(),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
