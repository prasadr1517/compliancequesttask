public class AccountTriggerHandler {
    public static void handleAfterInsert(List<Account> newAccounts) {
        List<Task> newTasks = new List<Task>();
        
        for (Account acc : newAccounts) {
            if(acc.Active__c == false){
            Task t = new Task();
            t.Subject = 'Review Account - ' + acc.AccountNumber;
            t.ActivityDate = System.today().addDays(7);
            t.OwnerId = acc.OwnerId;
            t.Status = 'Not Started';
            t.WhatId = acc.Id; 
            newTasks.add(t);
            }else{
                acc.addError('A customer requires that accounts must only be added as Inactive');
            }
        }
        
        if (!newTasks.isEmpty()) {
            insert newTasks;
        }
       
    }
    
}