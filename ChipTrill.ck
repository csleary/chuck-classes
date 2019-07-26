public class ChipTrill extends Chubgraph {
    BPM tempo;
    tempo.sixteenthNote => dur sixteenth;

    inlet => BlitSaw osc => ADSR env => outlet;
    .5 => osc.gain;

    fun void setGain(float gain) {
        gain => osc.gain;
    }

    fun void noteOn(int pitch) {
        Std.mtof(pitch+(Math.random2(0, 3)*12)) => osc.freq;
        env.set(0::ms, 1::sixteenth/Math.random2(1, 4), Math.random2f(0, .2), 1::sixteenth);
        env.keyOn();
        1::sixteenth => now;
        env.keyOff();
        env.releaseTime() => now;
        
        if (!Math.random2(0, 2)) {
            repeat (4) {
                1::sixteenth/8 => now;
                osc.freq() => float freq;
                Std.mtof(Std.ftom(osc.freq())+12) => freq;
                freq => osc.freq;
                1::sixteenth/8 => now;
                osc.freq() => freq;
                Std.mtof(Std.ftom(osc.freq())-12) => freq;
                freq => osc.freq;
            }
        }
    }
}