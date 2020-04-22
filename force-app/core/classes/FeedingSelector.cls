public with sharing class FeedingSelector {

    public static Map<Id,Feeding__c> getFeedingsByIdForBaby(Id babyId) {
        return new Map<Id,Feeding__c>([
            SELECT
            Id,
            Name,
            Baby__c,
            Occurred__c,
            Type__c,
            Amount__c
            FROM Feeding__c
            WHERE Baby__c = :babyId
        ]);
    }
}
