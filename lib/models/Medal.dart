class Medal {
  String name;
  String description;
  String imgUrl;

  Medal(String name, String description, String imgUrl) {
    this.name = name;
    this.description = description;
    this.imgUrl = imgUrl;
  }

  Medal.fromJson(Map json)
      : name = json['name'],
        description = json['description'],
        imgUrl = json['img_url'];
}
