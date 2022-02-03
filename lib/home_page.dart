import 'package:flutter/material.dart';
import 'package:news_app/providers/news_details_providers.dart';
import 'package:news_app/utils/api_helper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiBaseHelper helper = ApiBaseHelper();
  bool isLoading = false;
  int detailsCounter = 0;
  Future<void> getNewsDetails() async {
    setState(() {
      isLoading = true;
    });
    var response = await helper.get('');
    print('the reponse is : ${response["articles"][0]["urlToImage"]}');
    Provider.of<NewsDetailsModule>(context, listen: false)
        .updateArticleList(response["articles"]);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getNewsDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List newsDetailsList = context.watch<NewsDetailsModule>().articlesList;
    print('the updated details are : ${newsDetailsList.length}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/menuBar.png',
                                scale: 40,
                              ),
                              const Text(
                                'FlashBytes',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              const Icon(
                                Icons.search,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                )
                              : SizedBox(
                                  // color: Colors.amber,
                                  height: 250,
                                  width: double.infinity,
                                  child: Image.network(
                                    newsDetailsList[detailsCounter]
                                        ["urlToImage"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            newsDetailsList[detailsCounter]["title"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            newsDetailsList[detailsCounter]["description"],
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          detailsCounter > 0
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      detailsCounter -= 1;
                                    });
                                  },
                                  child: const Icon(Icons.arrow_back_ios),
                                )
                              : Container(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                detailsCounter += 1;
                              });
                            },
                            child: const Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
