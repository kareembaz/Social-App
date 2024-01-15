abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

/// Get user
class HomeGetUserLoadingState extends HomeStates {}

class HomeGetUserSucessState extends HomeStates {}

class HomeGetUserErrorState extends HomeStates {
  final String error;

  HomeGetUserErrorState(this.error);
}

////chage Button Nav
class ChangeButtonNavState extends HomeStates {}

/// to oopen the add post screen
class AddPostState extends HomeStates {}

class ProfileProfileImageSuccessState extends HomeStates {}

class ProfileProfileImageErrorState extends HomeStates {}

class ProfileCoverImageSuccessState extends HomeStates {}

class ProfileCoverImageErrorState extends HomeStates {}

class uplaodingProfileImageSuccessState extends HomeStates {}

class uploadingProfileImageErrorState extends HomeStates {}

class uplaodingCoverImageSuccessState extends HomeStates {}

class uploadingCoverImageErrorState extends HomeStates {}

class userupDataLoadingState extends HomeStates {}

class userupDataErrorState extends HomeStates {}

class userupDataSuccessState extends HomeStates {}

// CreatePost

class postImageSuccessState extends HomeStates {}

class postImageErrorState extends HomeStates {}

class CreatePostLoadingState extends HomeStates {}

class CreatePostSuccessState extends HomeStates {}

class CreatePostErrorState extends HomeStates {}

class removePostImageState extends HomeStates {}

/// Get posts
class GetPostLoadingState extends HomeStates {}

class GetPostSucessState extends HomeStates {}

class GetPostErrorState extends HomeStates {
  final String error;

  GetPostErrorState(this.error);
}

/// add like post

class likePostSucessState extends HomeStates {}

class likePostErrorState extends HomeStates {
  final String error;

  likePostErrorState(this.error);
}

/// add comment post

class commentPostSucessState extends HomeStates {}

class commentPostErrorState extends HomeStates {
  final String error;

  commentPostErrorState(this.error);
}

/// Get user
class HomeGetAllUserLoadingState extends HomeStates {}

class HomeGetAllUserSucessState extends HomeStates {}

class HomeGetAllUserErrorState extends HomeStates {
  final String error;

  HomeGetAllUserErrorState(this.error);
}

/// Chat
class SendMessageSucessState extends HomeStates {}

class SendMessageErrorState extends HomeStates {}

class GetMessageSucessState extends HomeStates {}
