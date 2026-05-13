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
  /// **'Enter a correct quantity'**
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
  /// **'Exceeds available quantity'**
  String get cantidadSuperior;

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

  /// No description provided for @contrasenaActualMensaje.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get contrasenaActualMensaje;

  /// No description provided for @contrasenaActualIncorrecta.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect,please try again'**
  String get contrasenaActualIncorrecta;

  /// No description provided for @contrasenaActualizada.
  ///
  /// In en, this message translates to:
  /// **'Password has been updated'**
  String get contrasenaActualizada;

  /// No description provided for @contrasenaNoCoincide.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get contrasenaNoCoincide;

  /// No description provided for @devolverProducto.
  ///
  /// In en, this message translates to:
  /// **'Return product'**
  String get devolverProducto;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

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
  /// **'The quantity format is incorrect'**
  String get formatoCantidadIncorrecto;

  /// No description provided for @formatoIncorrecto.
  ///
  /// In en, this message translates to:
  /// **'Incorrect format'**
  String get formatoIncorrecto;

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

  /// No description provided for @introducirCantidad.
  ///
  /// In en, this message translates to:
  /// **'Introducir the quantity'**
  String get introducirCantidad;

  /// No description provided for @introducirNombre.
  ///
  /// In en, this message translates to:
  /// **'Enter the name'**
  String get introducirNombre;

  /// No description provided for @introducirTipo.
  ///
  /// In en, this message translates to:
  /// **'Enter the type'**
  String get introducirTipo;

  /// No description provided for @introducirUsuarioONombre.
  ///
  /// In en, this message translates to:
  /// **'Enter the user or name'**
  String get introducirUsuarioONombre;

  /// No description provided for @inventario.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventario;

  /// No description provided for @miPerfil.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get miPerfil;

  /// No description provided for @modificarContrasenaMensaje.
  ///
  /// In en, this message translates to:
  /// **'Password modified successfully'**
  String get modificarContrasenaMensaje;

  /// No description provided for @modificarInventario.
  ///
  /// In en, this message translates to:
  /// **'Edit inventory'**
  String get modificarInventario;

  /// No description provided for @modificarProducto.
  ///
  /// In en, this message translates to:
  /// **'Edit product'**
  String get modificarProducto;

  /// No description provided for @modificarProductoMensaje.
  ///
  /// In en, this message translates to:
  /// **'Product modified successfully'**
  String get modificarProductoMensaje;

  /// No description provided for @modificarUsuario.
  ///
  /// In en, this message translates to:
  /// **'Edit user'**
  String get modificarUsuario;

  /// No description provided for @modificarUsuarioMensaje.
  ///
  /// In en, this message translates to:
  /// **'User modified successfully'**
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
  /// **'New location added successfully'**
  String get nuevaUbicacionMensaje;

  /// No description provided for @nuevoProductoMensaje.
  ///
  /// In en, this message translates to:
  /// **'Product added successfully'**
  String get nuevoProductoMensaje;

  /// No description provided for @nuevoTipoMensaje.
  ///
  /// In en, this message translates to:
  /// **'New type added successfully'**
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
  /// **'New account: Please change your password to complete your first log in'**
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

  /// No description provided for @perfil.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get perfil;

  /// No description provided for @peticionCorrecta.
  ///
  /// In en, this message translates to:
  /// **'Request completed successfully'**
  String get peticionCorrecta;

  /// No description provided for @productoBorrado.
  ///
  /// In en, this message translates to:
  /// **'Product deleted successfully'**
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

  /// No description provided for @tipo.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get tipo;

  /// No description provided for @tipoProducto.
  ///
  /// In en, this message translates to:
  /// **'Product type'**
  String get tipoProducto;

  /// No description provided for @tipoRegistro.
  ///
  /// In en, this message translates to:
  /// **'Registration type'**
  String get tipoRegistro;

  /// No description provided for @ubicacion.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get ubicacion;

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

  /// No description provided for @usuarios.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usuarios;

  /// No description provided for @usuarioEliminado.
  ///
  /// In en, this message translates to:
  /// **'User deleted'**
  String get usuarioEliminado;

  /// No description provided for @vaciar.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get vaciar;

  /// No description provided for @volver.
  ///
  /// In en, this message translates to:
  /// **'Back'**
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
