import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Background;
import Toybox.System;
import Toybox.Attention;
import Toybox.Application.Storage;

class PomodoroTimerApp extends Application.AppBase {

    hidden var _timerInfo;

    function initialize() {
        AppBase.initialize();
        _timerInfo = new TimerInfo();
    }

    // Returns the initial view of the application.
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new PomodoroTimerView(_timerInfo), new PomodoroTimerDelegate(_timerInfo) ] as Array<Views or InputDelegates>;
    }
    
    // Called on application start up
    // Loads the state of the timer from the storage.
    function onStart(state as Dictionary?) as Void {
        _timerInfo.load();
    }

    // Called when the application is exiting.
    // Saves the state of the timer to storage.
    function onStop(state as Dictionary?) as Void {
        _timerInfo.save();
    }

}

function getApp() as PomodoroTimerApp {
    return Application.getApp() as PomodoroTimerApp;
}
