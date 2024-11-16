import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower/Widgets/CustomAppButton.dart';
import 'package:sunpower/Widgets/profile_image/profile_image_provider.dart';
import 'package:sunpower/localization/AppLocal.dart';
import 'package:sunpower/services/image_select_service.dart';

class ProfileImageDialog extends StatefulWidget {

  static show(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            child: ProfileImageDialog(),

          );
        }
    );
  }
  const ProfileImageDialog({Key? key}) : super(key: key);

  @override
  State<ProfileImageDialog> createState() => _ProfileImageDialogState();
}

class _ProfileImageDialogState extends State<ProfileImageDialog> {
  final ProfileImageProvider _imageProvider = ProfileImageProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 170,
        width: double.infinity,
        child: ChangeNotifierProvider.value(
          value: _imageProvider,
          child: Consumer<ProfileImageProvider>(
            builder: (context,value,child) {
              if(value.done){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pop(true);
                });
              }

              if(value.loading){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary
                          ),
                        )
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).trans("profileImage"),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close,color: Colors.black45,size: 30,)
                      )
                    ],
                  ),
                  const SizedBox(height: 12.0,),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: CustomAppButton(
                      child: Center(child: Text(AppLocalizations.of(context).trans("update"),style: TextStyle(color: Colors.white),)),
                      color: Colors.green,
                      borderRadius: 15,
                      elevation: 1,
                      padding: EdgeInsets.all(12),
                      onTap: () async {
                        try{
                          var imageLink = await ImageSelectService.selectImage();
                          if(imageLink!= null){
                            ProfileImageProvider.of(context).updateImage(imageLink);

                          }
                        } catch (error){
                          print(error);
                        }

                      },
                    ),
                  ),
                  const SizedBox(height: 12.0,),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: CustomAppButton(
                      child: Center(child: Text(AppLocalizations.of(context).trans("delete"),style: TextStyle(color: Colors.white),)),
                      color: Colors.red,
                      borderRadius: 15,
                      elevation: 1,
                      padding: EdgeInsets.all(12),
                      onTap: (){
                        ProfileImageProvider.of(context).deleteImage();
                      },
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
