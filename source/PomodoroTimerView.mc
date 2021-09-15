import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Time.Gregorian;
import Toybox.Timer;
import Toybox.Attention;

class PomodoroTimerView extends WatchUi.View {
    
    const LONG_BREAK_DURATION = 15 * 60;
    const BREAK_DURATION = 5 * 60;
    const WORK_DURATION = 25 * 60;

    // Timer info to display.
    hidden var _timerInfo;
    
    // String resources.
    hidden var _labelWork;
    hidden var _labelBreak;
    hidden var _labelStart;
    
    function initialize(timerInfo) {
        View.initialize();
        _timerInfo = timerInfo;
        
        if (_timerInfo.roundCount == null || _timerInfo.secondsLeft == null) {
            _timerInfo.roundCount = 0;
            _timerInfo.secondsLeft = WORK_DURATION;
        }
        
        new Timer.Timer().start(method(:updateTimerInfo), 1000, true);
    }
        
    // Updates the timer info.
    function updateTimerInfo() {
        _timerInfo.secondsLeft--;
        
        if (_timerInfo.secondsLeft <= 0) {
            _timerInfo.roundCount = (_timerInfo.roundCount + 1) % 10;
            
            if (_timerInfo.roundCount % 2 == 0) {
                _timerInfo.secondsLeft = WORK_DURATION;
            } else {
                _timerInfo.secondsLeft = _timerInfo.roundCount == 9 ? LONG_BREAK_DURATION : BREAK_DURATION;
            }
            
            vibrate();
        }
    }
    
    // Makes the device vibrate for two seconds.
    function vibrate() {
        var vibeData =
            [
                new Attention.VibeProfile(50, 2000)
            ];
        Attention.vibrate(vibeData);
    }

    // Loads the resources.
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        
        _labelWork = WatchUi.loadResource(Rez.Strings.LabelWork);
        _labelBreak = WatchUi.loadResource(Rez.Strings.LabelBreak);
        _labelStart = WatchUi.loadResource(Rez.Strings.LabelStart);
    }

    // Updates the view.
    function onUpdate(dc as Dc) as Void {
        setPomodoroCountDisplay();
        setMessageDisplay();
        setTimerDisplay();
        setTimeDisplay();
        
        View.onUpdate(dc);
    }
    
    // Sets the pomodoro count display.
    function setPomodoroCountDisplay() {
        var view = View.findDrawableById("PomodoroCountDisplay");
        
        var pomodoroCount = ((_timerInfo.roundCount)/ 2.0).toNumber() + 1;
        var pomodoroCountString = "#" + pomodoroCount.toString();
        
        view.setText(pomodoroCountString);
    }
    
    // Sets the timer display.
    function setTimerDisplay() {
        var view = View.findDrawableById("TimerDisplay");
        
        var minutesLeft = ((_timerInfo.secondsLeft - 1)/ 60.0).toNumber() + 1;
        
        view.setText(minutesLeft.toString());
    }
    
    // Sets the message display.
    function setMessageDisplay() {
        var view = View.findDrawableById("MessageDisplay");
        
        var message = _timerInfo.roundCount % 2 == 0 ? _labelWork : _labelBreak;
        
        view.setText(message);
    }
    
    // Sets the time display.
    function setTimeDisplay() {
        var view = View.findDrawableById("TimeDisplay");
        
        var clockTime = System.getClockTime();
        var hourString = Lang.format(
            "$1$:$2$", 
            [
                clockTime.hour.format("%02d"), 
                clockTime.min.format("%02d")
            ]
        );
        
        view.setText(hourString);   
    }
}
