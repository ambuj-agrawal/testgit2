global class FreezeUserBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        string admin='Standard Platform User';
        string admin1='Standard';
        list<string> profileName = new list<string>{'Standard Platform User','BD Sales Head', 'BD - Sales Team', 'Board of Director', 'Education Sales Team',
            'OP sales Head', 'OP - Sales Team', 'South Asia Sales Team', 'Vice President'};
                String query = 'SELECT Id,name,Profile.Name,userRole.Name,userName FROM User WHERE Profile.Name IN : profileName AND IsActive=True AND UserType =: admin1';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<User> scope) {
        list<Userlogin> uloginList= new list<Userlogin>();
        List<Event> eventList = new List<Event>();
        List<Task> taskList = new List<Task>();
        map<id,List<event>> eventMap = new map<id,List<event>>();
        map<id,List<task>> taskMap = new map<id,List<task>>();
        Set<id> IdForUserLogin = new Set<id>();
        
        Set<id> setId = new Set<id>();
        for(user u : scope){
            setId.add(u.id);
        }
        
        eventList =[select subject,ownerid from event where ownerid IN: setId and createddate=Today]; 
        taskList =[select subject,ownerid from task where ownerid IN: setId and createddate=Today];
        if(eventList.size() > 0){
            for(event e : eventList){
                if(!eventMap.containsKey(e.ownerid)){
                    List<event> eveList = new List<event>();
                    eventMap.put(e.ownerid,eveList);
                }
                eventMap.get(e.ownerid).add(e);
                
            }
        }
        system.debug('==map event=='+eventMap);
        if(taskList.size() > 0){
            for(task t : taskList){
                if(!taskMap.containsKey(t.ownerid)){
                    List<task> tasList = new List<task>();
                    taskMap.put(t.ownerid,tasList);
                }
                taskMap.get(t.ownerid).add(t);
            }
        }
        messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
        mail.setSaveAsActivity(false);
        List<String> sendto = new List<String>();
        sendTo.add('ambuj.agrawal21@gmail.com');
        mail.setToAddresses(sendto);
        mail.setSubject('Freezed User');
        String body = 'Dear,<br/><br/>';
        body += 'Please find below details of Freezed Users:<br/><br/><br/>';
        body += '<table border="1" style="font-family: arial, sans-serif;border-collapse: collapse;width: 100%;"><tr><th style="border: 1px solid #dddddd;text-align: left;padding: 8px;">Name</th><th style="border: 1px solid #dddddd;text-align: left;padding: 8px;">userName</th><th style="border: 1px solid #dddddd;text-align: left;padding: 8px;">Role</th><th style="border: 1px solid #dddddd;text-align: left;padding: 8px;">Profile</th></tr>';          
        system.debug('==map task=='+taskMap);
        for(user u : scope){
            if(!(taskMap.containsKey(u.id) && eventMap.containsKey(u.id))){
                system.debug('==test1==');
                IdForUserLogin.add(u.id);
                body += '<tr><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">' + u.name + '</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">' + u.Username + '</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">' + u.UserRole.Name + '</td><td style="border: 1px solid #dddddd;text-align: left;padding: 8px;">' + u.Profile.Name +'</td></tr>';
            }
        }
        body += '</table>';
        mail.setHtmlBody(body);
        if(IdForUserLogin.size() > 0){
            for(userLogin ul : [SELECT IsFrozen,UserId FROM UserLogin WHERE UserId IN: IdForUserLogin]){
                system.debug('==test2==');
                ul.IsFrozen=true;
                uloginList.add(ul);
                
            }
        }
        if(uloginList.size() > 0){
            update uloginList;
        }
       messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
    }  
    global void finish(Database.BatchableContext BC) {
    }
}