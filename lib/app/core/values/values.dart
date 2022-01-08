const double kRadius = 15;

///24
const double kFontSizeXL = 24;

///16
const double kFontSizeM = 16;

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
const double kProductHeight = 250;
const double kProductWidth = 200;

//*product quantity
///10
const double kProductMaxQuantity = 10;

///1
const double kProductMinQuantity = 1;
