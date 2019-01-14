import 'package:ClippingKK/model/httpClient.dart';
import 'package:scoped_model/scoped_model.dart';

class UserProfile extends Model {
  UserProfileItem profile;

  updateProfile(UserProfileItem p) {
    this.profile = p;
    notifyListeners();
  }
}
