import 'package:flutter/cupertino.dart';

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

class NameAddressProvider with ChangeNotifier {
  static final NameAddress _initValue = NameAddress(
    firstName: '<Your-first-name>',
    lastName: '',
    middleName: 'singh',
    street: 'hallu ballu road of jhandu city',
    city: '',
    stateOrProvince: '',
    nearestLandmark: 'Regenty-Saty Paisa Kamau School',
    contactPhone1: '9841297859',
    contactPhone2: '',
  );

  NameAddress _item = _initValue;

  NameAddress get item {
    return NameAddress.clone(_item);
  }

  set item(NameAddress newNameAdd) {
    _item = newNameAdd;
  }
}
