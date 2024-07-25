class CheckBoxListTileModel {
  String name;
  String description;
  bool isCheck;

  CheckBoxListTileModel(
      {required this.name, required this.description, required this.isCheck});

  static List<CheckBoxListTileModel> getFood() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          name: 'cheescake',
          description: 'low sugar filled with strawberry Sauce',
          isCheck: true),
      CheckBoxListTileModel(
          name: 'Orange Juice', description: 'Oiginal', isCheck: true),
      CheckBoxListTileModel(
          name: 'cheescake',
          description: 'low sugar filled with strawberry Sauce',
          isCheck: true),
      CheckBoxListTileModel(
          name: 'Orange Juice',
          description: 'low sugar filled with strawberry Sauce',
          isCheck: true),
    ];
  }

  static List<CheckBoxListTileModel> getphotographers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          name: 'sameera',
          description: 'good at taking photos',
          isCheck: false),
      CheckBoxListTileModel(
          name: 'Orange Juice', description: 'Oiginal', isCheck: false),
      CheckBoxListTileModel(
          name: 'cheescake',
          description: 'low sugar filled with strawberry Sauce',
          isCheck: false),
      CheckBoxListTileModel(
          name: 'Orange Juice',
          description: 'low sugar filled with strawberry Sauce',
          isCheck: false),
    ];
  }
}
