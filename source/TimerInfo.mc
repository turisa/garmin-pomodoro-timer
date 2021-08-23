import Toybox.Application.Storage;

class TimerInfo {
    var roundCount;
    var secondsLeft;
    
    function load() {
        roundCount = Storage.getValue("roundCount");
        secondsLeft = Storage.getValue("secondsLeft");
    }
    
    function save() {
        try {
            Storage.setValue("roundCount", roundCount);
            Storage.setValue("secondsLeft", secondsLeft);
        } catch ( ex ) {
            // Don't save.
        }
    }
}