import Toybox.Lang;
import Toybox.WatchUi;

class PomodoroTimerDelegate extends WatchUi.BehaviorDelegate {
    hidden var _timerInfo;
    
    function initialize(timerInfo) {
        BehaviorDelegate.initialize();
        _timerInfo = timerInfo;
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new PomodoroTimerMenuDelegate(_timerInfo), WatchUi.SLIDE_UP);
        return true;
    }

}