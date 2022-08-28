import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nas_academy/core/api/edit_profile/edit_profile.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/user/sub/contact.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/services/image_pick_service.dart';
import 'package:nas_academy/core/services/messenger.dart';
import 'package:nas_academy/core/utils/data_types.dart';

class ProfileProvider extends ChangeNotifier {

  bool _loading = false;

  /// edit general info
  String? _name;
  String? _country;
  XFile? _profilePhoto;


  /// edit bio
  String? _bio;

  /// edit spotlight
  String _spotlightLink = "";
  String? _spotLightTitle;
  String? _spotLightDes;
  XFile? _spotLightImage;


  /// edit skills and interests
   List<String> interests = [];
   List<String> skills = [];
   List<String> _skillsToShow = [];
   List<String> _interestsToShow = [];
   bool deleted = false;



   /// edit socials
  List<SocialMedia> socials = [];
  String?  _totalFollowers;
  bool _updateSocials = false;



  /// edit contacts
  List<Contact> contacts = [];
  String? _primaryContact;
  bool _validToUpdateContacts = false;


  bool get validToUpdateContacts => _validToUpdateContacts;

  set setValidToUpdateContacts(bool value) {
    _validToUpdateContacts = value;
    notifyListeners();
  }

  String? get primaryContact => _primaryContact;

  set setPrimaryContact(String? value) {
    _primaryContact = value;
    notifyListeners();
  }


  set setPrimaryContactSilent(String? value) {
    _primaryContact = value;
  }


  bool get updateSocials => _updateSocials;

  set setUpdateSocials(bool value) {
    _updateSocials = value;
    notifyListeners();
  }

  String? get totalFollowers => _totalFollowers;

  set setTotalFollowers(String? value) {
    _totalFollowers = value;
    notifyListeners();
  }

  List<String> get skillsToShow => _skillsToShow;

  set setSkillsToShow(List<String> value) {
    _skillsToShow = value;
  }

  List<String> get interestsToShow => _interestsToShow;

  set setInterestsToShow(List<String> value) {
    _interestsToShow = value;
  }

  String? get bio => _bio;

  set setBio(String? value) {
    _bio = value;
    notifyListeners();
  }

  String? get name => _name;

  set setName(String? value) {
    _name = value;
    notifyListeners();
  }


  String? get country => _country;

  set setCountry(String? value) {
    _country = value;
    notifyListeners();
  }

  set setCountrySilent(String? value) {
    _country = value;
    notifyListeners();
  }

  XFile? get profilePhoto => _profilePhoto;

  set setProfilePhoto(XFile? value) {
    _profilePhoto = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String? get spotLightTitle => _spotLightTitle;

  set setSpotLightTitle(String? value) {
    _spotLightTitle = value;
    notifyListeners();
  }

  String get spotlightLink => _spotlightLink;

  set setSpotlightLink(String value) {
    _spotlightLink = value;
    notifyListeners();
  }

  bool bioCompleted(User? user) {
    return user != null &&
        user.learner.bio != null &&
        user.learner.bio!.isNotEmpty;
  }

  bool skillsCompleted(User? user) {
    return user != null &&
        (user.learner.interests.isNotEmpty || user.learner.skills.isNotEmpty);
  }

  bool contactCompleted(User? user) {
    return user != null && user.learner.contactUsernames.isNotEmpty;
  }

  bool socialMediaCompleted(User? user) {
    return user != null && user.learner.socialMedia.isNotEmpty;
  }

  bool profilePhotoCompleted(User? user) {
    return user != null &&
        user.learner.profileImage != null &&
        user.learner.profileImage!.isNotEmpty;
  }

  int completed(User? user) {
    List<bool> sections = [
      bioCompleted(user),
      skillsCompleted(user),
      contactCompleted(user),
      socialMediaCompleted(user),
      profilePhotoCompleted(user)
    ];
    return sections.where((element) => element).length;
  }

  bool validLink() {
    return AnyLinkPreview.isValidLink(spotlightLink);
  }

  String? get spotLightDes => _spotLightDes;

  set setSpotLightDes(String? value) {
    _spotLightDes = value;
    notifyListeners();
  }

  XFile? get spotLightImage => _spotLightImage;

  set setSpotLightImage(XFile? value) {
    _spotLightImage = value;
    notifyListeners();
  }


  bool validToSaveGeneralInfo (User? user){
    return (_name != null && _name!.toLowerCase().replaceAll(" ", "") != "${user!.learner.firstName} ${user.learner.lastName}".toLowerCase().replaceAll(" ", "")) ||
        (_country != null && _country!.toLowerCase().replaceAll(" ", "") != "${user!.country}".toLowerCase().replaceAll(" ", "")) ||
        (_profilePhoto != null);
  }

  bool validToUpdateBio (User? user){
    return _bio != null && _bio!.isNotEmpty && _bio != user?.learner.bio;
  }

  bool validToUpdateSkills (User user) {
    return (skills.isNotEmpty && skills != user.learner.skills) ||
        (interests.isNotEmpty && interests != user.learner.interests) || deleted;
  }


  bool validToUpdateSocials (User user){
    return _updateSocials;
  }


  bool validToSaveSpotlight(SpotLight spotLight, Metadata? meta) {
    return (_spotLightTitle != null &&
            _spotLightTitle!.isNotEmpty &&
            _spotLightTitle != spotLight.title &&
            _spotLightTitle != meta?.title) ||
        (_spotLightDes != null &&
            _spotLightDes!.isNotEmpty &&
            _spotLightDes != spotLight.description &&
            _spotLightDes != meta?.desc) ||
        (_spotLightImage != null);
  }



  Future<bool> pickSpotlightImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      final result = await ImagePickService.pickImageCamera();
      if (result != null) {
         int length = (await result.length());
        if(length > 2000000){
          setSpotLightImage = result;
          return true;
        }else {
          throw ServerError(
            title: "Image too big",
            body: "Image must be less than 2MB"
          );
        }
      } else {
        return false;
      }
    } else if (source == ImageSource.gallery) {
      final result = await ImagePickService.pickImageGallery();
      if (result != null) {
        setSpotLightImage = result;
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }


  Future<bool> pickProfileImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      final result = await ImagePickService.pickImageCamera();
      if (result != null) {
        int length = (await result.length());
        if(length < 2000000){
          setProfilePhoto = result;
          return true;
        }else {
          throw ServerError(
              title: "Image too big",
              body: "Image must be less than 2MB"
          );
        }

      } else {
        return false;
      }
    } else if (source == ImageSource.gallery) {
      final result = await ImagePickService.pickImageGallery();
      if (result != null) {
        setProfilePhoto = result;
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }


  Future editGeneralProfile (User? user, BuildContext context)async{
    try{
      setLoading = true;
      if(validToSaveGeneralInfo(user)){
        List<String> nam = (_name?.split(" ") ?? []).toList();
        String? photo = user?.learner.profileImage;
        if(profilePhoto != null){
          photo = await const EditProfile().uploadImage(profilePhoto!, UploadType.profileImages);
        }
        await const EditProfile().updateGeneralProfile(
          country: _country ?? user?.country ?? user?.learner.country,
          firstName: nam.isNotEmpty? nam.first : user?.learner.firstName,
          lastName: nam.length >=2 ? nam.last : user?.learner.lastName,
          profileImage: photo,
        );

        if(user != null){
          if(_country != null){
            user.learner.country = country;
            user.country = country;
          }
          if(nam.isNotEmpty){
            user.learner.firstName = nam.first;
          }
          if(nam.length >=2){
            user.learner.lastName = nam.last;
          }
          user.learner.profileImage = photo;
        }
        setProfilePhoto = null;
        setName = null;
        setCountry = null;
        Messenger.showSuccessSnackBar(context);
      }
      setLoading = false;
    }catch (e){
      setLoading = false;
      Messenger.showFailedSnackBar(context, message : e.toString());
      rethrow;
    }
  }




  Future editBio (User? user, BuildContext context)async{
    try{
      setLoading = true;
      if(validToUpdateBio(user)){
        await const EditProfile().updateBio(bio!);
        user!.learner.bio = bio;
        setBio = null;
        Messenger.showSuccessSnackBar(context);
      }
      setLoading = false;
    }catch (e){
      setLoading = false;
      Messenger.showFailedSnackBar(context, message : e.toString());
      rethrow;
    }
  }



  Future updateSkillsAndInterests (User? user, BuildContext context)async{
    try{
      setLoading = true;
      await const EditProfile().updateSkillsAndInterests(skillsToShow, interestsToShow);
      skills.clear();
      interests.clear();
      deleted = false;
      user!.learner.interests = interestsToShow;
      user.learner.skills = skillsToShow;
      notifyListeners();
      setLoading = false;
      Messenger.showSuccessSnackBar(context);
    }catch (e){
      setLoading = false;
      Messenger.showFailedSnackBar(context, message : e.toString());
      rethrow;
    }
  }

  Future editSpotlight(SpotLight spotLight, Metadata? data, User? user, BuildContext context) async {
    try {
      setLoading = true;
      if (validToSaveSpotlight(spotLight, data)) {
        spotLight.title = _spotLightTitle ?? spotLight.title ?? data?.title;
        spotLight.description =
            _spotLightDes ?? spotLight.description ?? data?.desc;
        if (spotLightImage != null) {
          String url = await const EditProfile()
              .uploadImage(spotLightImage!, UploadType.spotlights);
          spotLight.thumbnail = url;
        } else {
          spotLight.thumbnail = spotLight.thumbnail ?? data?.image;
        }
        if (user != null) {
          user.learner.spotlights.removeWhere((element) => element.link == spotLight.link);
          user.learner.spotlights.add(spotLight);
          await const EditProfile().updateSpotlights(user.learner.spotlights);
        }
        Messenger.showSuccessSnackBar(context);
      } else {
        if (user != null) {
          await const EditProfile().updateSpotlights(user.learner.spotlights);
        }
      }
      setLoading = false;
    } catch (e) {
      setLoading = false;
      Messenger.showFailedSnackBar(context, message : e.toString());
      rethrow;
    }
  }


  Future updateSocialMedia (User user, BuildContext context)async{
    try{
      setLoading = true;
      final List<SocialMedia> mediaList = await const EditProfile().updateSocials(socials, _totalFollowers ?? user.learner.followersCount.toString());
      user.learner.socialMedia = mediaList;
      user.learner.followersCount = int.tryParse(totalFollowers ?? user.learner.followersCount.toString());
      setUpdateSocials = false;
      Messenger.showSuccessSnackBar(context);
      notifyListeners();
      setLoading = false;
    }catch (e){
      setLoading = false;
      Messenger.showFailedSnackBar(context, message : e.toString());
      rethrow;
    }
  }



  Future updateContacts (User user, BuildContext context)async{
    try{
      setLoading = true;
      await const EditProfile().updateContacts(contacts, primaryContact ?? "email");

      user.learner.contactUsernames = contacts;
      user.learner.primaryContact = primaryContact;
      await UserLocalDB.saveUser(user);
      setValidToUpdateContacts = false;
      Messenger.showSuccessSnackBar(context);
      notifyListeners();
      setLoading = false;
    }catch (e){
      setLoading = false;
      Messenger.showFailedSnackBar(context, message : e.toString());
      rethrow;
    }
  }


  void dis() {
    _spotLightImage = null;
    _spotLightTitle = null;
    _spotLightDes = null;
  }

  void notify() {
    notifyListeners();
  }
}
