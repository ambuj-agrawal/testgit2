global class myfirstbach implements database.batchable<sobject>{

    global database.querylocator start(database.batchablecontext bc){
        string query = 'select lastname, title from contact';
        return database.getquerylocator(query);
    }
    
    global void execute(database.batchablecontext bc, list<contact> cc){
        
        for(Contact c: cc){
            c.title='bachupdate';
        }
        update cc;
    }
    global void finish(database.batchablecontext bc){
    }
    
    
}