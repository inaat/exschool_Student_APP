import 'package:exschool/cubits/holidaysCubit.dart';
import 'package:exschool/data/repositories/systemInfoRepository.dart';
import 'package:exschool/ui/widgets/holidaysContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HolidaysScreen extends StatelessWidget {
  const HolidaysScreen({Key? key}) : super(key: key);

  static Route route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider<HolidaysCubit>(
              create: (context) => HolidaysCubit(SystemRepository()),
              child: HolidaysScreen(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HolidaysContainer(),
    );
  }
}
