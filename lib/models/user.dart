class User {
  final int id;
  final String name, username, email, phone, website;
  final Address address;
  final Company company;

  User(this.id, this.name, this.username, this.email, this.phone, this.website,
      this.address, this.company);
}

class Address {
  final String street, suite, city, zipcode;
  final Geo geo;

  Address(this.street, this.suite, this.city, this.zipcode, this.geo);
}

class Geo {
  final String lat, lng;

  Geo(this.lat, this.lng);
}

class Company {
  final String name, catchPhrase, bs;

  Company(this.name, this.catchPhrase, this.bs);
}