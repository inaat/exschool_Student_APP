import 'package:exschool/cubits/appSettingsCubit.dart';
import 'package:exschool/data/repositories/systemInfoRepository.dart';
import 'package:exschool/ui/widgets/appSettingsBlocBuilder.dart';
import 'package:exschool/ui/widgets/customAppbar.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();

  static Route route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider<AppSettingsCubit>(
              create: (context) => AppSettingsCubit(SystemRepository()),
              child: ContactUsScreen(),
            ));
  }
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final String contactUsType = "contact_us";
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<AppSettingsCubit>().fetchAppSettings(type: contactUsType);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppSettingsBlocBuilder(appSettingsType: contactUsType),
          CustomAppBar(title: contactUsKey),
        ],
      ),
    );
  }
}
