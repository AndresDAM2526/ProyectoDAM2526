import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @accHintActualPass.
  ///
  /// In en, this message translates to:
  /// **'Field to enter the current password'**
  String get accHintActualPass;

  /// No description provided for @accHintApartadoIdioma.
  ///
  /// In en, this message translates to:
  /// **'Section to change the language'**
  String get accHintApartadoIdioma;

  /// No description provided for @accHintApartadoModificarPropiedadesInventario.
  ///
  /// In en, this message translates to:
  /// **'Section to modify inventory properties'**
  String get accHintApartadoModificarPropiedadesInventario;

  /// No description provided for @accHintApartadoModificarUbicaciones.
  ///
  /// In en, this message translates to:
  /// **'Section to modify locations'**
  String get accHintApartadoModificarUbicaciones;

  /// No description provided for @accHintApartadoModoOscuro.
  ///
  /// In en, this message translates to:
  /// **'Section to change the application style'**
  String get accHintApartadoModoOscuro;

  /// No description provided for @accHintApartadoTamanoFuente.
  ///
  /// In en, this message translates to:
  /// **'Section to change the font size'**
  String get accHintApartadoTamanoFuente;

  /// No description provided for @accHintApartadoTiposProducto.
  ///
  /// In en, this message translates to:
  /// **'Section to modify product types'**
  String get accHintApartadoTiposProducto;

  /// No description provided for @accHintApartadoUsuarios.
  ///
  /// In en, this message translates to:
  /// **'Section to modify user properties'**
  String get accHintApartadoUsuarios;

  /// No description provided for @accHintBarraTamanioFuente.
  ///
  /// In en, this message translates to:
  /// **'Bar to change the font size'**
  String get accHintBarraTamanioFuente;

  /// No description provided for @accHintBtnAceptar.
  ///
  /// In en, this message translates to:
  /// **'Button to accept'**
  String get accHintBtnAceptar;

  /// No description provided for @accHintBtnAdministracion.
  ///
  /// In en, this message translates to:
  /// **'Button that redirects to the administration section'**
  String get accHintBtnAdministracion;

  /// No description provided for @accHintBtnAnadirProducto.
  ///
  /// In en, this message translates to:
  /// **'Button to save the new product in the inventory'**
  String get accHintBtnAnadirProducto;

  /// No description provided for @accHintBtnAnadirTipoProducto.
  ///
  /// In en, this message translates to:
  /// **'Button to add a product type'**
  String get accHintBtnAnadirTipoProducto;

  /// No description provided for @accHintBtnAnadirUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Button to add a new location'**
  String get accHintBtnAnadirUbicacion;

  /// No description provided for @accHintBtnApartadoModificarUsuarios.
  ///
  /// In en, this message translates to:
  /// **'Button that redirects to the modify users section'**
  String get accHintBtnApartadoModificarUsuarios;

  /// No description provided for @accHintBtnBorrarElemento.
  ///
  /// In en, this message translates to:
  /// **'Deletes the selected element from the database'**
  String get accHintBtnBorrarElemento;

  /// No description provided for @accHintBtnBorrarTipoProducto.
  ///
  /// In en, this message translates to:
  /// **'Button to delete a product type'**
  String get accHintBtnBorrarTipoProducto;

  /// No description provided for @accHintBtnBorrarUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Button to delete a location'**
  String get accHintBtnBorrarUbicacion;

  /// No description provided for @accHintBtnCancelar.
  ///
  /// In en, this message translates to:
  /// **'Button to cancel'**
  String get accHintBtnCancelar;

  /// No description provided for @accHintBtnCerrarSesion.
  ///
  /// In en, this message translates to:
  /// **'Button that closes the session'**
  String get accHintBtnCerrarSesion;

  /// No description provided for @accHintBtnEnviar.
  ///
  /// In en, this message translates to:
  /// **'Processes and sends the current form data'**
  String get accHintBtnEnviar;

  /// No description provided for @accHintBtnFiltrar.
  ///
  /// In en, this message translates to:
  /// **'Button to filter'**
  String get accHintBtnFiltrar;

  /// No description provided for @accHintBtnFormAnadirProducto.
  ///
  /// In en, this message translates to:
  /// **'Button to display the add product form'**
  String get accHintBtnFormAnadirProducto;

  /// No description provided for @accHintBtnFormAnadirUsuario.
  ///
  /// In en, this message translates to:
  /// **'Button to display the add user form'**
  String get accHintBtnFormAnadirUsuario;

  /// No description provided for @accHintBtnFormCambioPass.
  ///
  /// In en, this message translates to:
  /// **'Button that displays a form to change the password'**
  String get accHintBtnFormCambioPass;

  /// No description provided for @accHintBtnFormModificar.
  ///
  /// In en, this message translates to:
  /// **'Button that displays the form to modify the element'**
  String get accHintBtnFormModificar;

  /// No description provided for @accHintBtnFormModificarProducto.
  ///
  /// In en, this message translates to:
  /// **'Button that displays the form to modify a product'**
  String get accHintBtnFormModificarProducto;

  /// No description provided for @accHintBtnFormProducto.
  ///
  /// In en, this message translates to:
  /// **'Button to display the add product form'**
  String get accHintBtnFormProducto;

  /// No description provided for @accHintBtnHistorial.
  ///
  /// In en, this message translates to:
  /// **'Button that redirects to the history section'**
  String get accHintBtnHistorial;

  /// No description provided for @accHintBtnIniciarSesion.
  ///
  /// In en, this message translates to:
  /// **'Button to log in'**
  String get accHintBtnIniciarSesion;

  /// No description provided for @accHintBtnListadoMovimientos.
  ///
  /// In en, this message translates to:
  /// **'Button that redirects to the movements page'**
  String get accHintBtnListadoMovimientos;

  /// No description provided for @accHintBtnMiPerfil.
  ///
  /// In en, this message translates to:
  /// **'Button that redirects to my profile'**
  String get accHintBtnMiPerfil;

  /// No description provided for @accHintBtnModificar.
  ///
  /// In en, this message translates to:
  /// **'Button that displays a form to modify user properties'**
  String get accHintBtnModificar;

  /// No description provided for @accHintBtnModificarInventario.
  ///
  /// In en, this message translates to:
  /// **'Button to modify the inventory'**
  String get accHintBtnModificarInventario;

  /// No description provided for @accHintBtnModificarUsuario.
  ///
  /// In en, this message translates to:
  /// **'Saves changes for the selected user'**
  String get accHintBtnModificarUsuario;

  /// No description provided for @accHintBtnMostrarPass.
  ///
  /// In en, this message translates to:
  /// **'Button to show or hide the password in plain text'**
  String get accHintBtnMostrarPass;

  /// No description provided for @accHintBtnVolver.
  ///
  /// In en, this message translates to:
  /// **'Button to go back'**
  String get accHintBtnVolver;

  /// No description provided for @accHintCampoBuscarProducto.
  ///
  /// In en, this message translates to:
  /// **'Field to search for a product by name'**
  String get accHintCampoBuscarProducto;

  /// No description provided for @accHintCampoBuscarRegistro.
  ///
  /// In en, this message translates to:
  /// **'Field to search for a log by name'**
  String get accHintCampoBuscarRegistro;

  /// No description provided for @accHintCampoBuscarUsuario.
  ///
  /// In en, this message translates to:
  /// **'Field to search for a user by name or username'**
  String get accHintCampoBuscarUsuario;

  /// No description provided for @accHintCampoCantidad.
  ///
  /// In en, this message translates to:
  /// **'Field to enter the quantity'**
  String get accHintCampoCantidad;

  /// No description provided for @accHintCampoCorreo.
  ///
  /// In en, this message translates to:
  /// **'Field to enter the email'**
  String get accHintCampoCorreo;

  /// No description provided for @accHintCampoNombre.
  ///
  /// In en, this message translates to:
  /// **'Field with the name'**
  String get accHintCampoNombre;

  /// No description provided for @accHintCampoNombreUsuario.
  ///
  /// In en, this message translates to:
  /// **'Field to enter the username'**
  String get accHintCampoNombreUsuario;

  /// No description provided for @accHintCampoPass.
  ///
  /// In en, this message translates to:
  /// **'Field to enter the password'**
  String get accHintCampoPass;

  /// No description provided for @accHintCampoRol.
  ///
  /// In en, this message translates to:
  /// **'Field to select the role'**
  String get accHintCampoRol;

  /// No description provided for @accHintCampoRolPerfil.
  ///
  /// In en, this message translates to:
  /// **'Displays role information'**
  String get accHintCampoRolPerfil;

  /// No description provided for @accHintCampoTipoProducto.
  ///
  /// In en, this message translates to:
  /// **'Field to select the product type'**
  String get accHintCampoTipoProducto;

  /// No description provided for @accHintCampoUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Field to enter the location'**
  String get accHintCampoUbicacion;

  /// No description provided for @accHintCampoUbicacionProducto.
  ///
  /// In en, this message translates to:
  /// **'Field to select the location'**
  String get accHintCampoUbicacionProducto;

  /// No description provided for @accHintCampoUsuario.
  ///
  /// In en, this message translates to:
  /// **'Field to enter the user'**
  String get accHintCampoUsuario;

  /// No description provided for @accHintCampoUsuarioPerfil.
  ///
  /// In en, this message translates to:
  /// **'Displays the current username information'**
  String get accHintCampoUsuarioPerfil;

  /// No description provided for @accHintConfirmarPass.
  ///
  /// In en, this message translates to:
  /// **'Field to confirm the password'**
  String get accHintConfirmarPass;

  /// No description provided for @accHintDesplegableIdioma.
  ///
  /// In en, this message translates to:
  /// **'Dropdown to change the language'**
  String get accHintDesplegableIdioma;

  /// No description provided for @accHintLimpiarForm.
  ///
  /// In en, this message translates to:
  /// **'Clears all entered fields'**
  String get accHintLimpiarForm;

  /// No description provided for @accHintListadoRegistrosUsuario.
  ///
  /// In en, this message translates to:
  /// **'List with all log entries of a user'**
  String get accHintListadoRegistrosUsuario;

  /// No description provided for @accHintListadoResultados.
  ///
  /// In en, this message translates to:
  /// **'List with the search results'**
  String get accHintListadoResultados;

  /// No description provided for @accHintListadoTiposProducto.
  ///
  /// In en, this message translates to:
  /// **'List showing product types'**
  String get accHintListadoTiposProducto;

  /// No description provided for @accHintListadoTiposProductos.
  ///
  /// In en, this message translates to:
  /// **'List with all inventory product types'**
  String get accHintListadoTiposProductos;

  /// No description provided for @accHintListadoUbicaciones.
  ///
  /// In en, this message translates to:
  /// **'List showing locations'**
  String get accHintListadoUbicaciones;

  /// No description provided for @accHintMenuLateral.
  ///
  /// In en, this message translates to:
  /// **'Sidebar menu'**
  String get accHintMenuLateral;

  /// No description provided for @accHintNuevaPass.
  ///
  /// In en, this message translates to:
  /// **'Field to enter the new password'**
  String get accHintNuevaPass;

  /// No description provided for @accHintResultadoBusqueda.
  ///
  /// In en, this message translates to:
  /// **'List with the search results'**
  String get accHintResultadoBusqueda;

  /// No description provided for @accHintSelectorEstilo.
  ///
  /// In en, this message translates to:
  /// **'Selector to change the application style'**
  String get accHintSelectorEstilo;

  /// No description provided for @accHintTbProductos.
  ///
  /// In en, this message translates to:
  /// **'Table where inventory products appear'**
  String get accHintTbProductos;

  /// No description provided for @accHintTextoFiltros.
  ///
  /// In en, this message translates to:
  /// **'Text showing applied filters'**
  String get accHintTextoFiltros;

  /// No description provided for @accLabelActualPass.
  ///
  /// In en, this message translates to:
  /// **'Current password field'**
  String get accLabelActualPass;

  /// No description provided for @accLabelApartadoIdioma.
  ///
  /// In en, this message translates to:
  /// **'Language section'**
  String get accLabelApartadoIdioma;

  /// No description provided for @accLabelApartadoModificarPropiedadesInventario.
  ///
  /// In en, this message translates to:
  /// **'Modify inventory properties section'**
  String get accLabelApartadoModificarPropiedadesInventario;

  /// No description provided for @accLabelApartadoModificarUbicaciones.
  ///
  /// In en, this message translates to:
  /// **'Modify locations section'**
  String get accLabelApartadoModificarUbicaciones;

  /// No description provided for @accLabelApartadoModoOscuro.
  ///
  /// In en, this message translates to:
  /// **'Dark mode section'**
  String get accLabelApartadoModoOscuro;

  /// No description provided for @accLabelApartadoTamanoFuente.
  ///
  /// In en, this message translates to:
  /// **'Font size section'**
  String get accLabelApartadoTamanoFuente;

  /// No description provided for @accLabelApartadoTiposProducto.
  ///
  /// In en, this message translates to:
  /// **'Product types section'**
  String get accLabelApartadoTiposProducto;

  /// No description provided for @accLabelApartadoUsuarios.
  ///
  /// In en, this message translates to:
  /// **'Users section'**
  String get accLabelApartadoUsuarios;

  /// No description provided for @accLabelBarraTamanioFuente.
  ///
  /// In en, this message translates to:
  /// **'Font size change bar'**
  String get accLabelBarraTamanioFuente;

  /// No description provided for @accLabelBtnAceptar.
  ///
  /// In en, this message translates to:
  /// **'Accept button'**
  String get accLabelBtnAceptar;

  /// No description provided for @accLabelBtnAdministracion.
  ///
  /// In en, this message translates to:
  /// **'Administration button'**
  String get accLabelBtnAdministracion;

  /// No description provided for @accLabelBtnAnadirProducto.
  ///
  /// In en, this message translates to:
  /// **'Button to add a product'**
  String get accLabelBtnAnadirProducto;

  /// No description provided for @accLabelBtnAnadirTipoProducto.
  ///
  /// In en, this message translates to:
  /// **'Add product type button'**
  String get accLabelBtnAnadirTipoProducto;

  /// No description provided for @accLabelBtnAnadirUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Add location button'**
  String get accLabelBtnAnadirUbicacion;

  /// No description provided for @accLabelBtnApartadoModificarUsuarios.
  ///
  /// In en, this message translates to:
  /// **'Modify users button'**
  String get accLabelBtnApartadoModificarUsuarios;

  /// No description provided for @accLabelBtnBorrarElemento.
  ///
  /// In en, this message translates to:
  /// **'Delete button'**
  String get accLabelBtnBorrarElemento;

  /// No description provided for @accLabelBtnBorrarProducto.
  ///
  /// In en, this message translates to:
  /// **'Delete button'**
  String get accLabelBtnBorrarProducto;

  /// No description provided for @accLabelBtnBorrarTipoProducto.
  ///
  /// In en, this message translates to:
  /// **'Delete product type button'**
  String get accLabelBtnBorrarTipoProducto;

  /// No description provided for @accLabelBtnBorrarUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Delete location button'**
  String get accLabelBtnBorrarUbicacion;

  /// No description provided for @accLabelBtnCancelar.
  ///
  /// In en, this message translates to:
  /// **'Cancel button'**
  String get accLabelBtnCancelar;

  /// No description provided for @accLabelBtnCerrarSesion.
  ///
  /// In en, this message translates to:
  /// **'Log out button'**
  String get accLabelBtnCerrarSesion;

  /// No description provided for @accLabelBtnEnviar.
  ///
  /// In en, this message translates to:
  /// **'Send button'**
  String get accLabelBtnEnviar;

  /// No description provided for @accLabelBtnFiltrar.
  ///
  /// In en, this message translates to:
  /// **'Filter button'**
  String get accLabelBtnFiltrar;

  /// No description provided for @accLabelBtnFormAnadirProducto.
  ///
  /// In en, this message translates to:
  /// **'Add product button'**
  String get accLabelBtnFormAnadirProducto;

  /// No description provided for @accLabelBtnFormAnadirUsuario.
  ///
  /// In en, this message translates to:
  /// **'Add user button'**
  String get accLabelBtnFormAnadirUsuario;

  /// No description provided for @accLabelBtnFormCambioPass.
  ///
  /// In en, this message translates to:
  /// **'Change password button'**
  String get accLabelBtnFormCambioPass;

  /// No description provided for @accLabelBtnFormModificar.
  ///
  /// In en, this message translates to:
  /// **'Modify button'**
  String get accLabelBtnFormModificar;

  /// No description provided for @accLabelBtnFormModificarProducto.
  ///
  /// In en, this message translates to:
  /// **'Modify button'**
  String get accLabelBtnFormModificarProducto;

  /// No description provided for @accLabelBtnFormProducto.
  ///
  /// In en, this message translates to:
  /// **'Add product button'**
  String get accLabelBtnFormProducto;

  /// No description provided for @accLabelBtnHistorial.
  ///
  /// In en, this message translates to:
  /// **'History button'**
  String get accLabelBtnHistorial;

  /// No description provided for @accLabelBtnIniciarSesion.
  ///
  /// In en, this message translates to:
  /// **'Log in button'**
  String get accLabelBtnIniciarSesion;

  /// No description provided for @accLabelBtnListadoMovimientos.
  ///
  /// In en, this message translates to:
  /// **'Button to view movement history'**
  String get accLabelBtnListadoMovimientos;

  /// No description provided for @accLabelBtnMiPerfil.
  ///
  /// In en, this message translates to:
  /// **'My profile button'**
  String get accLabelBtnMiPerfil;

  /// No description provided for @accLabelBtnModificar.
  ///
  /// In en, this message translates to:
  /// **'Modify button'**
  String get accLabelBtnModificar;

  /// No description provided for @accLabelBtnModificarInventario.
  ///
  /// In en, this message translates to:
  /// **'Modify inventory button'**
  String get accLabelBtnModificarInventario;

  /// No description provided for @accLabelBtnModificarUsuario.
  ///
  /// In en, this message translates to:
  /// **'Button to modify a user'**
  String get accLabelBtnModificarUsuario;

  /// No description provided for @accLabelBtnMostrarPass.
  ///
  /// In en, this message translates to:
  /// **'Show password button'**
  String get accLabelBtnMostrarPass;

  /// No description provided for @accLabelBtnVolver.
  ///
  /// In en, this message translates to:
  /// **'Back button'**
  String get accLabelBtnVolver;

  /// No description provided for @accLabelCampoBuscarProducto.
  ///
  /// In en, this message translates to:
  /// **'Search product field'**
  String get accLabelCampoBuscarProducto;

  /// No description provided for @accLabelCampoBuscarRegistro.
  ///
  /// In en, this message translates to:
  /// **'Field to search for a log entry'**
  String get accLabelCampoBuscarRegistro;

  /// No description provided for @accLabelCampoBuscarUsuario.
  ///
  /// In en, this message translates to:
  /// **'Field to search for a user'**
  String get accLabelCampoBuscarUsuario;

  /// No description provided for @accLabelCampoCantidad.
  ///
  /// In en, this message translates to:
  /// **'Quantity field'**
  String get accLabelCampoCantidad;

  /// No description provided for @accLabelCampoCorreo.
  ///
  /// In en, this message translates to:
  /// **'Email field'**
  String get accLabelCampoCorreo;

  /// No description provided for @accLabelCampoNombre.
  ///
  /// In en, this message translates to:
  /// **'Name field'**
  String get accLabelCampoNombre;

  /// No description provided for @accLabelCampoNombreProducto.
  ///
  /// In en, this message translates to:
  /// **'Product name field'**
  String get accLabelCampoNombreProducto;

  /// No description provided for @accLabelCampoNombreUsuario.
  ///
  /// In en, this message translates to:
  /// **'Name field'**
  String get accLabelCampoNombreUsuario;

  /// No description provided for @accLabelCampoPass.
  ///
  /// In en, this message translates to:
  /// **'Password field'**
  String get accLabelCampoPass;

  /// No description provided for @accLabelCampoRol.
  ///
  /// In en, this message translates to:
  /// **'Role field'**
  String get accLabelCampoRol;

  /// No description provided for @accLabelCampoRolPerfil.
  ///
  /// In en, this message translates to:
  /// **'Role info field'**
  String get accLabelCampoRolPerfil;

  /// No description provided for @accLabelCampoTipoProducto.
  ///
  /// In en, this message translates to:
  /// **'Product type field'**
  String get accLabelCampoTipoProducto;

  /// No description provided for @accLabelCampoUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Location field'**
  String get accLabelCampoUbicacion;

  /// No description provided for @accLabelCampoUbicacionProducto.
  ///
  /// In en, this message translates to:
  /// **'Product location field'**
  String get accLabelCampoUbicacionProducto;

  /// No description provided for @accLabelCampoUsuario.
  ///
  /// In en, this message translates to:
  /// **'User field'**
  String get accLabelCampoUsuario;

  /// No description provided for @accLabelCampoUsuarioPerfil.
  ///
  /// In en, this message translates to:
  /// **'Username field'**
  String get accLabelCampoUsuarioPerfil;

  /// No description provided for @accLabelConfirmarPass.
  ///
  /// In en, this message translates to:
  /// **'Confirm password field'**
  String get accLabelConfirmarPass;

  /// No description provided for @accLabelDesplegableIdioma.
  ///
  /// In en, this message translates to:
  /// **'Dropdown with languages'**
  String get accLabelDesplegableIdioma;

  /// No description provided for @accLabelLimpiarForm.
  ///
  /// In en, this message translates to:
  /// **'Clear form button'**
  String get accLabelLimpiarForm;

  /// No description provided for @accLabelListadoRegistrosUsuario.
  ///
  /// In en, this message translates to:
  /// **'Logs list'**
  String get accLabelListadoRegistrosUsuario;

  /// No description provided for @accLabelListadoResultados.
  ///
  /// In en, this message translates to:
  /// **'Results list'**
  String get accLabelListadoResultados;

  /// No description provided for @accLabelListadoTiposProducto.
  ///
  /// In en, this message translates to:
  /// **'Product types list'**
  String get accLabelListadoTiposProducto;

  /// No description provided for @accLabelListadoTiposProductos.
  ///
  /// In en, this message translates to:
  /// **'Product types list'**
  String get accLabelListadoTiposProductos;

  /// No description provided for @accLabelListadoUbicaciones.
  ///
  /// In en, this message translates to:
  /// **'Locations list'**
  String get accLabelListadoUbicaciones;

  /// No description provided for @accLabelMenuLateral.
  ///
  /// In en, this message translates to:
  /// **'Sidebar menu'**
  String get accLabelMenuLateral;

  /// No description provided for @accLabelNuevaPass.
  ///
  /// In en, this message translates to:
  /// **'New password field'**
  String get accLabelNuevaPass;

  /// No description provided for @accLabelResultadoBusqueda.
  ///
  /// In en, this message translates to:
  /// **'Search result'**
  String get accLabelResultadoBusqueda;

  /// No description provided for @accLabelSelectorEstilo.
  ///
  /// In en, this message translates to:
  /// **'Style selector'**
  String get accLabelSelectorEstilo;

  /// No description provided for @accLabelTbProductos.
  ///
  /// In en, this message translates to:
  /// **'Products table'**
  String get accLabelTbProductos;

  /// No description provided for @accLabelTextoFiltros.
  ///
  /// In en, this message translates to:
  /// **'Text with filters'**
  String get accLabelTextoFiltros;

  /// No description provided for @acchintCampoNombreProducto.
  ///
  /// In en, this message translates to:
  /// **'Field to enter product name'**
  String get acchintCampoNombreProducto;

  /// No description provided for @aceptar.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get aceptar;

  /// No description provided for @administracion.
  ///
  /// In en, this message translates to:
  /// **'Administration'**
  String get administracion;

  /// No description provided for @ajustes.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get ajustes;

  /// No description provided for @anadir.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get anadir;

  /// No description provided for @anadirProducto.
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get anadirProducto;

  /// No description provided for @anadirTipo.
  ///
  /// In en, this message translates to:
  /// **'Add type'**
  String get anadirTipo;

  /// No description provided for @anadirUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get anadirUbicacion;

  /// No description provided for @anadirUsuario.
  ///
  /// In en, this message translates to:
  /// **'Add user'**
  String get anadirUsuario;

  /// No description provided for @borrarTipo.
  ///
  /// In en, this message translates to:
  /// **'Delete type'**
  String get borrarTipo;

  /// No description provided for @borrarUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Delete location'**
  String get borrarUbicacion;

  /// No description provided for @cambiarContrasena.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get cambiarContrasena;

  /// No description provided for @campoVacio.
  ///
  /// In en, this message translates to:
  /// **'Empty field'**
  String get campoVacio;

  /// No description provided for @cancelar.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelar;

  /// No description provided for @cantidad.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get cantidad;

  /// No description provided for @cantidadCorrecta.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid quantity'**
  String get cantidadCorrecta;

  /// No description provided for @cantidadIncorrecta.
  ///
  /// In en, this message translates to:
  /// **'Incorrect quantity'**
  String get cantidadIncorrecta;

  /// No description provided for @cantidadManual.
  ///
  /// In en, this message translates to:
  /// **'Enter quantity manually'**
  String get cantidadManual;

  /// No description provided for @cantidadNegativa.
  ///
  /// In en, this message translates to:
  /// **'Negative quantity'**
  String get cantidadNegativa;

  /// No description provided for @cantidadSuperior.
  ///
  /// In en, this message translates to:
  /// **'The quantity entered is higher than available'**
  String get cantidadSuperior;

  /// No description provided for @coger.
  ///
  /// In en, this message translates to:
  /// **'Get'**
  String get coger;

  /// No description provided for @confirmarBorradoProducto.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the product?'**
  String get confirmarBorradoProducto;

  /// No description provided for @confirmarBorradoUsuario.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the user?'**
  String get confirmarBorradoUsuario;

  /// No description provided for @confirmarContrasena.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmarContrasena;

  /// No description provided for @contrasena.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get contrasena;

  /// No description provided for @contrasenaActual.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get contrasenaActual;

  /// No description provided for @contrasenaActualIncorrecta.
  ///
  /// In en, this message translates to:
  /// **'The current password is not correct, please try again'**
  String get contrasenaActualIncorrecta;

  /// No description provided for @contrasenaActualMensaje.
  ///
  /// In en, this message translates to:
  /// **'Enter the current password'**
  String get contrasenaActualMensaje;

  /// No description provided for @contrasenaActualizada.
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get contrasenaActualizada;

  /// No description provided for @contrasenaCorta.
  ///
  /// In en, this message translates to:
  /// **'The password must be at least 6 characters'**
  String get contrasenaCorta;

  /// No description provided for @contrasenaNoCoincide.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get contrasenaNoCoincide;

  /// No description provided for @correoIncorrecto.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email format'**
  String get correoIncorrecto;

  /// No description provided for @definitivo.
  ///
  /// In en, this message translates to:
  /// **'Final'**
  String get definitivo;

  /// No description provided for @descripcion.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descripcion;

  /// No description provided for @devolver.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get devolver;

  /// No description provided for @devolverProducto.
  ///
  /// In en, this message translates to:
  /// **'Return product'**
  String get devolverProducto;

  /// No description provided for @duracion.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duracion;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailUsado.
  ///
  /// In en, this message translates to:
  /// **'The indicated email is already used'**
  String get emailUsado;

  /// No description provided for @enviar.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get enviar;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorBorrado.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete this record, foreign key constraint'**
  String get errorBorrado;

  /// No description provided for @errorCargaDatos.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorCargaDatos;

  /// No description provided for @fecha.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get fecha;

  /// No description provided for @filtrar.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filtrar;

  /// No description provided for @filtrarPor.
  ///
  /// In en, this message translates to:
  /// **'Filter by:'**
  String get filtrarPor;

  /// No description provided for @filtro.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filtro;

  /// No description provided for @formatoCantidadIncorrecto.
  ///
  /// In en, this message translates to:
  /// **'Quantity format is incorrect'**
  String get formatoCantidadIncorrecto;

  /// No description provided for @formatoIncorrecto.
  ///
  /// In en, this message translates to:
  /// **'Incorrect format'**
  String get formatoIncorrecto;

  /// No description provided for @formatoNombreIncorrecto.
  ///
  /// In en, this message translates to:
  /// **'The name cannot contain numbers'**
  String get formatoNombreIncorrecto;

  /// No description provided for @historial.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historial;

  /// No description provided for @idioma.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get idioma;

  /// No description provided for @informacion.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get informacion;

  /// No description provided for @iniciarSesion.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get iniciarSesion;

  /// No description provided for @inicioSesionIncorrecto.
  ///
  /// In en, this message translates to:
  /// **'Incorrect username and/or password'**
  String get inicioSesionIncorrecto;

  /// No description provided for @introducirCantidad.
  ///
  /// In en, this message translates to:
  /// **'Enter quantity'**
  String get introducirCantidad;

  /// No description provided for @introducirNombre.
  ///
  /// In en, this message translates to:
  /// **'Enter name'**
  String get introducirNombre;

  /// No description provided for @introducirTipo.
  ///
  /// In en, this message translates to:
  /// **'Enter type'**
  String get introducirTipo;

  /// No description provided for @introducirUsuarioONombre.
  ///
  /// In en, this message translates to:
  /// **'Enter user or name'**
  String get introducirUsuarioONombre;

  /// No description provided for @inventario.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventario;

  /// No description provided for @miPerfil.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get miPerfil;

  /// No description provided for @modificarContrasenaMensaje.
  ///
  /// In en, this message translates to:
  /// **'Password has been modified'**
  String get modificarContrasenaMensaje;

  /// No description provided for @modificarInventario.
  ///
  /// In en, this message translates to:
  /// **'Modify inventory'**
  String get modificarInventario;

  /// No description provided for @modificarProducto.
  ///
  /// In en, this message translates to:
  /// **'Modify product'**
  String get modificarProducto;

  /// No description provided for @modificarProductoMensaje.
  ///
  /// In en, this message translates to:
  /// **'Product has been modified'**
  String get modificarProductoMensaje;

  /// No description provided for @modificarUsuario.
  ///
  /// In en, this message translates to:
  /// **'Modify user'**
  String get modificarUsuario;

  /// No description provided for @modificarUsuarioMensaje.
  ///
  /// In en, this message translates to:
  /// **'User has been modified'**
  String get modificarUsuarioMensaje;

  /// No description provided for @modoOscuro.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get modoOscuro;

  /// No description provided for @mostrarContrasena.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get mostrarContrasena;

  /// No description provided for @nombre.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nombre;

  /// No description provided for @nombreApp.
  ///
  /// In en, this message translates to:
  /// **'Inventory Management'**
  String get nombreApp;

  /// No description provided for @nuevaContrasena.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get nuevaContrasena;

  /// No description provided for @nuevaContrasenaMensaje.
  ///
  /// In en, this message translates to:
  /// **'Enter the new password'**
  String get nuevaContrasenaMensaje;

  /// No description provided for @nuevaUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Enter the location'**
  String get nuevaUbicacion;

  /// No description provided for @nuevaUbicacionMensaje.
  ///
  /// In en, this message translates to:
  /// **'The new location has been added'**
  String get nuevaUbicacionMensaje;

  /// No description provided for @nuevoProductoMensaje.
  ///
  /// In en, this message translates to:
  /// **'Product added successfully'**
  String get nuevoProductoMensaje;

  /// No description provided for @nuevoTipoMensaje.
  ///
  /// In en, this message translates to:
  /// **'The new type has been added'**
  String get nuevoTipoMensaje;

  /// No description provided for @nuevoUsuario.
  ///
  /// In en, this message translates to:
  /// **'New user'**
  String get nuevoUsuario;

  /// No description provided for @nuevoUsuarioMensaje.
  ///
  /// In en, this message translates to:
  /// **'User added successfully'**
  String get nuevoUsuarioMensaje;

  /// No description provided for @nuevoUsuarioPantalla.
  ///
  /// In en, this message translates to:
  /// **'This account was recently created, you must change the password to log in for the first time'**
  String get nuevoUsuarioPantalla;

  /// No description provided for @obtener.
  ///
  /// In en, this message translates to:
  /// **'Get'**
  String get obtener;

  /// No description provided for @obtenerProducto.
  ///
  /// In en, this message translates to:
  /// **'Get product'**
  String get obtenerProducto;

  /// No description provided for @opciones.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get opciones;

  /// No description provided for @perfil.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get perfil;

  /// No description provided for @peticionCorrecta.
  ///
  /// In en, this message translates to:
  /// **'Your request has been successfully executed'**
  String get peticionCorrecta;

  /// No description provided for @producto.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get producto;

  /// No description provided for @productoBorrado.
  ///
  /// In en, this message translates to:
  /// **'The product has been deleted'**
  String get productoBorrado;

  /// No description provided for @quitarFiltro.
  ///
  /// In en, this message translates to:
  /// **'Remove filter'**
  String get quitarFiltro;

  /// No description provided for @rol.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get rol;

  /// No description provided for @seleccionarTipo.
  ///
  /// In en, this message translates to:
  /// **'Select a type'**
  String get seleccionarTipo;

  /// No description provided for @seleccionarUbicacion.
  ///
  /// In en, this message translates to:
  /// **'Select a location'**
  String get seleccionarUbicacion;

  /// No description provided for @sinResultados.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get sinResultados;

  /// No description provided for @tamanioFuente.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get tamanioFuente;

  /// No description provided for @temporal.
  ///
  /// In en, this message translates to:
  /// **'Temporal'**
  String get temporal;

  /// No description provided for @tipo.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get tipo;

  /// No description provided for @tipoEliminado.
  ///
  /// In en, this message translates to:
  /// **'Type deleted successfully'**
  String get tipoEliminado;

  /// No description provided for @tipoProducto.
  ///
  /// In en, this message translates to:
  /// **'Product type'**
  String get tipoProducto;

  /// No description provided for @tipoRegistro.
  ///
  /// In en, this message translates to:
  /// **'Log type'**
  String get tipoRegistro;

  /// No description provided for @ubicacion.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get ubicacion;

  /// No description provided for @ubicacionBorrada.
  ///
  /// In en, this message translates to:
  /// **'Location deleted'**
  String get ubicacionBorrada;

  /// No description provided for @unidadesDevolver.
  ///
  /// In en, this message translates to:
  /// **'Units to return'**
  String get unidadesDevolver;

  /// No description provided for @unidadesDisponibles.
  ///
  /// In en, this message translates to:
  /// **'Available units'**
  String get unidadesDisponibles;

  /// No description provided for @usuario.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get usuario;

  /// No description provided for @usuarioEliminado.
  ///
  /// In en, this message translates to:
  /// **'User deleted'**
  String get usuarioEliminado;

  /// No description provided for @usuarios.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usuarios;

  /// No description provided for @vaciar.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get vaciar;

  /// No description provided for @volver.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get volver;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
