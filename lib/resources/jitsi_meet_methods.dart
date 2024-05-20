import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      var jitsiMeet = JitsiMeet();
      var options = JitsiMeetConferenceOptions(
          room: roomName,
          userInfo: JitsiMeetUserInfo(
            displayName: name,
            email: _authMethods.user.email,
            avatar: _authMethods.user.photoURL,
          ),
          configOverrides: {
            "startWithAudioMuted": isAudioMuted,
            "startWithVideoMuted": isVideoMuted,
          });
      _firestoreMethods.addToMeetingHistory(roomName);
      jitsiMeet.join(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
