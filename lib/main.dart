import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_management_app/providers/user_providers.dart';
import 'package:user_management_app/screen/user_screen.dart';
import 'package:user_management_app/service/user_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider(UserService())),
      ],
      child: MaterialApp(
        title: 'User Management',
        home: const UsersScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
