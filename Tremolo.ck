public class Tremolo extends Chugen {
    TriOsc lfo => blackhole; 
    5 => lfo.freq;
    
    function float tick(float in) {
        return in * lfo.last();
    }

    function float freq(float frequency) {
        frequency => lfo.freq;
        return frequency;
    } 

    function float freq() {
        return lfo.freq();
    }
}
