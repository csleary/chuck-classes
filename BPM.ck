public class BPM {
    static dur wholeNote, halfNote, quarterNote, eighthNote, sixteenthNote, thirtySecondNote;
    0 => static int locator;
    
    fun void setTempo(float bpm) {
        60. / bpm => float secondsPerBeat;
        secondsPerBeat::second => quarterNote;
        quarterNote * 4 => wholeNote;
        quarterNote * 2 => halfNote;
        quarterNote / 4 => sixteenthNote;
        quarterNote / 8 => thirtySecondNote;
    }

    // Spork this to set a global locator running.
    fun void barLoop() {
        while (true) {
            <<< "Bar: " + locator >>>;
            wholeNote => now;
            locator++;
        }
    }
}