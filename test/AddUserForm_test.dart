import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations_es.dart';
import 'package:proyecto_dam_2526/viewmodel/addUserForm_viewmodel.dart';

void main() {
  late AdduserFormViewmodel viewModel;
  late AppLocalizations l10n;

  setUp(() {
    viewModel = AdduserFormViewmodel();
    l10n = AppLocalizationsEs();
  });

  group('Pruebas de valicación de formuluario de añadir usuario', () {
    test('checkName devuelve null si está valido', () {
      expect(viewModel.checkName("Juan Pérez", l10n), null);
    });
    test('checkName devuelve error si está vacio', () {
      expect(viewModel.checkName("", l10n), l10n.campoVacio);
    });

    test('checkName devuelve error si se introduce un numero en el campo del nombre', () {
      expect(viewModel.checkName("12", l10n), l10n.formatoNombreIncorrecto);
    });

    test('checkUser devuelve null si está valido', () {
      expect(viewModel.checkUser("Juan12", l10n), null);
    });
    test('checkName devuelve error si está vacio', () {
      expect(viewModel.checkUser("", l10n), l10n.campoVacio);
    });

    test(
      'checkRole devuelve error si no se ha seleccionado ningún usuario ',
      () {
        expect(viewModel.checkRole("", l10n), l10n.campoVacio);
      },
    );
    test('checkRole devuelve null si  se ha seleccionado ningún usuario ', () {
      expect(viewModel.checkRole("Administrador", l10n), null);
    });
  });
}
