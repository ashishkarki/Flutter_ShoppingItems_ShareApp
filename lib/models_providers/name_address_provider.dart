import 'package:flutter/cupertino.dart';

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
  static final NameAddress _initValue = NameAddress(
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
    return NameAddress.clone(_initValue);
  }

  NameAddress _item = _initValue;

  NameAddress get item {
    return NameAddress.clone(_item);
  }

  set item(NameAddress newNameAdd) {
    _item = newNameAdd;
    notifyListeners();
  }

  void addNewNameAddress(NameAddress editedNameAddress) {
    _item = editedNameAddress;
    print('_item after: $item');
    notifyListeners();
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
