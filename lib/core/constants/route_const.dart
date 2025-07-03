class RoutePath{
  const RoutePath._();

  // Full screen routes section
  static const initial = '/';
  static const splash = '/splash';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgetPassword = '/forget-password';
  static const dashboard = '/dashboard';
  
  // Tab view routes section
  static const home = '/home';
  static const product = '/product';
  static const category = '/category';
  static const banner = '/banner';
  static const profile = '/profile';

  // Nested Tab view routes for product
  static const productCreate = '/product/create';
  static const productEdit = '/product/:id/edit';

  // Nested Tab view routes for product
  static const categoryCreate = '/category/create';
  static const categoryEdit = '/category/:id/edit';

  // Nested Tab view routes for product
  static const bannerCreate = '/banner/create';
  static const bannerEdit = '/banner/:id/edit';

  // Nested Tab view routes section
  static const editProfile = '$profile/edit-profile';
  static const setting = '$profile/setting';
  static const notification = '$profile/notiflcation';
  static const privacy = '$profile/privacy';
  static const favourite = '$profile/favourite';

}

class RouteName{
  const RouteName._();

  // Full screen routes section
  static const initial = 'initial';
  static const splash = 'splash';
  static const signIn = 'sign-in';
  static const signUp = 'sign-up';
  static const forgetPassword = 'forget-password';
  static const dashboard = 'dashboard';

  // Tab view routes section
  static const home = 'home';
  static const product = 'product';
  static const category = 'category';
  static const banner = 'banner';
  static const profile = 'profile';

  // Nested Tab view routes for product
  static const productCreate = 'product-create';
  static const productEdit = 'product-edit';

  // Nested Tab view routes for product
  static const categoryCreate = 'category-create';
  static const categoryEdit = 'category-edit';

  // Nested Tab view routes for product
  static const bannerCreate = 'banner-create';
  static const bannerEdit = 'banner-edit';

  // Nested Tab view routes section
  static const editProfile = 'edit-profile';
  static const setting = 'setting';
  static const notification = 'notiflcation';
  static const privacy = 'privacy';
  static const favourite = 'favourite';

}
