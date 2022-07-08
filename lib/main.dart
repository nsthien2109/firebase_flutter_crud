import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo/provider/form_provider.dart';
import 'package:firebase_todo/router/app_router.dart';
import 'package:firebase_todo/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(MyApp(isLogin: await getLogin('isLogin') ?? false));
}

class MyApp extends StatelessWidget {
  final bool? isLogin;
  const MyApp({Key? key, this.isLogin}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormProvider())
      ],
      child: GestureDetector(
        onTap: () => KeyboardService.dismiss(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Firebase Demo',
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: isLogin! ? '/' : '/login',
          theme: ThemeData(      
            primarySwatch: Colors.orange,
          ),
          builder: EasyLoading.init()
        ),
      ),
    );
  }
}
