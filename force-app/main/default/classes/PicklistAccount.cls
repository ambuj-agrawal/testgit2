Public class PicklistAccount{
    public Id accountId{get;set;}
    Public List<SelectOption> accounts{get;set;}

public PicklistAccount(){
    accounts = new List<SelectOption>();
    accounts.add(new SelectOption('', '--None--'));

    for (Account account: [select Name from Account]) {
        accounts.add(new SelectOption(account.Id, account.Name));
    }

    
}


}