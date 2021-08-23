import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class PomodoroTimerMenuDelegate extends WatchUi.MenuInputDelegate {
    const WORK_DURATION = 25 * 60;
    
    hidden var _timerInfo;

    function initialize(timerInfo) {
        MenuInputDelegate.initialize();
        _timerInfo = timerInfo;
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            _timerInfo.roundCount = 0;
            _timerInfo.secondsLeft = WORK_DURATION;
        }
    }

}