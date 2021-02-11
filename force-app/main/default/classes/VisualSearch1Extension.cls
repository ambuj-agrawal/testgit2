public class VisualSearch1Extension {
    public list<contact> cc{get;set;}
    public string ff{get;set;}

    public VisualSearch1Extension(ApexPages.StandardController controller) {
        cc= [select name, phone, email from contact];
        system.debug('dfdfdsfdsfd');
        
    }
    
    public list<contact> someName {
    get {
        // this block equals to: 
        //     public *var type* getSomeName()

        // work with someName 
        if(ff == null)
            someName = [select name, phone, email from contact];   
        return someName; 
        
    }
    set {
        // this block equals to: 
        //     public void setSomeName(*var type* value)

        // work with value
        SomeName=value;
        
    }
}
    
    public void searche(){
        someName=[select lastname, phone, email from contact where lastname like : ff];
        system.debug(ff);
        system.debug(someName.size());
    }
    
    public void incrementCounter() {
        system.debug(ff);
        if(ff != null)
        someName=[select lastname, phone, email from contact where lastname like : ff];
       
    }

}