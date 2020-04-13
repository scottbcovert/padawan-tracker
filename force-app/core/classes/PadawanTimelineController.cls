public with sharing class PadawanTimelineController {

    @AuraEnabled(cacheable=true)
    public static List<TimelineEvent> fetchTimelineEvents(Id babyId) {
        List<TimelineEvent> events = new List<TimelineEvent>();
        Map<Id,DiaperChange__c> diaperChangesById = DiaperChangeSelector.getDiaperChangesByIdForBaby(babyId);
        if (!diaperChangesById.isEmpty()) {
            for (DiaperChange__c dc : diaperChangesById.values()) {
                events.add(
                    new TimelineEvent(dc)
                );
            }
        }
        Map<Id,Feeding__c> feedingsById = FeedingSelector.getFeedingsByIdForBaby(babyId);
        if (!feedingsById.isEmpty()) {
            for (Feeding__c f : feedingsById.values()) {
                events.add(
                    new TimelineEvent(f)
                );
            }
        }
        Map<Id,Weighing__c> weighingsById = WeighingSelector.getWeighingsByIdForBaby(babyId);
        if (!weighingsById.isEmpty()) {
            for (Weighing__c w : weighingsById.values()) {
                events.add(
                    new TimelineEvent(w)
                );
            }
        }
        events.sort();
        return events;
    }
}
