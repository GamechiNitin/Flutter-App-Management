enum PersonUrl { person1, person2 }

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return "asset/person.json";
      case PersonUrl.person2:
        return "asset/person2.json";
      default:
        return "";
    }
  }
}

// This Help to Get value with index like List
extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}
