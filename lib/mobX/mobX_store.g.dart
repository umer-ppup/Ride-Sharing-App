// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobX_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$mobXclass on _mobXclass, Store {
  final _$countAtom = Atom(name: '_mobXclass.count');

  @override
  String get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(String value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  final _$placeDistanceAtom = Atom(name: '_mobXclass.placeDistance');

  @override
  String get placeDistance {
    _$placeDistanceAtom.reportRead();
    return super.placeDistance;
  }

  @override
  set placeDistance(String value) {
    _$placeDistanceAtom.reportWrite(value, super.placeDistance, () {
      super.placeDistance = value;
    });
  }

  final _$markersAtom = Atom(name: '_mobXclass.markers');

  @override
  Set<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(Set<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  final _$drivemarkerAtom = Atom(name: '_mobXclass.drivemarker');

  @override
  Set<Marker> get drivemarker {
    _$drivemarkerAtom.reportRead();
    return super.drivemarker;
  }

  @override
  set drivemarker(Set<Marker> value) {
    _$drivemarkerAtom.reportWrite(value, super.drivemarker, () {
      super.drivemarker = value;
    });
  }

  final _$circleAtom = Atom(name: '_mobXclass.circle');

  @override
  Set<Circle> get circle {
    _$circleAtom.reportRead();
    return super.circle;
  }

  @override
  set circle(Set<Circle> value) {
    _$circleAtom.reportWrite(value, super.circle, () {
      super.circle = value;
    });
  }

  final _$polylinesAtom = Atom(name: '_mobXclass.polylines');

  @override
  Map<PolylineId, Polyline> get polylines {
    _$polylinesAtom.reportRead();
    return super.polylines;
  }

  @override
  set polylines(Map<PolylineId, Polyline> value) {
    _$polylinesAtom.reportWrite(value, super.polylines, () {
      super.polylines = value;
    });
  }

  final _$trackpolylinesAtom = Atom(name: '_mobXclass.trackpolylines');

  @override
  Map<PolylineId, Polyline> get trackpolylines {
    _$trackpolylinesAtom.reportRead();
    return super.trackpolylines;
  }

  @override
  set trackpolylines(Map<PolylineId, Polyline> value) {
    _$trackpolylinesAtom.reportWrite(value, super.trackpolylines, () {
      super.trackpolylines = value;
    });
  }

  final _$drivepolylineAtom = Atom(name: '_mobXclass.drivepolyline');

  @override
  Map<PolylineId, Polyline> get drivepolyline {
    _$drivepolylineAtom.reportRead();
    return super.drivepolyline;
  }

  @override
  set drivepolyline(Map<PolylineId, Polyline> value) {
    _$drivepolylineAtom.reportWrite(value, super.drivepolyline, () {
      super.drivepolyline = value;
    });
  }

  final _$startAddressAtom = Atom(name: '_mobXclass.startAddress');

  @override
  String get startAddress {
    _$startAddressAtom.reportRead();
    return super.startAddress;
  }

  @override
  set startAddress(String value) {
    _$startAddressAtom.reportWrite(value, super.startAddress, () {
      super.startAddress = value;
    });
  }

  final _$getCurrentLocationAsyncAction =
      AsyncAction('_mobXclass.getCurrentLocation');

  @override
  Future getCurrentLocation() {
    return _$getCurrentLocationAsyncAction
        .run(() => super.getCurrentLocation());
  }

  final _$_getAddressAsyncAction = AsyncAction('_mobXclass._getAddress');

  @override
  Future _getAddress() {
    return _$_getAddressAsyncAction.run(() => super._getAddress());
  }

  final _$calculateDistanceAsyncAction =
      AsyncAction('_mobXclass.calculateDistance');

  @override
  Future<bool> calculateDistance() {
    return _$calculateDistanceAsyncAction.run(() => super.calculateDistance());
  }

  final _$getTimeAsyncAction = AsyncAction('_mobXclass.getTime');

  @override
  Future getTime(double latitude, double longitude, double latitude2,
      double longitude2, int num) {
    return _$getTimeAsyncAction.run(
        () => super.getTime(latitude, longitude, latitude2, longitude2, num));
  }

  final _$createPolylinesAsyncAction =
      AsyncAction('_mobXclass.createPolylines');

  @override
  Future<void> createPolylines(Position start, Position destination, int num) {
    return _$createPolylinesAsyncAction
        .run(() => super.createPolylines(start, destination, num));
  }

  final _$jajajAsyncAction = AsyncAction('_mobXclass.jajaj');

  @override
  Future<void> jajaj(Position start, Position destination) {
    return _$jajajAsyncAction.run(() => super.jajaj(start, destination));
  }

  final _$_mobXclassActionController = ActionController(name: '_mobXclass');

  @override
  Future<dynamic> changestate(dynamic lati, dynamic long, int num) {
    final _$actionInfo = _$_mobXclassActionController.startAction(
        name: '_mobXclass.changestate');
    try {
      return super.changestate(lati, long, num);
    } finally {
      _$_mobXclassActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> cretate(Polyline polyline) {
    final _$actionInfo =
        _$_mobXclassActionController.startAction(name: '_mobXclass.cretate');
    try {
      return super.cretate(polyline);
    } finally {
      _$_mobXclassActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> marker(Marker marker) {
    final _$actionInfo =
        _$_mobXclassActionController.startAction(name: '_mobXclass.marker');
    try {
      return super.marker(marker);
    } finally {
      _$_mobXclassActionController.endAction(_$actionInfo);
    }
  }

  @override
  double _coordinateDistance(
      dynamic lat1, dynamic lon1, dynamic lat2, dynamic lon2) {
    final _$actionInfo = _$_mobXclassActionController.startAction(
        name: '_mobXclass._coordinateDistance');
    try {
      return super._coordinateDistance(lat1, lon1, lat2, lon2);
    } finally {
      _$_mobXclassActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCameraPosition(Position currentposition) {
    final _$actionInfo = _$_mobXclassActionController.startAction(
        name: '_mobXclass.changeCameraPosition');
    try {
      return super.changeCameraPosition(currentposition);
    } finally {
      _$_mobXclassActionController.endAction(_$actionInfo);
    }
  }

  @override
  void placemarker(Position position) {
    final _$actionInfo = _$_mobXclassActionController.startAction(
        name: '_mobXclass.placemarker');
    try {
      return super.placemarker(position);
    } finally {
      _$_mobXclassActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
count: ${count},
placeDistance: ${placeDistance},
markers: ${markers},
drivemarker: ${drivemarker},
circle: ${circle},
polylines: ${polylines},
trackpolylines: ${trackpolylines},
drivepolyline: ${drivepolyline},
startAddress: ${startAddress}
    ''';
  }
}
