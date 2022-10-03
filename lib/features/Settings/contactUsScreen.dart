import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/shared/widgets/CustomAppBar.dart';

class ContactUsScreen extends StatelessWidget {
  final data = sl<SettingProvider>();

  ContactUsScreen() {
    data.getContactUsProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: ColorManager.backgroundColor,
        title: "Contact Us",
      ),
      body: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data.contactUsData.length,
                    separatorBuilder: (context, index) => Divider(
                          height: 14.h,
                          color: Colors.transparent,
                        ),
                    itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0.r),
                            ),
                          ),
                          child: InkWell(
                            onTap: (){
                              data.launchUrlSite(data.contactUsData[index].value);
                            },
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: ColorManager.primary,
                                    child: AspectRatio(
                                      aspectRatio: 9 / 16,
                                      child: CachedNetworkImage(
                                        // color: Colors.red,
                                        fit: BoxFit.scaleDown,
                                        placeholder: (context, url) => Center(
                                            child:
                                                const CircularProgressIndicator()),
                                        imageUrl:
                                            "${data.contactUsData[index].image}",
                                      ),
                                    ),
                                    // Image.Imagenetwork("${data.contactUsData[index].image}"),
                                  ),
                                  title: Text(
                                    "${data.contactUsData[index].value}",
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    // children: [
                    //   Text(
                    //     "${data.aboutus == null ? "": data.aboutus!.terms}".tr(),
                    //     overflow: TextOverflow.visible,
                    //   ),
                    // ],
                    ),
              ),
            ),
    );
  }
}
