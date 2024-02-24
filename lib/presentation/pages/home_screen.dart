import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/constants/app_constants.dart';
import 'package:story_app/core/constants/app_routes.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/data/models/response/story_data.dart';
import 'package:story_app/presentation/blocs/home_bloc/home_cubit.dart';
import 'package:story_app/presentation/blocs/home_bloc/home_state.dart';
import 'package:story_app/presentation/blocs/locale_bloc/locale_cubit.dart';
import 'package:story_app/presentation/widgets/custom_dialog.dart';
import 'package:story_app/presentation/widgets/item_story.dart';
import 'package:story_app/presentation/widgets/sa_infinite_scroll.dart';
import 'package:story_app/presentation/widgets/skeleton/item_story_skeleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PagingController<int, StoryData> pagingController;
  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    pagingController = PagingController(
      firstPageKey: 1,
    )..addPageRequestListener(_pageRequestListenerApproval);
  }

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();

    super.dispose();
  }

  void _pageRequestListenerApproval(int pageKey) =>
      context.read<HomeCubit>().fetchListStory(page: pageKey);

  void _logout() {
    context.read<HomeCubit>().clearUserData();
    context.goNamed(AppRoutes.login.name);
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.read<LocaleCubit>().state.locale.toLanguageTag();

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          AppLocalizations.of(context)!.titleApp,
          style: TextStyles.cok36W800(),
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        distance: 70,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.menu),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        children: [
          FloatingActionButton.small(
            heroTag: null,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            child: const Icon(Icons.logout_outlined),
            onPressed: () {
              CustomDialog.showLogout(
                onLogout: _logout,
              );
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            child: Text(
              locale,
              style: TextStyles.pop14W600(),
            ),
            onPressed: () {
              CustomDialog.showLocale();
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            child: const Icon(Icons.add),
            onPressed: () async {
              final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
              final isLinux = defaultTargetPlatform == TargetPlatform.linux;
              if (isMacOS || isLinux) return;

              await availableCameras().then((value) {
                context.goNamed(
                  AppRoutes.camera.name,
                  extra: value,
                );
              });
            },
          ),
        ],
      ),
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          final status = state.homeState.status;
          if (status.isHasData) {
            final dataPaging = state.homeState.data;
            final dataUser = state.homeState.data?.listStory ?? <StoryData>[];
            final isLastPage = dataPaging?.listStory?.isEmpty ?? false;

            if (isLastPage) {
              pagingController.appendLastPage(dataUser);
            } else {
              pagingController.appendPage(dataUser, state.page + 1);
            }

            if (refreshController.isRefresh) {
              refreshController.refreshCompleted();
            }
          }

          if (status.isError) {
            pagingController.error = state.homeState.message.toString();
            if (refreshController.isRefresh) {
              refreshController.refreshCompleted();
            }
          }
        },
        child: SAInfiniteScroll(
          showDivider: true,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 30,
          ),
          noItemTitle: AppLocalizations.of(context)!.noPost,
          noItemDescription: AppLocalizations.of(context)!.noPostDesc,
          separatorBuilder: (context, index) => const SizedBox(height: 30),
          firstProgressIndicatorBuilder: (context) {
            return ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, __) => const ItemStorySkeleton(),
              separatorBuilder: (_, __) => const SizedBox(height: 30),
            );
          },
          itemBuilder: (context, item, index) {
            final storyData = item as StoryData;

            return GestureDetector(
              onTap: () {
                context.goNamed(
                  AppRoutes.detailStory.name,
                  pathParameters: {
                    AppConstants.argsKey.id: storyData.id ?? "",
                  },
                );
              },
              child: ItemStory(storyData: storyData),
            );
          },
          progressIndicatorBuilder: (_) => const ItemStorySkeleton(),
          scrollController: scrollController,
          pagingController: pagingController,
          refreshController: refreshController,
          onRefresh: () async {
            pagingController.refresh();
            await refreshController.requestRefresh();
          },
        ),
      ),
    );
  }
}
