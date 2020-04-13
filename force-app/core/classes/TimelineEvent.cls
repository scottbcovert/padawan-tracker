public with sharing class TimelineEvent implements Comparable {
    @AuraEnabled
    public DateTime eventDate;
    @AuraEnabled
    public String title;
    @AuraEnabled
    public String type;

    public TimelineEvent(SObject so) {
        switch on so {
            when DiaperChange__c dc {
                this.eventDate = dc.Occurred__c;
                this.title = dc.Type__c + ' Diaper Change';
                this.type = dc.Type__c.contains('Dirty')
                    ? 'diaper_dirty'
                    : 'diaper_wet';
            }
            when Feeding__c f {
                this.eventDate = f.Occurred__c;
                this.title = 'Feeding (' + f.Type__c + ')';
                this.type = 'feeding';
            }
            when Weighing__c w {
                this.eventDate = w.Occurred__c;
                this.title = 'Weighing';
                this.type = 'weighing';
            }
            when null {
                // Do Nothing
            }
            when else {
                this.eventDate = (DateTime)so.get('CreatedDate');
                this.title = (String)so.get('Name');
            }
        }
    }

    public Integer compareTo(Object compareTo) {
        TimelineEvent compareToEvent = (TimelineEvent)compareTo;

        Integer returnValue = 0;
        if (eventDate != compareToEvent.eventDate) {
            returnValue = eventDate < compareToEvent.eventDate
                ? 1
                : -1;
        }
        return returnValue;
    }
}
