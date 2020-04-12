import { LightningElement } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import timeline from '@salesforce/resourceUrl/timeline';

export default class PadawanTimeline extends LightningElement {
    connectedCallback() {
        Promise.all([
            loadStyle(this, timeline + '/timeline.min.css'),
            loadScript(this, timeline + '/timeline.min.js')
        ])
            .then(() => {
                // ToDo: Fetch Data
            })
            .catch((error) => {
                // eslint-disable-next-line no-console
                console.error(error);
            });
    }
}
