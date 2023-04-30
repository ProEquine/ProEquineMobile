import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/routes/routes.dart';


class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    _controller = VideoPlayerController.network(
        'https://cdn.shopify.com/videos/c/o/v/82e4dfe24c1842eaac4bcdf870ad6cea.mp4');
    _controller.initialize().then((_) {
      _controller.setLooping(true);

      setState(() {
        _controller.play();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null
        ? Scaffold(
            body: SizedBox(
              child: Stack(
                children: <Widget>[
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(38, 38, 38, 0.1),
                            Color.fromRGBO(38, 38, 38, 0.1),
                            Color.fromRGBO(38, 38, 38, 0.5),
                            Color.fromARGB(255, 36, 36, 36)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0, 0.4, 1],
                        ),
                      ),
                      child: const LoginLogoutButton(),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox(
            height: 20,
            child:  Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}

class LoginLogoutButton extends StatelessWidget {
  const LoginLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: Column(
              children: [
                RebiButton(onPressed: (){
                  AppSharedPreferences.firstTime=true;
                  Navigator.pushNamed(context, loginRoute);
                }, child: const Text("Login")),
                TextButton(
                  onPressed: () {
                    AppSharedPreferences.firstTime=true;
                    Navigator.pushNamed(context, registerRoute);
                  },
                  child: const Text(
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    "Create Account",
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
