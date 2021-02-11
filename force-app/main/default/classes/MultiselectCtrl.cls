public class MultiselectCtrl {
public MultiselectCtrl(){
    users = new List<UserWrapper>();

    for(User theUser : [Select Id from User]){
        UserWrapper uw = new UserWrapper();
        uw.u = theUser;
        uw.selected = false;
        users.add(uw);

    }
}

public Boolean showPopup {get;private set;}

public List<UserWrapper> users {get;set;}
public class UserWrapper {
    public User u {get;private set;}
    public Boolean selected {get;set;}
}
}