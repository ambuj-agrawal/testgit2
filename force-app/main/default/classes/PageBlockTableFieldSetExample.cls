public with sharing class PageBlockTableFieldSetExample {
    public Product2[] products {get; private set;}
    public String[] fields {get; private set;}

    public PageBlockTableFieldSetExample() {
        String apiName = 'Product2';
        fields = new List<String>(Schema.getGlobalDescribe().get(apiName).getDescribe().fields.getMap().keySet());
        fields.sort();
        products = Database.query('select ' + String.join(fields, ',') + ' from ' + apiName + ' order by Name limit 100');
        system.debug(products);
    }
}