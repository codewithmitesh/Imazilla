import 'package:flutter/material.dart';
import '/api/fetch_api.dart';
import '/data/data.dart';
import '/model/category_model.dart';
import '/model/constants.dart';
import '/model/photos.dart';
import '/widgets/category_tile.dart';
import '/widgets/info_card.dart';
import '/widgets/logo.dart';
import '/widgets/search_bar.dart' as SearchBar;
import '/widgets/wallpaper_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<CategoryModel> categories = getCategories();
  late List<Photos> photosList;
  int page = 1;
  bool isLoading = false;
  final TextEditingController queryController = TextEditingController();

  Future<void> _fetchData() async {
    if (isLoading) return; // Return if a fetch operation is already in progress

    setState(() {
      isLoading = true;
    });

    try {
      List<Photos> fetchedPhotos = await DataService.fetchData(page);
      if (mounted) {
        setState(() {
          photosList.addAll(fetchedPhotos);
          page = page + 1;
        });
      }
    } catch (e) {
      throw "Error: $e";
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    photosList = [];
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
          backgroundColor: Colors.pink,
          elevation: 15,
          centerTitle: true,
          title: logo(),
          shadowColor: Colors.red,
          actions: [
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const InfoCard();
                  }),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.info,
                  color: kBaseColor,
                ),
              ),
            ),
          ]),
      body: Column(
        children: [
          SearchBar.SearchBar(
            queryController: queryController,
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 50,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return CategoryTile(
                  category: categories[index].category,
                  imgUrl: categories[index].imgUrl,
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: wallpaperList(context, _fetchData, photosList: photosList),
          ),
        ],
      ),
    );
  }
}
