import 'package:ecommerce_app/widgets/theme_toggle_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/providers/theme_provider.dart';
import 'package:ecommerce_app/screens/splash_screen.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFFF0B90B), // Binance yellow
  scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light gray
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFF0B90B),
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF0B90B),
    foregroundColor: Colors.black,
    elevation: 0,
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xFFF0B90B), // Binance yellow
  scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Dark gray
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFF0B90B),
    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: const Color(0xFFF0B90B),
    elevation: 0,
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();   //this was not been added that lead to No:Firebase app created 
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),   
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Blockchain App',
          themeMode: themeProvider.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: const [
          ThemeToggleButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
