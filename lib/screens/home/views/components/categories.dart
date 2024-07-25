import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../api/ApiExecutor.dart';
import '../../../../api/ApiNameConst.dart';
import '../../../../constants.dart';
import '../../../../models/categories_model.dart';

class Categories extends StatefulWidget {
  Function callBack;

  Categories({
    super.key,
    required this.callBack,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listofCategoriesLocallyStore.isNotEmpty
        ? listOfCategories = listofCategoriesLocallyStore
        : categoriesApi(context);
  }

  int isActiveindex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            listOfCategories.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? defaultPadding : defaultPadding / 2,
                  right: index == listOfCategories.length - 1
                      ? defaultPadding
                      : 0),
              child: CategoryBtn(
                category: listOfCategories[index].name ?? "",
                imageUrl: listOfCategories[index].image,
                isActive: index == isActiveindex,
                press: () {
                  isActiveindex = index;
                  widget.callBack(
                    listOfCategories[index].id,
                  );
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ApiExecutor apiexecutor = ApiExecutor();

  bool iscategoriesApiCall = true;
  List<CategoriesModel> listOfCategories = [];

  Future<List<CategoriesModel>> categoriesApi(context) async {
    listOfCategories.clear();
    Map<String, String> map = {};
    await apiexecutor.callApi(
      context,
      CATEGORIES,
      true,
      true,
      map,
      (val) {
        // Parse the JSON string
        List<dynamic> jsonList = jsonDecode(val);
        // Convert the JSON list to a list of Item objects
        listOfCategories.add(CategoriesModel(id: -99, name: "All Product"));
        listOfCategories.addAll(
          jsonList.map((json) => CategoriesModel.fromJson(json)).toList(),
        );
        listofCategoriesLocallyStore = listOfCategories;
        iscategoriesApiCall = false;
        setState(() {});
      },
      true,
    );
    return listOfCategories;
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    this.imageUrl,
    required this.isActive,
    required this.press,
  });

  final String category;
  final String? imageUrl;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container();
                },
              ),
            if (imageUrl != null) const SizedBox(width: defaultPadding / 2),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
