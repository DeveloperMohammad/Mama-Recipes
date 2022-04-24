import 'package:flutter/material.dart';
import 'package:mama_recipes/widgets/change_theme_button_widget.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          iconTheme: IconThemeData(
            color: Theme.of(context).iconTheme.color,
          ),
          centerTitle: true,
          title: Text(
            'تنظیمات',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Column(
          children: [
            Row(
              children: const [
                SizedBox(width: 30),
                Text('حالت شب', style: TextStyle(fontSize: 20),),
                ChangeThemeButtonWidget(),
              ],
            ),
            Divider(color: Theme.of(context).iconTheme.color),
            
          ],
        ),
      ),
    );
  }
}
