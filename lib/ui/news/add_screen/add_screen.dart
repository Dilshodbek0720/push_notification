import 'package:chat_app/blocs/news/news_bloc.dart';
import 'package:chat_app/blocs/news/news_event.dart';
import 'package:chat_app/blocs/news/news_state.dart';
import 'package:chat_app/data/file_uploder.dart';
import 'package:chat_app/data/news/model/field_keys.dart';
import 'package:chat_app/data/news/universal_data.dart';
import 'package:chat_app/ui/news/add_screen/widgets/global_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/news/model/status/from_status.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/ui_utils/show_error_message.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Screen"),
      ),
      body: BlocConsumer<NewsBloc, NewsAddState>(
        builder: (context, state) {
          return ListView(
            children: [
              const SizedBox(height: 20,),
              const Center(child: Text("Add News", style: TextStyle(fontSize: 30),)),
              const SizedBox(height: 10),
              GlobalTextField(
                  hintText: "Author",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    BlocProvider.of<NewsBloc>(context).updateNewsField(
                      fieldKey: NewsFieldKeys.author,
                      value: v,
                    );
                  }),
              GlobalTextField(
                  hintText: "News Title",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    BlocProvider.of<NewsBloc>(context).updateNewsField(
                      fieldKey: NewsFieldKeys.news_title,
                      value: v,
                    );
                  }),
              GlobalTextField(
                  hintText: "News Description",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    BlocProvider.of<NewsBloc>(context).updateNewsField(
                      fieldKey: NewsFieldKeys.news_description,
                      value: v,
                    );
                  }),
              Center(
                child: TextButton(
                  onPressed: (){
                    showBottomSheetDialog();
                  },
                  child: const Text("Selected Image"),
                ),
              )
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            showErrorMessage(
              message: state.statusText,
              context: context,
            );
          }

          if (state.status == FormStatus.success &&
              state.statusText == StatusTextConstants.newsAdd) {
            BlocProvider.of<NewsBloc>(context).add(GetNews());
            Navigator.pop(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.read<NewsBloc>().add(AddNews());
          context.read<NewsBloc>().add(GetNews());
        },
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: Color(0xFF162023),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      UniversalData universalData = await FileUploader.imageUploader(xFile);
      String imageUrl = universalData.data;
      // ignore: use_build_context_synchronously
      BlocProvider.of<NewsBloc>(context).updateNewsField(
        fieldKey: NewsFieldKeys.news_image,
        value: imageUrl,
      );
      print(imageUrl);
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      UniversalData universalData = await FileUploader.imageUploader(xFile);
      String imageUrl = universalData.data;
      BlocProvider.of<NewsBloc>(context).updateNewsField(
        fieldKey: NewsFieldKeys.news_image,
        value: imageUrl,
      );
      print(imageUrl);
    }
  }


}
