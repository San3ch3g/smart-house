import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;


  Future<AuthResponse> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        print('Пользователь зарегистрирован: ${response.user!.email}');

        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'username': username,
          'email': email,
          'password':password,
        });

        print('Профиль пользователя создан');
      } else {
        print('Ошибка: пользователь не зарегистрирован');
      }

      return response;
    } catch (error) {
      print('Ошибка при регистрации: $error');
      rethrow;
    }
  }
  Future<AuthResponse> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        print('Пользователь вошел в систему: ${response.user!.email}');
      } else {
        print('Ошибка: пользователь не вошел в систему');
      }

      return response;
    } catch (error) {
      print('Ошибка при входе: $error');
      rethrow;
    }
  }
  Future<void> createHouse({
    required String ownerId,
    required String address,
  }) async {
    try {
      print('Создание дома для пользователя: $ownerId, адрес: $address');

      await _supabase.from('house').insert({
        'ownerid': ownerId,
        'address': address,
      });

      print('Дом успешно создан');
    } catch (error) {
      print('Ошибка при создании дома: $error');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getRoomsByHouseId(String houseId) async {
    try {
      final response = await _supabase
          .from('room')
          .select()
          .eq('houseid', houseId);

      return List<Map<String, dynamic>>.from(response);
    } catch (error) {
      print('Ошибка при получении комнат: $error');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getDevicesByRoomId(String roomId) async {
    try {
      final response = await _supabase
          .from('device')
          .select()
          .eq('roomid', roomId);

      return List<Map<String, dynamic>>.from(response);
    } catch (error) {
      print('Ошибка при получении устройств: $error');
      rethrow;
    }
  }

  Future<void> createRoom({
    required String houseId,
    required String roomName,
    required String roomTypeId,
  }) async {
    try {
      await _supabase.from('room').insert({
        'houseid': houseId,
        'roomname': roomName,
        'roomtypeid': roomTypeId,
      });
    } catch (error) {
      print('Ошибка при создании комнаты: $error');
      rethrow;
    }
  }

  Future<void> createDevice({
    required String roomId,
    required String deviceName,
    required String deviceTypeId,
  }) async {
    try {
      await _supabase.from('device').insert({
        'roomid': roomId,
        'devicename': deviceName,
        'devicetypeid': deviceTypeId,
      });
    } catch (error) {
      print('Ошибка при создании устройства: $error');
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String userId,
    required String username,
    required String email,
    String? userImage,
  }) async {
    try {
      await _supabase.from('profiles').update({
        'username': username,
        'email': email,
        'userimage': userImage,
      }).eq('id', userId);
    } catch (error) {
      print('Ошибка при обновлении профиля: $error');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getDeviceTypes() async {
    try {
      final response = await _supabase
          .from('devicetype')
          .select();

      return List<Map<String, dynamic>>.from(response);
    } catch (error) {
      print('Ошибка при получении типов устройств: $error');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getRoomTypes() async {
    try {
      final response = await _supabase
          .from('roomtype')
          .select();

      return List<Map<String, dynamic>>.from(response);
    } catch (error) {
      print('Ошибка при получении типов комнат: $error');
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _supabase.auth.signOut();
    } catch (error) {
      print('Ошибка при выходе: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final response = await _supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        return response;
      }
      return null;
    } catch (error) {
      print('Ошибка при получении профиля пользователя: $error');
      rethrow;
    }
  }
  Future<String?> getHouseIdByAddress(String address) async {
    try {
      // Запрос к таблице house для получения house id по адресу
      final response = await _supabase
          .from('house')
          .select('id')
          .eq('address', address)
          .single();

      if (response != null) {
        final houseId = response['id'] as String;
        return houseId; // Возвращаем house id
      } else {
        print('Дом с адресом $address не найден');
        return null; // Если дом не найден, возвращаем null
      }
    } catch (error) {
      print('Ошибка при получении house id: $error');
      rethrow;
    }

    }
  Future<String?> getRoomTypeNameById(String roomTypeId) async {
    try {
      final response = await _supabase
          .from('roomtype')
          .select('roomtypename')
          .eq('id', roomTypeId)
          .single();

      if (response != null) {
        return response['roomtypename'] as String;
      } else {
        print('Тип комнаты с ID $roomTypeId не найден');
        return null;
      }
    } catch (error) {
      print('Ошибка при получении имени типа комнаты: $error');
      rethrow;
    }
  }
}

