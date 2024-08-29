import 'package:flutter/material.dart';
import 'joke_service_api.dart'; // Import the JokeService

class WelcomePage extends StatefulWidget {
  final String username;

  WelcomePage({required this.username});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late JokeService _jokeService;
  late Future<String> _futureJoke;

  @override
  void initState() {
    super.initState();
    _jokeService = JokeService();
    _futureJoke = _jokeService.fetchJoke();
  }

  void _refreshJoke() {
    setState(() {
      _futureJoke = _jokeService.fetchJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${widget.username}!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            FutureBuilder<String>(
              future: _futureJoke,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _refreshJoke,
              child: Text('Get New Joke'),
            ),
          ],
        ),
      ),
    );
  }
}
