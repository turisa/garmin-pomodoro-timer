using Toybox.WatchUi;
using Toybox.System;

class MyConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    
    const WORK_DURATION = 25 * 60;
    hidden var _timerInfo;
    
    function initialize(timerInfo) {
        ConfirmationDelegate.initialize();
        _timerInfo = timerInfo;
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_NO) {
            System.println("Cancel");
        } else {
            _timerInfo.roundCount = 0;
            _timerInfo.secondsLeft = WORK_DURATION;
        }
    }
}