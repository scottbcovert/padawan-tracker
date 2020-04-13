public with sharing class DiaperChangeSelector {

    public static Map<Id,DiaperChange__c> getDiaperChangesByIdForBaby(Id babyId) {
        return new Map<Id,DiaperChange__c>([
            SELECT
            Id,
            Name,
            Baby__c,
            Occurred__c,
            Type__c
            FROM DiaperChange__c
            WHERE Baby__c = :babyId
        ]);
    }
}
