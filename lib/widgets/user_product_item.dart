import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserProductItem(this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
        ),
      ),
      trailing: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.24,
          //width: 90,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
