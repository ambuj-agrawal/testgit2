global class DailyLeadProcessor implements schedulable
{
   global void execute(SchedulableContext ctx)
   {
       
       list<lead> leadlst=[select id,lastname,company,status,LeadSource from lead where LeadSource =null limit 200];     
      for(integer i=0;i<leadlst.size();i++)
      {
          leadlst[i].leadsource= 'Dreamforce';
      }               
       update leadlst;
       system.debug('leadlst '+leadlst.size() );
        }
         
}