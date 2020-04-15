import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../abstract/shopping_output.dart';

class NameAddress {
  final String firstName;
  final String middleName;
  final String lastName;
  final String street;
  final String city;
  final String stateOrProvince;
  final String nearestLandmark;
  final String contactPhone1;
  final String contactPhone2;

  const NameAddress({
    @required this.firstName,
    this.middleName,
    @required this.lastName,
    @required this.street,
    @required this.city,
    @required this.stateOrProvince,
    @required this.nearestLandmark,
    @required this.contactPhone1,
    this.contactPhone2,
  });

  NameAddress.clone(NameAddress nameAddress)
      : this(
          firstName: nameAddress.firstName,
          middleName: nameAddress.middleName,
          lastName: nameAddress.lastName,
          street: nameAddress.street,
          city: nameAddress.city,
          stateOrProvince: nameAddress.stateOrProvince,
          nearestLandmark: nameAddress.nearestLandmark,
          contactPhone1: nameAddress.contactPhone1,
          contactPhone2: nameAddress.contactPhone2,
        );
}

class NameAddressProvider
    with ChangeNotifier
    implements AbstractShoppingOutput {
  static final NameAddress initValue = NameAddress(
    firstName: '<Your-first-name>',
    lastName: '<Your-last-name>',
    middleName: '<Your-middle-name>',
    street: '<Your-street-road-name>',
    city: '<Your-city-name>',
    stateOrProvince: '<Your-state-province-name-number>',
    nearestLandmark: '<Name-of-a-landmark-near-you>',
    contactPhone1: '<your-10-digit-string-phone>',
    contactPhone2: '<your-10-digit-string-phone>',
    // firstName: '',
    // middleName: '',
    // lastName: '',
    // street: '',
    // city: '',
    // stateOrProvince: '',
    // nearestLandmark: '',
    // contactPhone1: '',
    // contactPhone2: '',
  );

  NameAddress get initNameAddValue {
    return NameAddress.clone(initValue);
  }

  NameAddress _item = initValue;

  Future<NameAddress> get item async {
    final sharedPref = await SharedPreferences.getInstance();

    if (sharedPref.containsKey(SHARED_PREF_NAME_ADDRESS_STRING) &&
        sharedPref.getString(SHARED_PREF_NAME_ADDRESS_STRING) != null) {
      final savedUserNameAddress =
          jsonDecode(sharedPref.getString(SHARED_PREF_NAME_ADDRESS_STRING))
              as Map<String, Object>;
      print('savedUserNameAddress: $savedUserNameAddress');
      _item = NameAddress(
        firstName: savedUserNameAddress['firstName'],
        lastName: savedUserNameAddress['lastName'],
        street: savedUserNameAddress['street'],
        city: savedUserNameAddress['city'],
        stateOrProvince: savedUserNameAddress['stateOrProvince'],
        nearestLandmark: savedUserNameAddress['nearestLandmark'],
        contactPhone1: savedUserNameAddress['contactPhone1'],
        middleName: savedUserNameAddress['middleName'] == null
            ? ''
            : savedUserNameAddress['middleName'],
        contactPhone2: savedUserNameAddress['contactPhone2'] == null
            ? ''
            : savedUserNameAddress['contactPhone2'],
      );
    }

    return NameAddress.clone(_item);
  }

  set item(Future<NameAddress> newNameAdd) {
    newNameAdd.then(
      (value) {
        _item = value;
        notifyListeners();
      },
    );
  }

  Future<void> addNewNameAddress(NameAddress editedNameAddress) async {
    try {
      _item = editedNameAddress;

      notifyListeners();

      final sharedPref = await SharedPreferences.getInstance();
      final userNameAddress = jsonEncode(
        {
          'firstName': editedNameAddress.firstName,
          'middleName': editedNameAddress.middleName,
          'lastName': editedNameAddress.lastName,
          'street': editedNameAddress.street,
          'city': editedNameAddress.city,
          'stateOrProvince': editedNameAddress.stateOrProvince,
          'nearestLandmark': editedNameAddress.nearestLandmark,
          'contactPhone1': editedNameAddress.contactPhone1,
          'contactPhone2': editedNameAddress.contactPhone2,
        },
      );
      sharedPref.setString(
        SHARED_PREF_NAME_ADDRESS_STRING,
        userNameAddress,
      );
    } catch (exception) {
      print('some errror during addNewNameAddress: $exception');
      throw exception;
    }
  }

  @override
  String get formattedShareableText {
    var formatShareText = '';

// full name
    formatShareText +=
        'Full Name: ${_item.firstName} ${_item.middleName} ${_item.lastName}' +
            '\n';
    // adddress
    formatShareText +=
        'Full Address: ${_item.street} (near/around: ${_item.nearestLandmark}),\n ${_item.city}, ${_item.stateOrProvince}\n';

    // phone
    formatShareText += 'Contact phone: ${_item.contactPhone1}';
    if (_item.contactPhone2 != null && _item.contactPhone2.isNotEmpty) {
      formatShareText += 'Alternate Contact phone: ${_item.contactPhone2}\n';
    } else {
      formatShareText += '\n';
    }

    return formatShareText;
  }
}
