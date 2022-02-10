import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.title, this.imageUrl, this.id);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(
        context); // to solve the issue in the async! for onPress to delete item
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              color: Theme.of(context).errorColor,
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Deleted successfully',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } catch (error) {
                  // the Scaffold.of(context) is not working inside an async!
                  // up in the build method we create a scaffold = Scaffold.of()context;
                  //to be able to use it here to show the snackbar.
                  scaffold.showSnackBar(const SnackBar(
                    content: Text(
                      'Deleting failed',
                      textAlign: TextAlign.center,
                    ),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
