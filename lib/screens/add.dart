/*import 'package:eventsapp/providers/photographer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class addd extends StatelessWidget {
  const addd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pink1 = const Color(0xFFFCABB4);
    final pink2 = const Color(0xFFFC9BA5);
    final darkpink = const Color(0xFFD66E79);
    final lightpink = const Color(0xFFFDD5D9);
    final pink3 = const Color(0xFFFDBAC1);
    final pink4 = const Color(0xFFE4AAAD);
    return Container(
      child: Consumer<addPhotographers>(
        builder: (_, value, __) => ListView.builder(
            itemCount: value.photographerlist.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.3),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                value.photographerlist[index].name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                value.photographerlist[index].description,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ),
                            ListTile(
                              title: Text("contact number",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16, color: pink1)),
                              subtitle: Text(
                                value.photographerlist[index].contact,
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
*/