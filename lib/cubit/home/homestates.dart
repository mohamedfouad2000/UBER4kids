abstract class HomeStates {}

class InitialHomestate extends HomeStates {}

class Home_loding_state extends HomeStates {}

class Home_succ_state extends HomeStates {}

class Home_eroor_state extends HomeStates {
  String eroor;
  Home_eroor_state(this.eroor);
}

class Change_nav_index extends HomeStates {}

class frontPhotoLoading extends HomeStates {}

class frontPhotosucc extends HomeStates {}

class frontPhotoeroor extends HomeStates {}

class c_chipPhotoLoading extends HomeStates {}

class c_chipPhotosucc extends HomeStates {}

class c_chipPhotoeroor extends HomeStates {}

class licencePhotoLoading extends HomeStates {}

class licencePhotosucc extends HomeStates {}

class licencePhotoeroor extends HomeStates {}

class backPhotoLoading extends HomeStates {}

class backPhotosucc extends HomeStates {}

class backPhotoeroor extends HomeStates {}

class adddriverLoading extends HomeStates {}

class adddriversucc extends HomeStates {}

class adddrivereroor extends HomeStates {}

//map
class DropdownButtonfunctionLoading extends HomeStates {}

class DropdownButtonfunctionsucc extends HomeStates {}

class DropdownButtonfunction2Loading extends HomeStates {}

class DropdownButtonfunction2succ extends HomeStates {}

class getDirectionLoading extends HomeStates {}

class getDirectionsucc extends HomeStates {}

class getMarksLoading extends HomeStates {}

class getMarkssucc extends HomeStates {}

class getschoolLoading extends HomeStates {}

class getschoolsucc extends HomeStates {}

class getsourceLoading extends HomeStates {}

class getsourcesucc extends HomeStates {}

class getschoolontap extends HomeStates {}

class getsourceontap extends HomeStates {}

//driver
class getdriverloading extends HomeStates {}

class getdriversucc extends HomeStates {}

class getdrivereroor extends HomeStates {}

class getDriverOfPlaceloading extends HomeStates {}

class getDriverOfPlacesucc extends HomeStates {}
class getDriverOfPlaceerror extends HomeStates {}

class requestdriverloading extends HomeStates {}

class requestdriversucc extends HomeStates {}

class requestdrivereroor extends HomeStates {}

class checkdriverloading extends HomeStates {}

class checkdriversucc extends HomeStates {}

class checkdrivereroor extends HomeStates {}

//search

class searchdriverloading extends HomeStates {}

class searchdriversucc extends HomeStates {}

//empty
class emptyloading extends HomeStates {}

class emptysucc extends HomeStates {}

//org And DIs
class setprofilloading extends HomeStates {}

class setprofilsucc extends HomeStates {}

class setprofileoor extends HomeStates {}

class canselRequestloading extends HomeStates {}

class canselRequestsucc extends HomeStates {}

class canselRequesteroor extends HomeStates {}

class updateDataloading extends HomeStates {}

class updateDatasucc extends HomeStates {}

class updateDatasucc2 extends HomeStates {}

class getprofiledatasucc extends HomeStates {}

//getDriverOfUSer
class getDriverOfUSerloading extends HomeStates {}

class getDriverOfUSersucc extends HomeStates {}

class getDriverOfUSereroor extends HomeStates {}

class getDriverOfUSersucc2 extends HomeStates {}

//request

class NewRequestloading extends HomeStates {}

class NewRequestsucc extends HomeStates {}

class NewRequesteroor extends HomeStates {}

class getuserprofileLoading extends HomeStates {}

class getuserprofilesucc extends HomeStates {}

class getuserprofileeroor extends HomeStates {}

class userprofilePhotoLoading extends HomeStates {}

class userprofilePhotosucc extends HomeStates {}

class userprofilePhotoeroor extends HomeStates {}

class updateuserdataLoading extends HomeStates {}

class updateuserdatasucc extends HomeStates {}

class updateuserdataeroor extends HomeStates {}

class getcustomerLoading extends HomeStates {}

class getcustomersucc extends HomeStates {}

class getcustomereroor extends HomeStates {}

class getallusersLoading extends HomeStates {}

class getalluserssucc extends HomeStates {}

class getalluserseroor extends HomeStates {}

class getnumberofRequestLoading extends HomeStates {}

class getnumberofRequestsucc extends HomeStates {}

class getnumberofRequesteroor extends HomeStates {}

class getloctionLoading extends HomeStates {}

class getloctionsucc extends HomeStates {}

class getloctioneroor extends HomeStates {}

class livelocationLoading extends HomeStates {}

class livelocationsucc extends HomeStates {}

class livelocationeroor extends HomeStates {}



class getCommentsLoading extends HomeStates {}

class getCommentssucc extends HomeStates {}

class getCommentseroor extends HomeStates {}


class complaintsLoading extends HomeStates {}

class complaintssucc extends HomeStates {}

class complaintseroor extends HomeStates {}


class getcomplaintsLoading extends HomeStates {}

class getcomplaintssucc extends HomeStates {}

class getcomplaintseroor extends HomeStates {}


class deletecomplaintsLoading extends HomeStates {}

class deletecomplaintssucc extends HomeStates {}

class deletecomplaintseroor extends HomeStates {}