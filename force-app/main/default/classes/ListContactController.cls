/**
*@purpose : Apex Controller resposible for displaying all contact in a pageblock table form where we can delete edit contact 
*@author :  Ashis.behera 
**/
public class ListContactController {

     //variable to hold Contact Record and id
     public Contact contact{get;set;}
     public Id contactId{get;set;}
     
     //wrapperlist variable to hold contact
     List<ContactWrapper> contactList = new List<ContactWrapper>();
     
     //varibale for list of contact records which are selected for mass delete
     List<Contact> selectedContacts = new List<Contact>();
      public List<Contact> test{get;set;}
     
     /**
    *@purpose : Standard Parameterised Constructor to create Contact Reference
    **/
     public ListContactController(ApexPages.StandardController controller) {
         Contact contact = new Contact();
         test = new List<Contact>();
        }
     
      /**
       *@purpose : Method to display contacts in a table 
       *@Param : None 
       *@Return : List<contactwrapper>
      **/
        public  List<ContactWrapper> getContacts() {
            for(Contact c: [SELECT Id,Name,Accountid,Account.Name,MobilePhone,Email FROM Contact ORDER BY createdDate DESC]){
                contactList.add(new ContactWrapper(c));
             }   
                return contactList;
        }
        
        /**
         *@purpose : Method to hold selected contacts  
         *@Param : None 
         *@Return : Pagereference
         **/
          public PageReference getSelected() {
              System.debug('======Inside the Get Function======');
              selectedContacts.clear();
              
              //adding contacts in list 
              for(ContactWrapper conWrapper: contactList) {
                 if(conWrapper.selected == true) {
                     selectedContacts.add(conWrapper.con); 
                  }
               }      
              return null;
          }
          
        //getting selected contacts
          public List<Contact> getSelectedContacts() {
              if(selectedContacts.size()>0) {
                  return selectedContacts;
               }  
               else {
                   return null;
               } 
          } 
           
        /**
         *@purpose : Method to save records from inline edit  
         *@Param : None 
         *@Return : Pagereference
         **/
          public PageReference Save() { 
              System.debug('******Inside ****** '+selectedContacts.size()+selectedContacts);
              update selectedContacts;
                 
              PageReference listContact=new PageReference('/apex/ListContact');
              listContact.setRedirect(true);
              return listContact;
           }
             
         /**
          *@purpose : Method to redirect to standard contact detail page    
          *@Param : None 
          *@Return : Pagereference
          **/
          public PageReference go() {
          
              //getting contact id form Url
              contactId= ApexPages.currentPage().getParameters().get('conId');
              contact =[SELECT Id,Name,Account.Name,MobilePhone,Email FROM Contact WHERE Id =: contactId];
              return (new ApexPages.StandardController(contact)).view();
          }
            
         /**
          *@purpose : wrapper class to use check box inside the table   
          *@author :  Ashis.behera 
         **/
         public class ContactWrapper {
             public Contact con{get; set;}
             public Boolean selected{get; set;}
             public ContactWrapper(Contact c) {
                con = c;
                selected = false;
             }
         }
        
          /**
           *@Purpose : Test Method to achieve Code Coverage and handeling exception
           *@Param : None 
           *@Return : void
           **/
          /*private static testmethod void t1() {
               test.startTest();
               Contact conTest = new Contact(LastName = 'asish',Phone = '1111111111');
               insert conTest;
               ApexPages.StandardController sc = new ApexPages.StandardController(conTest);
               Listcontactcontroller  ptest = new ListContactController(sc);
               ptest.getContacts();
               ptest.getSelected();
               ptest.getSelectedContacts();
               ptest.Save();
               System.currentPageReference().getParameters().put('conId',conTest.Id);
               System.currentPageReference().getParameters().put('conId',conTest.Id);
               ptest.go();
               System.currentPageReference().getParameters().put('conId',conTest.Id);
               ptest.redirect();
               test.stopTest();
               
           }*/
  }