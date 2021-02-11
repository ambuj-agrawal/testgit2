Public class UsingSoapApi{
    private NTLMAuth mNtlm;
    Public void med1(){
        String username      = 'Singerindia\\Lokesh';
        String password      = 'Welcome@123';  
        HttpClient httpObj   = new HttpClient(username,password,True);   
        String Autt = httpObj.Authr();
        microsoftDynamicsSchemasPageCustomer.ReadMultiple_Result_element[] ss = new microsoftDynamicsSchemasPageCustomer.ReadMultiple_Result_element[]{};
        microsoftDynamicsSchemasPageCustomer.Customer_Port cp = new microsoftDynamicsSchemasPageCustomer.Customer_Port();
        cp.inputHttpHeaders_x = new Map<String,String>();
        //cp.inputHttpHeaders_x.put('SOAPAction','ReadMultiple');
        //cp.inputHttpHeaders_x.put('Content-Type','text/xml;charset=UTF-8');
        //cp.inputHttpHeaders_x.put('Accept-Encoding','gzip,deflate');
        cp.inputHttpHeaders_x.put('Authorization',Autt);
        microsoftDynamicsSchemasPageCustomer.ReadMultiple_element ddd = new microsoftDynamicsSchemasPageCustomer.ReadMultiple_element();
        //ss = cp.ReadMultiple(null, null, 1);
        system.debug(cp.ReadMultiple(null, null, 1));
        
    }
}