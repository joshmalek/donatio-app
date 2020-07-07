import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MedalAsset {
  static Widget medalSvg(String asset_key, {String label}) {
    Map<String, String> medalKeyMap = {
      // "": "medals/leaderboard_bronzeAward.svg",
      // "": "medals/leaderboard_diamondAward.svg",
      // "": "medals/leaderboard_goldAward.svg",
      // "": "medals/leaderboard_silverAward.svg",
      "medal_firstDonation": "assets/medals/medal_firstDonation.svg",
      "medal_milestoneFour": "assets/medals/medal_milestoneFour.svg",
      "medal_milestoneOne": "assets/medals/medal_milestoneOne.svg",
      "medal_milestoneThree": "assets/medals/medal_milestoneThree.svg",
      "medal_milestoneTwo": "assets/medals/medal_milestoneTwo.svg",
    };

    if (!medalKeyMap.containsKey(asset_key)) {
      print("Cannot resolve asset ${asset_key}");
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(color: Colors.red),
      );
    }

    if (label != null)
      return SvgPicture.asset(medalKeyMap[asset_key], semanticsLabel: label);
    return SvgPicture.asset(medalKeyMap[asset_key]);
  }
}
