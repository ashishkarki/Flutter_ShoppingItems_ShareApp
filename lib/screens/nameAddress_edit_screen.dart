import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models_providers/name_address_provider.dart';

class NameAddressEditScreen extends StatefulWidget {
  static final routeName = '/name-address-edit';

  @override
  _NameAddressEditScreenState createState() => _NameAddressEditScreenState();
}

class _NameAddressEditScreenState extends State<NameAddressEditScreen> {
  var _inputDisabled = true;

  final _formKey = GlobalKey<FormState>();

  FocusNode _currentFocusNode;
  FocusNode _middleNameFocusNode;
  FocusNode _lastNameFocusNode;
  FocusNode _streetFocusNode;
  FocusNode _cityFocusNode;
  FocusNode _stateFocusNode;
  FocusNode _landmarkFocusNode;
  FocusNode _phone1FocusNode;
  FocusNode _phone2FocusNode;

  static final NameAddress _initValues = NameAddress(
    firstName: '',
    middleName: '',
    lastName: '',
    street: '',
    city: '',
    stateOrProvince: '',
    nearestLandmark: '',
    contactPhone1: '',
    contactPhone2: '',
  );

  NameAddress _editedNameAddress = NameAddress(
    firstName: '',
    middleName: '',
    lastName: '',
    street: '',
    city: '',
    stateOrProvince: '',
    nearestLandmark: '',
    contactPhone1: '',
    contactPhone2: '',
  );

  void _saveForm(
    NameAddressProvider nameAddressProvider,
  ) {
    if (!_formKey.currentState.validate()) {
      return; // form is invalid
    }

    _formKey.currentState.save();
    nameAddressProvider.addNewNameAddress(_editedNameAddress);

    Navigator.of(context).pop();
  }

  void _changeFocus(FocusNode focusNodeNext) {
    _currentFocusNode.unfocus();
    focusNodeNext.requestFocus();
    _currentFocusNode = focusNodeNext;
  }

  @override
  void initState() {
    super.initState();
    _currentFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _middleNameFocusNode = FocusNode();
    _streetFocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _stateFocusNode = FocusNode();
    _landmarkFocusNode = FocusNode();
    _phone1FocusNode = FocusNode();
    _phone2FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    // _currentFocusNode.dispose();
    // _lastNameFocusNode.dispose();
    // _middleNameFocusNode.dispose();
    // _streetFocusNode.dispose();
    // _cityFocusNode.dispose();
    // _stateFocusNode.dispose();
    // _landmarkFocusNode.dispose();
    // _phone1FocusNode.dispose();
    // _phone2FocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _nameAddProvider = Provider.of<NameAddressProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit Name-Address'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(_nameAddProvider),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // FIRST NAME
                TextFormField(
                  initialValue: _initValues.firstName,
                  decoration: InputDecoration(
                    labelText: 'Your First Name',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) => _changeFocus(_middleNameFocusNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a first name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: value,
                      middleName: _editedNameAddress.middleName,
                      lastName: _editedNameAddress.lastName,
                      street: _editedNameAddress.street,
                      city: _editedNameAddress.contactPhone2,
                      stateOrProvince: _editedNameAddress.stateOrProvince,
                      nearestLandmark: _editedNameAddress.nearestLandmark,
                      contactPhone1: _editedNameAddress.contactPhone1,
                      contactPhone2: _editedNameAddress.contactPhone2,
                    );
                  },
                ),
                // MIDDLE NAME (OPTIONAL)
                TextFormField(
                  initialValue: _initValues.middleName,
                  decoration: InputDecoration(
                    labelText: 'Your Middle Name (Optional)',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _middleNameFocusNode,
                  onFieldSubmitted: (_) => _changeFocus(_lastNameFocusNode),
                  validator: (value) {
                    // optional field so always valid
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: _editedNameAddress.firstName,
                      middleName: value,
                      lastName: _editedNameAddress.lastName,
                      street: _editedNameAddress.street,
                      city: _editedNameAddress.contactPhone2,
                      stateOrProvince: _editedNameAddress.stateOrProvince,
                      nearestLandmark: _editedNameAddress.nearestLandmark,
                      contactPhone1: _editedNameAddress.contactPhone1,
                      contactPhone2: _editedNameAddress.contactPhone2,
                    );
                  },
                ),
                // LAST NAME
                TextFormField(
                  initialValue: _initValues.lastName,
                  decoration: InputDecoration(
                    labelText: 'Your Last Name',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _lastNameFocusNode,
                  onFieldSubmitted: (_) => _changeFocus(_streetFocusNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a last name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: _editedNameAddress.firstName,
                      middleName: _editedNameAddress.middleName,
                      lastName: value,
                      street: _editedNameAddress.street,
                      city: _editedNameAddress.contactPhone2,
                      stateOrProvince: _editedNameAddress.stateOrProvince,
                      nearestLandmark: _editedNameAddress.nearestLandmark,
                      contactPhone1: _editedNameAddress.contactPhone1,
                      contactPhone2: _editedNameAddress.contactPhone2,
                    );
                  },
                ),
                // STREET
                TextFormField(
                  initialValue: _initValues.street,
                  decoration: InputDecoration(
                    labelText: 'Your Street/Road Name',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _streetFocusNode,
                  onFieldSubmitted: (_) => _changeFocus(_cityFocusNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a street name or n/a if not available';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: _editedNameAddress.firstName,
                      middleName: _editedNameAddress.middleName,
                      lastName: _editedNameAddress.lastName,
                      street: value,
                      city: _editedNameAddress.contactPhone2,
                      stateOrProvince: _editedNameAddress.stateOrProvince,
                      nearestLandmark: _editedNameAddress.nearestLandmark,
                      contactPhone1: _editedNameAddress.contactPhone1,
                      contactPhone2: _editedNameAddress.contactPhone2,
                    );
                  },
                ),
                // CITY
                TextFormField(
                  initialValue: _initValues.city,
                  decoration: InputDecoration(
                    labelText: 'Your City Name',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _cityFocusNode,
                  onFieldSubmitted: (_) => _changeFocus(_stateFocusNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a City name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: _editedNameAddress.firstName,
                      middleName: _editedNameAddress.middleName,
                      lastName: _editedNameAddress.lastName,
                      street: _editedNameAddress.street,
                      city: value,
                      stateOrProvince: _editedNameAddress.stateOrProvince,
                      nearestLandmark: _editedNameAddress.nearestLandmark,
                      contactPhone1: _editedNameAddress.contactPhone1,
                      contactPhone2: _editedNameAddress.contactPhone2,
                    );
                  },
                ),
                // STATE OR PROVINCE
                TextFormField(
                  initialValue: _initValues.stateOrProvince,
                  decoration: InputDecoration(
                    labelText: 'Your State or Province Name',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _stateFocusNode,
                  onFieldSubmitted: (_) => _changeFocus(_landmarkFocusNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a State or province name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: _editedNameAddress.firstName,
                      middleName: _editedNameAddress.middleName,
                      lastName: _editedNameAddress.lastName,
                      street: _editedNameAddress.street,
                      city: _editedNameAddress.city,
                      stateOrProvince: value,
                      nearestLandmark: _editedNameAddress.nearestLandmark,
                      contactPhone1: _editedNameAddress.contactPhone1,
                      contactPhone2: _editedNameAddress.contactPhone2,
                    );
                  },
                ),
                // LANDMARK
                TextFormField(
                  initialValue: _initValues.nearestLandmark,
                  decoration: InputDecoration(
                    labelText: 'A Landmark near your place',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _landmarkFocusNode,
                  onFieldSubmitted: (_) => _changeFocus(_phone1FocusNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a landmark name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: _editedNameAddress.firstName,
                      middleName: _editedNameAddress.middleName,
                      lastName: _editedNameAddress.lastName,
                      street: _editedNameAddress.street,
                      city: _editedNameAddress.city,
                      stateOrProvince: _editedNameAddress.stateOrProvince,
                      nearestLandmark: value,
                      contactPhone1: _editedNameAddress.contactPhone1,
                      contactPhone2: _editedNameAddress.contactPhone2,
                    );
                  },
                ),
                // CONTACT PHONE 1
                TextFormField(
                  initialValue: _initValues.contactPhone1,
                  decoration: InputDecoration(
                    labelText: 'Your Contact Number',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  focusNode: _phone1FocusNode,
                  onFieldSubmitted: (_) => _changeFocus(_phone2FocusNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: _editedNameAddress.firstName,
                      middleName: _editedNameAddress.middleName,
                      lastName: _editedNameAddress.lastName,
                      street: _editedNameAddress.street,
                      city: _editedNameAddress.city,
                      stateOrProvince: _editedNameAddress.stateOrProvince,
                      nearestLandmark: _editedNameAddress.nearestLandmark,
                      contactPhone1: value,
                      contactPhone2: _editedNameAddress.contactPhone2,
                    );
                  },
                ),
                // CONTACT PHONE 2 (OPTIONAL)
                TextFormField(
                  initialValue: _initValues.contactPhone2,
                  decoration: InputDecoration(
                    labelText: 'Your Alternate Phone Number',
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  focusNode: _phone2FocusNode,
                  validator: (value) {
                    return null;
                  },
                  onSaved: (value) {
                    _editedNameAddress = NameAddress(
                      firstName: _editedNameAddress.firstName,
                      middleName: _editedNameAddress.middleName,
                      lastName: _editedNameAddress.lastName,
                      street: _editedNameAddress.street,
                      city: _editedNameAddress.city,
                      stateOrProvince: _editedNameAddress.stateOrProvince,
                      nearestLandmark: _editedNameAddress.nearestLandmark,
                      contactPhone1: _editedNameAddress.contactPhone1,
                      contactPhone2: value,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () => _saveForm(
                      _nameAddProvider,
                    ),
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
