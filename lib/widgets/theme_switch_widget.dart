import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    super.key,
  });

  // onPressed for changing theme of app
  void _onSlideSwitch(BuildContext context, bool isLightTheme) {
    if (!isLightTheme) {
      context.read<ThemeSwitchBloc>().add(SwitchOffEvent());
    } else {
      context.read<ThemeSwitchBloc>().add(SwitchOnEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.folder),
      title: const Text("Theme"),
      trailing: BlocBuilder<ThemeSwitchBloc, ThemeSwitchState>(
        builder: (context, state) {
          return Switch(
            value: state.switchValue,
            onChanged: (newValue) => _onSlideSwitch(context, newValue),
          );
        },
      ),
    );
  }
}
