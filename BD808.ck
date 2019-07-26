public class BD808 extends Chubgraph {
    inlet => BridgedT bt => LPF lpf => HardLimit hl => outlet;

    16000 => lpf.freq;
    47.444 => float freq;
    4.0 => float decay;
    2.0 => bt.gain;
    bt.setFreq(freq);
    bt.setDecay(decay);

    fun void noteOn(float accent) {
        if (accent != 0.0) {
            bt.setFreq(freq * 2.813);
            bt.noteOn();
            4::ms => now;
            bt.setFreq(freq);
        } else {
            noteOn();
        }
    }

    fun void noteOn() {
        bt.setFreq(freq);
        bt.noteOn();
    }

    fun float getCutoff() {
        return freq;
    }

    fun void setCutoff(float freq) {
        freq => lpf.freq;
    }

    fun void setFreq(float freq) {
        freq => bt.setFreq;
    }

    fun void setDecay(float decay) {
        decay => bt.setDecay;
    }
}