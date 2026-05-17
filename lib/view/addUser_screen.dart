import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/newUser.dart';
import 'package:proyecto_dam_2526/model/user.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/addUserForm_viewmodel.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _userFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  bool obscureText = true;
  String? selectedRol;
  final checkForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(() {
      _focusChange(
        _nameFocus,
        context.read<AdduserFormViewmodel>().nameController,
        context.read<AdduserFormViewmodel>().nameController,
      );
    });
    _userFocus.addListener(() {
      _focusChange(
        _userFocus,
        context.read<AdduserFormViewmodel>().userController,
        context.read<AdduserFormViewmodel>().userController,
      );
    });
    _emailFocus.addListener(() {
      _focusChange(
        _emailFocus,
        context.read<AdduserFormViewmodel>().emailController,
        context.read<AdduserFormViewmodel>().emailController,
      );
    });
  }

  @override
  void dispose() {
    _nameFocus.removeListener(() {
      _focusChange(
        _nameFocus,
        context.read<AdduserFormViewmodel>().nameController,
        context.read<AdduserFormViewmodel>().nameController,
      );
    });
    _userFocus.removeListener(() {
      _focusChange(
        _userFocus,
        context.read<AdduserFormViewmodel>().userController,
        context.read<AdduserFormViewmodel>().userController,
      );
    });
    _emailFocus.removeListener(() {
      _focusChange(
        _emailFocus,
        context.read<AdduserFormViewmodel>().emailController,
        context.read<AdduserFormViewmodel>().emailController,
      );
    });
    super.dispose();
  }

  void _focusChange(
    FocusNode focusNode,
    TextEditingController controllerOrigen,
    TextEditingController controllerDestino,
  ) {
    if (!focusNode.hasFocus) {
      controllerOrigen.text = controllerDestino.text.trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.anadirUsuario)),
      body: Form(
        key: checkForm,
        child: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        focusNode: _nameFocus,
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .nameController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkName(value, l10n),
                        decoration: InputDecoration(
                          label: Text(l10n.nombre),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        focusNode: _userFocus,
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .userController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkUser(value, l10n),
                        decoration: InputDecoration(
                          label: Text(l10n.usuario),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        focusNode: _emailFocus,
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .emailController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkEmail(value, l10n),
                        decoration: InputDecoration(
                          label: Text(l10n.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: obscureText,
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .passwordController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkPassword(value, l10n),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          label: Text(l10n.contrasena),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Consumer<SupabaseService>(
                        builder: (context, values, child) {
                          final roles = values.roles;
                          return DropdownButtonFormField<String>(
                            key: context
                                .read<AdduserFormViewmodel>()
                                .dropDownKey,
                            initialValue: context
                                .read<AdduserFormViewmodel>()
                                .role,
                            validator: (value) => context
                                .read<AdduserFormViewmodel>()
                                .checkRole(value, l10n),
                            decoration: InputDecoration(
                              label: Text(l10n.rol),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            items: roles
                                .map(
                                  (role) => DropdownMenuItem<String>(
                                    value: role['role'],
                                    child: Text(role['role']),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              context.read<AdduserFormViewmodel>().role = value;
                            },
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (checkForm.currentState!.validate()) {
                              int? idRole =
                                  await context
                                      .read<SupabaseService>()
                                      .getIdRoleFromNameRole(
                                        context
                                            .read<AdduserFormViewmodel>()
                                            .role!,
                                      ) ??
                                  2;
                              bool? added = await context
                                  .read<AuthService>()
                                  .createNewUser(
                                    NewUser(
                                      email: context
                                          .read<AdduserFormViewmodel>()
                                          .emailController
                                          .text,
                                      name: context
                                          .read<AdduserFormViewmodel>()
                                          .nameController
                                          .text,
                                      username: context
                                          .read<AdduserFormViewmodel>()
                                          .userController
                                          .text,
                                      password: context
                                          .read<AdduserFormViewmodel>()
                                          .passwordController
                                          .text,
                                      idRole: idRole,
                                    ),
                                    context,
                                    l10n,
                                  );
                              if (added == true) {
                                context
                                    .read<AdduserFormViewmodel>()
                                    .clearForm();
                                Navigator.pop(context, true);
                              }
                            }
                          },
                          child: Text(l10n.enviar),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AdduserFormViewmodel>().clearForm();
                          },
                          child: Text(l10n.vaciar),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        focusNode: _nameFocus,
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .nameController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkName(value, l10n),
                        decoration: InputDecoration(
                          label: Text(l10n.nombre),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        focusNode: _userFocus,
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .userController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkUser(value, l10n),
                        decoration: InputDecoration(
                          label: Text(l10n.usuario),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        focusNode: _emailFocus,
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .emailController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkEmail(value, l10n),
                        decoration: InputDecoration(
                          label: Text(l10n.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: obscureText,
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .passwordController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkPassword(value, l10n),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          label: Text(l10n.contrasena),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: FutureBuilder(
                        future: context.read<DatabaseService>().showRoles(),
                        builder: (context, snapshot) {
                          final roles = snapshot.data ?? [];
                          return DropdownButtonFormField(
                            initialValue: context
                                .read<AdduserFormViewmodel>()
                                .role,
                            key: context
                                .read<AdduserFormViewmodel>()
                                .dropDownKey,
                            validator: (value) => context
                                .read<AdduserFormViewmodel>()
                                .checkRole(value, l10n),
                            decoration: InputDecoration(
                              label: Text(l10n.rol),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            items: roles
                                .map(
                                  (rol) => DropdownMenuItem(
                                    value: rol,
                                    child: Text(rol),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              context.read<AdduserFormViewmodel>().role = value;
                            },
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (checkForm.currentState!.validate()) {
                              context.read<DatabaseService>().addUser(
                                User(
                                  email: context
                                      .read<AdduserFormViewmodel>()
                                      .emailController
                                      .text,
                                  name: context
                                      .read<AdduserFormViewmodel>()
                                      .nameController
                                      .text,
                                  username: context
                                      .read<AdduserFormViewmodel>()
                                      .userController
                                      .text,
                                  password: context
                                      .read<AdduserFormViewmodel>()
                                      .passwordController
                                      .text,
                                  role: context
                                      .read<AdduserFormViewmodel>()
                                      .role!,
                                ),
                              );
                              context.read<AdduserFormViewmodel>().clearForm();
                              Navigator.pop(context, true);
                            }
                          },
                          child: Text(l10n.enviar),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AdduserFormViewmodel>().clearForm();
                          },
                          child: Text(l10n.vaciar),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
