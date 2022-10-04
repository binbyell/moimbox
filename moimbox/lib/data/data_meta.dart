import 'dart:io';

import 'package:moimbox/class/ClassMyProfile.dart';
import 'package:image_picker/image_picker.dart';

MyProfileItem metaMyProfileItem = MyProfileItem();

/// signIn

bool metaSignInIsCheckService = false;
bool metaSignInIsCheckPersonalInformation = false;

File? metaSignInImage;

/// meeting

String currentMeetingDocId = "";