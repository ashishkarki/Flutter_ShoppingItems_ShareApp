import 'package:flutter/foundation.dart';

class ShareData {
  final String name;
  final String description;

  const ShareData({
    @required this.name,
    @required this.description,
  });
}

const APP_TITLE_STRING = 'Type and Share App';

const List<ShareData> dummyData = [
  ShareData(
    name: 'bread',
    description: 'Nanglo bread',
  ),
  ShareData(
    name: 'soyabean oil',
    description: 'Swastik brand',
  ),
  ShareData(
    name: 'Corn flakes',
    description: 'Kellog\'s brand',
  ),
  ShareData(
    name: 'Dettelo liquied',
    description: 'Big bottle',
  ),
  ShareData(
    name: 'Chicken curry masala',
    description: 'Everest brand',
  ),
];
