import 'package:equatable/equatable.dart';

class WelcomeState extends Equatable {
  final int currentPage;
  final List<Map<String, String>> welcomeData;
  
  const WelcomeState({
    this.currentPage = 0,
    this.welcomeData = const [
      {
        "text": "Welcome to MedSync",
        "subtext": "Your personal healthcare companion",
        "image": "https://i.postimg.cc/mhhVywp9/splash-1.png"
      },
      {
        "text": "Track Your Health",
        "subtext": "Monitor your health metrics easily",
        "image": "https://i.postimg.cc/PNcy3w0R/splash-2.png"
      },
      {
        "text": "Stay Connected",
        "subtext": "Connect with healthcare providers",
        "image": "https://i.postimg.cc/wRtVxqR2/splash-3.png"
      },
    ],
  });

  @override
  List<Object?> get props => [currentPage, welcomeData];
}