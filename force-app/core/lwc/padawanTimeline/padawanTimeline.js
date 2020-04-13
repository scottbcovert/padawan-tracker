import { LightningElement, api, track } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import timeline from '@salesforce/resourceUrl/timeline';
import fetchTimelineEvents from '@salesforce/apex/PadawanTimelineController.fetchTimelineEvents';

export default class PadawanTimeline extends LightningElement {
    @api recordId;

    @track timelineEvents = [];

    connectedCallback() {
        Promise.all([
            loadStyle(this, timeline + '/timeline.min.css'),
            loadScript(this, timeline + '/timeline.min.js')
        ])
            .then(() => {
                fetchTimelineEvents({
                    babyId: this.recordId
                })
                    .then((events) => {
                        events.forEach((event) => {
                            let timelineEvent = {
                                date: new Date(
                                    event.eventDate
                                ).toLocaleString([], {
                                    dateStyle: 'short',
                                    timeStyle: 'short'
                                }),
                                title: event.title,
                                cssClass: 'timeline__item'
                            };
                            switch (event.type) {
                                case 'diaper_dirty':
                                    timelineEvent.cssClass +=
                                        ' timeline__item--icon icon-poop';
                                    break;
                                case 'diaper_wet':
                                    timelineEvent.cssClass +=
                                        ' timeline__item--icon icon-sweat-drops';
                                    break;
                                case 'feeding':
                                    timelineEvent.cssClass +=
                                        ' timeline__item--right timeline__item--icon icon-baby-bottle';
                                    break;
                                case 'pump':
                                    timelineEvent.cssClass +=
                                        ' timeline__item--right timeline__item--icon icon-fuel-pump';
                                    break;
                                case 'weighing':
                                    timelineEvent.cssClass +=
                                        ' timeline__item--right timeline__item--icon icon-scales';
                                    break;
                                default:
                                    // Do Nothing
                                    break;
                            }
                            this.timelineEvents.push(timelineEvent);
                        });
                    })
                    .catch((error) => {
                        // eslint-disable-next-line no-console
                        console.error(error);
                    });
            })
            .catch((error) => {
                // eslint-disable-next-line no-console
                console.error(error);
            });
    }
}
