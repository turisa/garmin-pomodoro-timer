import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;


class PomodoroTimerMenuDelegate extends WatchUi.MenuInputDelegate {
    hidden var _timerInfo;

    function initialize(timerInfo) {
        MenuInputDelegate.initialize();
        _timerInfo = timerInfo;
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            var message = "Reset timer?";
            var dialog = new WatchUi.Confirmation(message);
            
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
         
            WatchUi.pushView(
                dialog,
                new ResetConfirmationDelegate(_timerInfo),
                WatchUi.SLIDE_IMMEDIATE
            );
        }
    }
}