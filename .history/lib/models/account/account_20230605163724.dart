class AccountObject {
  late String email;
  late String accountType;
  String currency;

  bool isVertified;

  AccountObject();

  AccountObject.fromMap(Map data)
      : email = data['email'],
        accountType = data['accountType'],
        isVertified = data['isVertified'],
        currency = data['currency'];

  Map accountObjectToMap(AccountObject account) => {
        'email': account.email,
        'accountType': account.accountType,
        'isVertified': account.isVertified,
        'currency': account.currency
      };
}
