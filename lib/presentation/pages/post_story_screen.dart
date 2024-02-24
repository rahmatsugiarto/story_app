import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/constants/app_routes.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/presentation/blocs/post_bloc/post_cubit.dart';
import 'package:story_app/presentation/blocs/post_bloc/post_state.dart';
import 'package:story_app/presentation/widgets/custom_button.dart';
import 'package:story_app/presentation/widgets/custom_dialog_loading.dart';
import 'package:story_app/presentation/widgets/custom_toast.dart';

class PostStoryScreen extends StatefulWidget {
  final XFile file;

  const PostStoryScreen({super.key, required this.file});

  @override
  State<PostStoryScreen> createState() => _PostStoryScreenState();
}

class _PostStoryScreenState extends State<PostStoryScreen> {
  final TextEditingController _controllerDesc = TextEditingController();

  @override
  void dispose() {
    _controllerDesc.dispose();
    super.dispose();
  }

  void _postStory({
    double? lat,
    double? lon,
  }) async {
    context.read<PostCubit>().postStory(
          bytes: await widget.file.readAsBytes(),
          fileName: widget.file.name,
          description: _controllerDesc.text.trim(),
          lat: lat,
          lon: lon,
        );
  }

  void _setIsReadyToPost(String desc) {
    context.read<PostCubit>().setIsReadyToPost(desc: desc);
  }

  void clearAndNavigate(String path) {
    while (context.canPop() == true) {
      context.pop();
    }
    context.pushReplacementNamed(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          AppLocalizations.of(context)!.newPost,
          style: TextStyles.pop20W500(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocListener<PostCubit, PostState>(
        listener: (context, state) {
          final status = state.postState.status;
          final message = state.postState.message;

          if (status.isLoading) {
            CustomDialogLoading.show();
          }

          if (status.isError) {
            CustomDialogLoading.dismiss();
            CustomToast.showError(message: message);
          }

          if (status.isHasData) {
            final data = state.postState.data;

            CustomDialogLoading.dismiss();
            CustomToast.showSuccess(message: data?.message ?? "");
            clearAndNavigate(AppRoutes.home.name);
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Image.file(
                File(widget.file.path),
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _controllerDesc,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.writeCaption,
                      ),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      onChanged: _setIsReadyToPost,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<PostCubit, PostState>(
                      builder: (context, state) {
                        return CustomButton(
                          width: MediaQuery.sizeOf(context).width,
                          onPressed: state.isReadyToPost
                              ? () {
                                  _postStory();
                                }
                              : null,
                          child: Text(
                            AppLocalizations.of(context)!.share,
                            style: TextStyles.pop14W400(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
