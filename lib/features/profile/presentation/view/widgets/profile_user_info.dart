import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/profile/presentation/manager/cubit/profile_info_cubit.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
      if (state is ProfileInfoSuccess) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(
                      File(state.userInfoModel.imagePath),
                    ),
                  ),
                SizedBox(height: 16),
                  Text(
                    state.userInfoModel.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                if (state.userInfoModel.email != null)
                  Text(
                    state.userInfoModel.email!,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
              ],
            ),
          );
        } else if (state is ProfileInfoError) {
          return Text(
            'Error: ${state.errorMessage}',
            style: TextStyle(color: Colors.red),
          );
        } else {
          return Center(child: Icon(
            Icons.warning_amber, 
            size: 50, 
            color: Colors.red,),);
        }
      },
    );
  }
}
