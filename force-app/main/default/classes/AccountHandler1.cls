public class AccountHandler1

{

    public static Account insertAccount(String acctName)

    {

        Account acct = New Account(Name=acctName);

        try

        {

           

            //insert Account

            insert acct;

            // get id of account

            ID acctID = acct.Id;

            System.debug('Account Inserted || ID = ' + acctID + ' || Account Name = ' + acct.Name);

           

        }

       

                    

        catch (System.DmlException e)

        {

                                for (Integer i = 0; i < e.getNumDml(); i++)

               {

                               // Process exception here

                               System.debug('An exception has occured: ' + e.getMessage() + 'DML Field: ' + e.getDmlFields(i) + 'DML Message: ' + e.getDmlMessage(i));

                return null;

                                }

        }

        return acct;

    }

 

}