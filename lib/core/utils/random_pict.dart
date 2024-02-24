import 'dart:math';

import 'package:story_app/core/resources/assets.dart';

String getRandomPict() {
  List<String> profilePict = [
    Assets.profile1,
    Assets.profile2,
    Assets.profile3,
    Assets.profile4,
    Assets.profile5,
  ];

  // Create a random number generator
  Random random = Random();

  // Generate a random index within the range of the list
  int randomIndex = random.nextInt(profilePict.length);

  // Get the random element from the list
  String randomString = profilePict[randomIndex];

  return randomString;
}
