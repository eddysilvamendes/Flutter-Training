import 'package:flutter/material.dart';
import 'package:flutter_netflix_ui_clone/cubits/cubits.dart';
import 'package:flutter_netflix_ui_clone/data/data.dart';
import 'package:flutter_netflix_ui_clone/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("cast"),
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(
              scrollOffset: scrollOffset,
            );
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                  key: PageStorageKey("previews"),
                  title: "Previews",
                  contentList: previews),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey("myList"),
              title: "My List",
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey("originals"),
                title: "Netflix Originals",
                contentList: originals,
                isOriginals: true),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey("trending"),
                title: "Trending",
                contentList: trending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}