global class ChangeprofilePic {
    
    global String profileImageUrl { get; set; }
 public blob blbImageBody { get; set; }
    List<user> lstuser;   
    global ChangeprofilePic () 
    {
         lstuser = [select FullPhotoUrl from User where Id =: UserInfo.getUserId()];
         profileImageUrl=lstuser[0].FullPhotoUrl; 
         //blbImageBody = '';
    }
    

     public void upload() 
     {
     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully : '+blbImageBody ));
       String communityId = null;
       String userId= UserInfo.getUserId();
       //res.AuthorId = UserInfo.getUserId();
       //res.FolderId = UserInfo.getUserId(); 
       //blob picContect = res.getBodyAsBlob();  


ConnectApi.BinaryInput fileUpload = new ConnectApi.BinaryInput(blbImageBody, 'image/jpg', 'userImage.jpg');  
//ConnectApi.Photo photoProfile = ConnectApi.ChatterUsers.setPhoto(communityId, userId, fileUpload);
ConnectApi.Photo photoProfile = ConnectApi.UserProfiles.setPhoto(communityId, userId, fileUpload);
         //ConnectApi.UserProfiles.setPhotoWithAttributes(communityId, userId, photo)
    }


}