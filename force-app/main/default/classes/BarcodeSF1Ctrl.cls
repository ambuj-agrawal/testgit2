public with sharing class BarcodeSF1Ctrl 
{
    @RemoteAction
    public static String getRecordFromBarcode(String bcStr)
    {
        String result;
        List<String> eles=bcStr.split(':');
        
        String code=eles[1].trim();
        List<Account> accs=[select id, Barcode__c from Account where Barcode__c=:code];
        if (0!=accs.size())
        {
            result=accs[0].id;
        }
        else
        {
            result='Error: no record matching ' + code + ' found';
        }
        
        return result;
    }
}