public class SearchInAccount {

    public SearchInAccount(string a){
        //DateTime d= DateTime.newInstance(2016, 12, 9, 0, 0, 0);
        //system.debug(d);
        list<account> lss= [select name, type, CreatedDate from Account where Type= :a And CreatedDate=today];
        for(Account c: lss)
        {
         	//system.debug('---'+c.CreatedDate);
            system.debug(c.name);
        }
      
    }
}