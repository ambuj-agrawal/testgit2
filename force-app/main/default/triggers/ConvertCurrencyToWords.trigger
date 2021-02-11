trigger ConvertCurrencyToWords on Opportunity (before insert, before update) {

    for (Opportunity c : Trigger.new) {
        if (c.Amount != null && c.Amount >= 0) {
          
            Long n = c.Amount.longValue();
            string amo = ConvertCurrencyToWords.english_number(n);
            string amo1 = amo.remove(',');
            c.Amount_in_Words__c = amo1;
        } else {
            c.Amount_in_Words__c = null;
        }
    }
}