abstract class Db {
  static const productCol = "products";
  static const usersCol = "users";
  static const ordersCol = "orders";
  static const configCol = "config";
  static const filterMapCol = "filters";

  // static const configDocument = "config_doc";
  static const deliveryConfigDoc = "delivery";
  static const aboutAppDoc = "about";
  static const bannerDoc = "banner";
  static const categoriesDoc = "categories";
  static const subCategoriesDoc = "sub_categories";

  //same doc//single doc
  static const String favouriteSubCol = "favourite";
  static const String cartSubCol = "cart";
  //multiple docs
  static const String addressSubCol = "address";
  static const String ordersSubCol = "orders";

  static const String popularityField = "popularity";
  static const String favouriteField = "favourite";
  static const String addressField = "address";
  static const String cartField = "cart";
  static const String priceField = "price";
  static const String stockField = "inStock";
  static const String isPopularField = "isPopular";

  static const String sizeField = "size";

  static const String colorField = "color";

  static const String categoryField = "category";

  static const String subCategoryField = "subCategory";

  static const String filtersField = "filters";

  // static const String catField = "fields";
  // static const String keyField = "key";
  // static const String likesCountField = "likes_count";
  // static const String commentsCountField = "comments_count";
  // static const String postUserField = "user";
  // static const String createdAtField = "created_at";

  // static const String postCatField = "category";
}
