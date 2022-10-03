import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/features/Settings/settingProvider.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/languageModel.dart';
import 'package:notey/routing/navigation.dart';
import 'package:provider/provider.dart';
import 'package:notey/utils/validator.dart';
import 'package:notey/resources/font_manager.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/resources/strings_manager.dart';
import 'package:notey/features/Home/homeProvider.dart';
import 'package:notey/shared/widgets/CustomCTAButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notey/shared/widgets/CustomeRoundedTextFiled.dart';

class BottomSheetNote extends StatefulWidget {
  @override
  _BottomSheetNoteState createState() => _BottomSheetNoteState();
}

class _BottomSheetNoteState extends State<BottomSheetNote> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: SingleChildScrollView(
        child: Consumer<HomeProvider>(
          builder: (context, data, child) => Form(
            key: data.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings().addNote,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: ColorManager.white,
                          fontWeight: FontWeightManager.semiBold),
                    )
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                CustomTextFiled(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                  ],
                  maxLines: 5,
                  controller: data.noteTitle,
                  hintText: '${AppStrings().typeSomething}',
                  keyboardType: TextInputType.name,
                  focuse: (_) => FocusScope.of(context).nextFocus(),
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    data.noteTitle.text = val!;
                  },
                  validator: (value) => Validator2.validateName(value ?? ""),
                ),
                SizedBox(
                  height: 32.h,
                ),
                CustomeCTAButton(
                  trigger: data.loading,
                  primary: ColorManager.secondColor,
                  onPressed: () {
                    data.id == 0 ? data.addTask() : data.updateTask();
                  },
                  title: data.id != 0 ? AppStrings().update : AppStrings().save,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomeCTAButtonCancel(
                  trigger: false,

                  // primary: ColorManager.parent,
                  onPressed: () {
                    data.id = 0;
                    data.noteTitle.clear();
                    sl<NavigationService>().pop();
                  },
                  title: AppStrings().cancel,
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class BottomSheetLanguage extends StatefulWidget {
  @override
  _BottomSheetLanguageState createState() => _BottomSheetLanguageState();
}

class _BottomSheetLanguageState extends State<BottomSheetLanguage> {
  final data = sl<SettingProvider>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Row(
              children: [
                Text(
                  "Language".tr(),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.semiBold),
                )
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: Language.languageList.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0.r),
                  ),
                ),
                child: Card(
                  color: ColorManager.black,
                  elevation: 0,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: RadioListTile(

                      activeColor: ColorManager.primary,

                      toggleable: false,
                      value: index,
                      onChanged: (dynamic value) {
                        sl<SharedLocal>().setLanguage =
                            Language.languageList[index].languageCode;
                        context.setLocale(Locale(
                            '${Language.languageList[index].languageCode}'));

                        print(context.locale.toString());
                        setState(() {
                          data.changeLanguage(value);
                          sl<SharedLocal>().setLanguageIndex = data.languageValue;

                          data.languageValue = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      groupValue: sl<SharedLocal>().getIndexLang,
                      title: Text(
                        "${Language.languageList[index].name}",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorManager.white),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.zero,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}





