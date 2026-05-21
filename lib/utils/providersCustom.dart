import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/addUserForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/getProduct_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/historyRegister_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/inventoryScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/loginForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyUserForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/newUserPasswordForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/profileForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';

class ProvidersCustom {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => AddProductFormViewModel()),
    ChangeNotifierProvider(create: (context) => ModifyProductFormViewmodel()),
    ChangeNotifierProvider(create: (context) => LoginFormViewmodel()),
    ChangeNotifierProvider(
      create: (context) => AdministrationscreenViewmodel(),
    ),
    ChangeNotifierProvider(create: (context) => AdduserFormViewmodel()),
    ChangeNotifierProvider(create: (context) => ProfileFormViewmodel()),
    ChangeNotifierProvider(create: (context) => ModifyUserFormViewmodel()),
    ChangeNotifierProvider(create: (context) => InventoryScreenViewmodel()),
    ChangeNotifierProvider(create: (context) => GetProductViewmodel()),
    ChangeNotifierProvider(create: (context) => MessagesViewmodel()),
    ChangeNotifierProvider(create: (context) => SupabaseService()),
    ChangeNotifierProvider(create: (context) => AuthService()),
    ChangeNotifierProvider(create: (context) => NewUserPasswordFormViewModel()),
    ChangeNotifierProvider(create: (context) => ThemeViewmodel()),
    ChangeNotifierProvider(create: (context) => HistoryRegisterViewmodel()),
  ];
}
