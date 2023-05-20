// ignore_for_file: non_constant_identifier_names

class Account {
  late String username;
  String? token;
  late String? first_name;
  late String? last_name;
  bool is_superuser = false;

  Account();

  Account.fromJson(Map<String, dynamic> json) {
    token = json['token'] ?? json['key'];
    username = json['username'] ?? json['user']['username'];
    first_name = json['first_name'] ?? json['user']['first_name'];
    last_name = json['last_name'] ?? json['user']['last_name'];
    is_superuser = json['is_superuser'] ?? json['user']['is_superuser'];
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'token': token,
        'first_name': first_name,
        'last_name': last_name,
        'is_superuser': is_superuser,
      };
}

class GreenhouseRow {
  late int id;
  late int number;
  late String? unic_name;
  late String? card_uniq_name;

  GreenhouseRow();

  GreenhouseRow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    unic_name = json['unic_name'];
    card_uniq_name = json['card_uniq_name'];
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "number": number, "unic_name": unic_name, "card_uniq_name": card_uniq_name};
}

class FindNetwork {
  late String ip;
  bool isActive;

  FindNetwork(this.ip, {this.isActive = false});
}

// Map<String, String> choiceStatus = {
//   'accept waiting': 'Ожидает принятия',
//   'accepted': 'В работе',
//   'paused': 'На паузе',
//   'done': 'Выполнена',
// };
