import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

// import '../providers/room_provider.dart';
import '../providers/rooms_provider.dart';
import '../screens/room_detail_screen.dart';

// ignore: must_be_immutable
class RoomItem extends StatelessWidget {
  final String title;
  final String location;
  final String building;

  bool gridView;

  RoomItem({
    @required this.title,
    @required this.location,
    @required this.building,
    this.gridView = false,
  });

  void selectRoom(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(RoomDetailScreen.routeName, arguments: {
      'title': title,
      'location': location,
      'building': building,
    }).then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final room = Provider.of<Room>(context, listen: false);
    // final roomsList = Provider.of<Rooms>(context, listen: false);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        Consumer<Rooms>(
          builder: (ctx, roomsList, child) => IconSlideAction(
            icon: roomsList.findByName(title).isFavourite
                ? Icons.favorite
                : Icons.favorite_border,
            caption: 'Favourite',
            color: Theme.of(context).primaryColor,
            // icon: Icons.favorite,
            closeOnTap: true,
            foregroundColor: Colors.white,
            onTap: () {
              roomsList.toggleFavourite(title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Room added to favourites'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    textColor: Colors.cyan,
                    onPressed: () {
                      roomsList.toggleFavourite(title);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
      child: Column(
        children: [
          InkWell(
            onTap: () => selectRoom(context),
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(1),
            child: gridView
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: GridTile(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        footer: Text(
                          location,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      horizontalTitleGap: 0,
                      title: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                      subtitle: Text(
                        location,
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     roomsList.findByName(title).isFavourite
                      //         ? Icons.star
                      //         : Icons.star_border,
                      //     size: 30,
                      //   ),
                      //   color: Theme.of(context).iconTheme.color,
                      //   splashRadius: 1,
                      //   onPressed: () => roomsList.toggleFavourite(title),
                      // ),
                    ),
                    height: 75,
                  ),
          ),
          Divider(
            height: 0,
            thickness: 1.5,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}
