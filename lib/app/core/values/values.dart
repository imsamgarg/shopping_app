const double radius = 15;

///24
const double fontSizeXL = 24;

///16
const double fontSizeM = 16;

enum ScreenSize {
  sm,
  md,
  lg,
  xl,
}

//* for productlist view filterings
enum SortBy { popularity, priceLTH, priceHTL }

//* dynamic links
enum DynamicLinkType { product, subCategory, order, offer }

//*for cart view
enum ProductAvailability {
  available,
  notAvailable,
  colorNotAvailable,
  sizeNotAvailable,

  //* if product removed from database
  productDeleted,
}

//for payment method
enum PaymentMethod {
  cashOnDelivery,
  prepaid,
}
const double sm = 400;
const double md = 500;
const double lg = 600;
const double xl = 700;

//*product cart sizes
const double productHeight = 250;
const double productWidth = 200;

//*product quantity
///10
const double productMaxQuantity = 10;

///1
const double productMinQuantity = 1;
