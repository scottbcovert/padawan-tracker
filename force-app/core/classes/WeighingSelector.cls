public with sharing class WeighingSelector {

    public static Map<Id,Weighing__c> getWeighingsByIdForBaby(Id babyId) {
        return new Map<Id,Weighing__c>([
            SELECT
            Id,
            Name,
            Baby__c,
            Feeding__c,
            Feeding__r.Name,
            Feeding__r.Type__c,
            Occurred__c,
            InitialWeight__c,
            PercentWeightGainFromFeeding__c,
            PercentWeightGainSinceBirth__c,
            PostFeedingWeight__c,
            WeightGainFromFeeding__c,
            WeightGainSinceBirth__c
            FROM Weighing__c
            WHERE Baby__c = :babyId
        ]);
    }
}
