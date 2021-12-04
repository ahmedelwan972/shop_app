import 'package:ayop01/layout/shop_layout/cubit/cubit.dart';
import 'package:ayop01/layout/todo!app/cubit.dart';
import 'package:ayop01/modules/news_app/web_view/web_view.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.teal,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget defaultTextField({
  required String label,
  required TextInputType type,
  required TextEditingController controller,
  required IconData prefix,
  required FormFieldValidator validate,
  IconData? suffix,
  double radius = 0.0,
  bool obscureText = false,
  Function? suffixPressed,
  Function? onTapUp,
  Function? onChange,
  Function? onSubmitted,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted:(s)
      {
        onSubmitted!(s);
      } ,
      onChanged: onChange!('s'),
      onTap: ()
      {
        onTapUp!();
      },
      keyboardType: type,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  {
                    suffixPressed!();
                  }
                },
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      validator: validate,
    );
//a//aa//a
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              child: Text(
                '${model['time']}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabase(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabase(status: 'archive', id: model['id']);
              },
              icon: Icon(
                Icons.archive_outlined,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );

Widget buildArticalItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            if('${article['urlToImage']}'.isNotEmpty)
              Container(

              width: 120.0,
              height: 120.0,
              // child: FadeInImage.assetNetwork(placeholder: 'assets/image/male.png.png', image: '${article['urlToImage']}' ,fit: BoxFit.cover, ),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
                decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                   image: DecorationImage(
                     image: NetworkImage(
                         '${article['urlToImage']}'
                     )  ,
                    fit: BoxFit.cover),
               ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                width: 120.0,
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );


void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context , widget)
{
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ), (route)=> false,
  );
}


Widget buildListItem(models, context , {bool isOldPrice = true}) => Container(
  padding: EdgeInsets.all(20),
  width: double.infinity,
  child: Row(
    children: [
      Stack(
        children: [
          Image(
            image: NetworkImage('${models.image}'),
            width: 120,
            height: 120,
          ),
          if (models.discount != 0 && isOldPrice )
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Text(
                'DISCOUNT',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              color: Colors.red,
            ),
        ],
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 215,
            child: Text(
              '${models.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                height: 1.35,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${models.price}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                if (models.discount != 0 && isOldPrice )
                  Text(
                    '${models.oldPrice}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                //SizedBox(width: 90,),
                Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeFav(models.id!);
                  },
                  icon: CircleAvatar(
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: ShopCubit.get(context)
                        .favorites[models.id]!
                        ? Colors.red
                        : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
);



