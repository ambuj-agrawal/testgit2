@RestResource(urlMapping='/Account/*')
global class AccountController {

    @HttpGet
    global static List<Account> getWidgets() {
        List<Account> widgets = [SELECT Name from Account];
        return widgets;
    }

    @HttpPost 
    global static String createNewWidget(String Name) {
        Account w = new Account();
        w.Name = Name;
        insert w;

        return 'Done';
   }

    @HttpDelete
    global static String deleteWidgetById() {
        String Id = RestContext.request.params.get('Id');
        List<Account> w = [ Select ID from Account where Id= :Id];

        delete w;

        return 'Deleted Widget';
    }

    @HttpPut
    global static String updateWidget(String Id, String NewName) {
        Account w = [ Select ID, Name from Account where Id= :Id];

        w.Name = NewName;
        update w;

        return 'Widget Updated';
    }
}