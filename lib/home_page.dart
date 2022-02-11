import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/newsdetails_bloc.dart';
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
  // int detailsCounter = 0;
  // void getNewsDetailsInit() {
  //   BlocProvider.of<GetNewsDetailsBloc>(context).add(GetNewsDetails());
  // }

  Future<void> getNewsDetails() async {
    setState(() {
      isLoading = true;
    });
    var response = await helper.get('');
    // print('the reponse is : ${response["articles"][0]["urlToImage"]}');
    Provider.of<NewsDetailsModule>(context, listen: false)
        .updateArticleList(response["articles"]);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    BlocProvider.of<NewsDetailsCounterBloc>(context).add(GetNewsDetails());
    getNewsDetails();

    super.initState();
  }

  bool showBackButton = false;
  bool showForwardButton = true;

  @override
  Widget build(BuildContext context) {
    // List newsDetailsList = context.watch<NewsDetailsModule>().articlesList;
    // print('the updated details are : ${newsDetailsList.length}');

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
                    Column(
                      children: [
                        // BlocBuilder<NewsDetailsCounterBloc,
                        //     NewsDetailsCounterState>(
                        //   builder: (context, state) {
                        //     return Text(
                        //       state.detailsCounterValue.toString(),
                        //     );
                        //   },
                        // ),
                        // BlocBuilder<NewsDetailsCounterBloc,
                        //     NewsDetailsCounterState>(
                        //   builder: (context, state) {
                        //     return Text(
                        //       state.articleList[0].toString(),
                        //     );
                        //   },
                        // ),
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
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const CircularProgressIndicator(
                                      color: Colors.red,
                                    ),
                                    BlocBuilder<NewsDetailsCounterBloc,
                                        NewsDetailsCounterState>(
                                      builder: (context, state) {
                                        return Image.network(
                                          state.articleList[
                                                  state.detailsCounterValue]
                                              ["urlToImage"],
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                    // Image.network(
                                    //   newsDetailsList[context
                                    //       .watch<NewsDetailsModule>()
                                    //       .detailsCounter]["urlToImage"],
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<NewsDetailsCounterBloc,
                            NewsDetailsCounterState>(
                          builder: (context, state) {
                            return Text(
                              state.articleList[state.detailsCounterValue]
                                  ["title"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          // color: Colors.amber,
                          height: 250,
                          child: SingleChildScrollView(
                            child: BlocBuilder<NewsDetailsCounterBloc,
                                NewsDetailsCounterState>(
                              builder: (context, state) {
                                return Text(
                                  state.articleList[state.detailsCounterValue]
                                      ["description"],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocListener<NewsDetailsCounterBloc,
                              NewsDetailsCounterState>(
                            listener: (BuildContext context, state) {
                              setState(() {
                                showBackButton = state.detailsCounterValue > 0;
                              });
                            },
                            child: showBackButton
                                ? InkWell(
                                    onTap: () {
                                      // setState(() {
                                      //   detailsCounter -= 1;
                                      // });
                                      // context
                                      //     .read<NewsDetailsModule>()
                                      //     .updateDetailsCounter(false);
                                      BlocProvider.of<NewsDetailsCounterBloc>(
                                              context)
                                          .add(DecrementNewsDetailsPage());
                                    },
                                    child: const Icon(Icons.arrow_back_ios),
                                  )
                                : Container(),
                          ),
                          BlocListener<NewsDetailsCounterBloc,
                              NewsDetailsCounterState>(
                            listener: (BuildContext context, state) {
                              setState(() {
                                showForwardButton = state.detailsCounterValue <
                                    state.articleList.length - 1;
                              });
                            },
                            child: showForwardButton
                                ? InkWell(
                                    onTap: () {
                                      // setState(() {
                                      //   detailsCounter += 1;
                                      // });
                                      // context
                                      //     .read<NewsDetailsModule>()
                                      //     .updateDetailsCounter(true);
                                      BlocProvider.of<NewsDetailsCounterBloc>(
                                              context)
                                          .add(IncrementNewsDetailsPage());
                                    },
                                    child: const Icon(Icons.arrow_forward_ios),
                                  )
                                : Container(),
                          )
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
