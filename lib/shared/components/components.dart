import 'package:flutter/material.dart';

import '../../layouts/news_app/cubit/cubit.dart';
import '../../modules/news_app/web_view/web_view_screen.dart';
import 'constants.dart';


Widget defaultTextFormField({
  required String validateText,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  required IconData prefixIcon,
  Widget? suffixIcon,
  bool isPassword = false,
  Function? onSubmit,
  Function? onTap,
  Function? onChange,
  bool readOnly = false,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return validateText;
          }
        },
        onTap: () {
          onTap!();
        },
        readOnly: readOnly,
        obscureText: isPassword,
        controller: controller,
        onFieldSubmitted: (value) {
          onSubmit!();
        },
        onChanged: (value) {
          onChange!();
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          prefixIcon: Icon(prefixIcon,color: Colors.grey,),
          suffixIcon: suffixIcon,
        ),
      ),
    );


Widget buildArticle(List<dynamic> article,int number,context){
  return Container(
    color: NewsCubit.get(context).selectedItem==number && NewsCubit.get(context).isDesktop ? Colors.grey[200] : null,
    child: InkWell(
      onTap: (){
        navigateTo(context, WebViewScreen('${article[number]['url']}'));
        NewsCubit.get(context).selectedItemMethod(number);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:6.0),
              child: Container(
                width: 135.0,
                height: 135.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${article[number]['urlToImage']}'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              child: Container(
                height: 135.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('${article[number]['title']}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0)),
                    ),
                    Text('${article[number]['publishedAt']}',style: const TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildDivider(){
  return Padding(
    padding: const EdgeInsets.only(left: 20.0),
    child: Container(
      color: Colors.grey[300],
      height: 1.0,
      width: double.infinity,
    ),
  );
}

Widget buildArticleList({required List<dynamic> list,bool isSearch=false}){
  if(list.isNotEmpty) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticle(list, index, context),
        separatorBuilder: (context, index) => buildDivider(),
        itemCount: list.length);
  }
  else if(list.isEmpty && isSearch == true) {
    return Container();
  }
  else
  {
    return const Center(child: CircularProgressIndicator());
  }
}

Future navigateTo (context,widget){
  return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget
  ));
}

Future navigateAndFinish (context,widget){
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget
      ),
    (route) {
      return false;
    },
  );

}