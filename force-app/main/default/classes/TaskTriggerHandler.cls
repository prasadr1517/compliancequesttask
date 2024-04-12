public class TaskTriggerHandler {
     public static void handleAfterUpdate(List<task> newTasks,Map<Id,Task> taskOldMap) {
        List<Account> updateAccounts = new List<Account>();
       List<PermissionSetAssignment> psa = [select id from PermissionSetAssignment where PermissionSet.Name ='CQ_Account_Admin' and AssigneeId =: userinfo.getUserID()];
        for (task tsk : newTasks) {
            if(taskOldMap.get(tsk.id).Status != 'Completed' && tsk.Status == 'Completed'){
                if(psa.size()>0){
                Account acc = new account();
                acc.id = tsk.WhatId;
                acc.Active__c = true;
                acc.Description = tsk.Description;
                updateAccounts.add(acc);
                }else{
                    tsk.addError('Please Contact System administrator');
                }
            }
           
        }
         if(updateAccounts.size()>0){
             update updateAccounts;
         }
        
        
    }
    

}