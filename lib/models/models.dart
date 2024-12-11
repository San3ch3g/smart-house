// models/models.dart

import 'package:flutter/foundation.dart';

// Модель для таблицы profiles
class Profile {
  final String id;
  final String username;
  final String email;
  final String password;
  final String? userimage;
  final DateTime createdat;

  Profile({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.userimage,
    required this.createdat,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      userimage: map['userimage'],
      createdat: DateTime.parse(map['createdat']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'userimage': userimage,
      'createdat': createdat.toIso8601String(),
    };
  }
}

// Модель для таблицы house
class House {
  final String id;
  final String ownerid;
  final String address;
  final DateTime registeredat;

  House({
    required this.id,
    required this.ownerid,
    required this.address,
    required this.registeredat,
  });

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
      id: map['id'],
      ownerid: map['ownerid'],
      address: map['address'],
      registeredat: DateTime.parse(map['registeredat']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerid': ownerid,
      'address': address,
      'registeredat': registeredat.toIso8601String(),
    };
  }
}

// Модель для таблицы roomtype
class RoomType {
  final String id;
  final String roomtypename;
  final String? roomtypeimage;

  RoomType({
    required this.id,
    required this.roomtypename,
    this.roomtypeimage,
  });

  factory RoomType.fromMap(Map<String, dynamic> map) {
    return RoomType(
      id: map['id'],
      roomtypename: map['roomtypename'],
      roomtypeimage: map['roomtypeimage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomtypename': roomtypename,
      'roomtypeimage': roomtypeimage,
    };
  }
}

// Модель для таблицы devicetype
class DeviceType {
  final String id;
  final String devicetypename;
  final String? devicetypeimage;

  DeviceType({
    required this.id,
    required this.devicetypename,
    this.devicetypeimage,
  });

  factory DeviceType.fromMap(Map<String, dynamic> map) {
    return DeviceType(
      id: map['id'],
      devicetypename: map['devicetypename'],
      devicetypeimage: map['devicetypeimage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'devicetypename': devicetypename,
      'devicetypeimage': devicetypeimage,
    };
  }
}

// Модель для таблицы room
class Room {
  final String id;
  final String houseid;
  final String roomname;
  final String roomtypeid;

  Room({
    required this.id,
    required this.houseid,
    required this.roomname,
    required this.roomtypeid,
  });

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'],
      houseid: map['houseid'],
      roomname: map['roomname'],
      roomtypeid: map['roomtypeid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'houseid': houseid,
      'roomname': roomname,
      'roomtypeid': roomtypeid,
    };
  }
}

// Модель для таблицы device
class Device {
  final String id;
  final String roomid;
  final String devicename;
  final String devicetypeid;
  final bool ison;

  Device({
    required this.id,
    required this.roomid,
    required this.devicename,
    required this.devicetypeid,
    required this.ison,
  });

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['id'],
      roomid: map['roomid'],
      devicename: map['devicename'],
      devicetypeid: map['devicetypeid'],
      ison: map['ison'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomid': roomid,
      'devicename': devicename,
      'devicetypeid': devicetypeid,
      'ison': ison,
    };
  }
}

// Модель для таблицы devicefunc
class DeviceFunc {
  final String id;
  final String devicefuncname;
  final String devicetypeid;
  final String unit;

  DeviceFunc({
    required this.id,
    required this.devicefuncname,
    required this.devicetypeid,
    required this.unit,
  });

  factory DeviceFunc.fromMap(Map<String, dynamic> map) {
    return DeviceFunc(
      id: map['id'],
      devicefuncname: map['devicefuncname'],
      devicetypeid: map['devicetypeid'],
      unit: map['unit'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'devicefuncname': devicefuncname,
      'devicetypeid': devicetypeid,
      'unit': unit,
    };
  }
}

// Модель для таблицы devicefuncstatus
class DeviceFuncStatus {
  final String id;
  final String devicefuncid;
  final String deviceid;
  final double value;
  final DateTime updatedat;

  DeviceFuncStatus({
    required this.id,
    required this.devicefuncid,
    required this.deviceid,
    required this.value,
    required this.updatedat,
  });

  factory DeviceFuncStatus.fromMap(Map<String, dynamic> map) {
    return DeviceFuncStatus(
      id: map['id'],
      devicefuncid: map['devicefuncid'],
      deviceid: map['deviceid'],
      value: map['value'],
      updatedat: DateTime.parse(map['updatedat']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'devicefuncid': devicefuncid,
      'deviceid': deviceid,
      'value': value,
      'updatedat': updatedat.toIso8601String(),
    };
  }
}