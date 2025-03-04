// CODE TAKEN FROM https://gitlab.gnome.org/jrahmatzadeh/just-perfection
import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';
import * as SwitcherPopup from 'resource:///org/gnome/shell/ui/switcherPopup.js';

export default class SwitcherPopupDelayRemover extends Extension {
    constructor(metadata) {
        super(metadata);
        this._switcherPopup = null;
    }

    enable() {
        this._switcherPopup = SwitcherPopup;
        this.removeSwitcherPopupDelay();
    }

    disable() {
        if (this._switcherPopup) {
            this.switcherPopupDelaySetDefault();
            this._switcherPopup = null;
        }
    }

    switcherPopupDelaySetDefault() {
        let SwitcherPopupProto = this._switcherPopup.SwitcherPopup.prototype;
        if (!SwitcherPopupProto.showOld) {
            return;
        }
        SwitcherPopupProto.show = SwitcherPopupProto.showOld;
        delete(SwitcherPopupProto.showOld);
    }

    removeSwitcherPopupDelay() {
        let SwitcherPopupProto = this._switcherPopup.SwitcherPopup.prototype;
        SwitcherPopupProto.showOld = SwitcherPopupProto.show;
        SwitcherPopupProto.show = function (...args) {
            let res = this.showOld(...args);
            if (res) {
                this._showImmediately();
            }
            return res;
        };
    }
}
