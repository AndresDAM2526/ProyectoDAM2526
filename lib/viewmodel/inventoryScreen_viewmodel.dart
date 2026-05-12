import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/widgets/filter_widget.dart';

class InventoryScreenViewmodel extends ChangeNotifier {
  void showFilterDialog(BuildContext context) async {
    List<String?>? dialog = await showDialog<List<String?>?>(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 2
                : MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FilterWidget(),
          ),
        );
      },
    );
    if (dialog != null) {
      context.read<SupabaseService>().getFilteredProducts(dialog[0], dialog[1]);
    }
  }
}
