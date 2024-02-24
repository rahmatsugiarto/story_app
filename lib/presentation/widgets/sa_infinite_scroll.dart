import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/presentation/widgets/custom_button.dart';

class SAInfiniteScroll extends StatelessWidget {
  const SAInfiniteScroll({
    required this.showDivider,
    required this.noItemTitle,
    required this.itemBuilder,
    required this.scrollController,
    required this.pagingController,
    required this.refreshController,
    required this.noItemDescription,
    required this.onRefresh,
    super.key,
    this.padding,
    this.emptyBuilder,
    this.separatorBuilder,
    this.progressIndicatorBuilder,
    this.firstProgressIndicatorBuilder,
  });

  final bool showDivider;
  final String noItemTitle;
  final EdgeInsets? padding;
  final String noItemDescription;
  final PagingController<dynamic, dynamic> pagingController;
  final ScrollController scrollController;
  final RefreshController refreshController;
  final Widget Function(BuildContext context)? emptyBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget Function(BuildContext context, Object? item, int index)
      itemBuilder;
  final Widget Function(BuildContext context)? progressIndicatorBuilder;
  final Widget Function(BuildContext context)? firstProgressIndicatorBuilder;
  final Future<dynamic> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      trackVisibility: true,
      radius: const Radius.circular(4),
      thickness: 2,
      controller: scrollController,
      child: SmartRefresher(
        controller: refreshController,
        scrollController: scrollController,
        onRefresh: onRefresh,
        header: ClassicHeader(
          idleText: AppLocalizations.of(context)!.keepPulling,
          refreshingText: AppLocalizations.of(context)!.processing,
          failedText: AppLocalizations.of(context)!.failed,
          completeText: AppLocalizations.of(context)!.success,
          releaseText: AppLocalizations.of(context)!.release,
          completeIcon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          refreshingIcon: const SpinKitDoubleBounce(
            size: 14,
            color: Colors.black,
          ),
        ),
        child: PagedListView.separated(
          pagingController: pagingController,
          scrollController: scrollController,
          padding: padding ?? const EdgeInsets.all(16),
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: itemBuilder,
            animateTransitions: true,
            transitionDuration: const Duration(milliseconds: 700),
            noItemsFoundIndicatorBuilder: emptyBuilder ??
                (context) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            noItemTitle,
                            style: TextStyles.pop32W700(),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: Text(
                              noItemDescription,
                              style: TextStyles.pop13W400(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
            firstPageErrorIndicatorBuilder: (_) {
              return Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.sizeOf(context).height / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.failed,
                          style: TextStyles.pop32W700(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Text(
                            pagingController.error.toString(),
                            style: TextStyles.pop13W400(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    CustomButton(
                      onPressed: pagingController.refresh,
                      child: Text(
                        AppLocalizations.of(context)!.tryAgain,
                        style: TextStyles.pop13W400(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            firstPageProgressIndicatorBuilder: firstProgressIndicatorBuilder ??
                (_) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    height: 0.84,
                    child: const SpinKitFadingCircle(
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                  );
                },
            newPageProgressIndicatorBuilder: progressIndicatorBuilder ??
                (_) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        children: [
                          const SpinKitFadingCircle(
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            AppLocalizations.of(context)!.loadMore,
                            style: TextStyles.pop10W400(),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
            newPageErrorIndicatorBuilder: (_) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.failed,
                          style: TextStyles.pop32W700(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Text(
                            pagingController.error.toString(),
                            style: TextStyles.pop13W400(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    CustomButton(
                      onPressed: pagingController.retryLastFailedRequest,
                      child: Text(
                        AppLocalizations.of(context)!.tryAgain,
                        style: TextStyles.pop13W400(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          shrinkWrap: true,
          separatorBuilder: showDivider
              ? separatorBuilder ??
                  (_, __) => const Divider(
                        height: 16,
                        thickness: 2,
                        color: Colors.white,
                      )
              : (_, __) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
