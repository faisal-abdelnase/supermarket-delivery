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
                if (state.photoURL != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(state.photoURL!),
                  )
                else
                  CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                SizedBox(height: 16),
                if (state.displayName != null)
                  Text(
                    state.displayName!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                if (state.email != null)
                  Text(
                    state.email!,
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
