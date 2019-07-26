public class SD808 extends Chubgraph {
    BridgedT bt1 => LPF lpf => HardLimit hl => outlet;
    BridgedT bt2 => lpf;
    Noise wn => ExpEnvSwing contour => HPF hp => lpf;

    8000 => lpf.freq;
    2000 => hp.freq;

    173.334 => float freq1;
    3. => float decay1;
    335.976 => float freq2;
    3.5 => float decay2;

    bt1.setFreq(freq1); bt1.setDecay(decay1);
    bt2.setFreq(freq2); bt2.setDecay(decay2);
    
    contour.setTau(12.0);

    0.6 => bt1.gain;
    0.4 => bt2.gain;
    0.6 => wn.gain;

    fun void noteOn(float accent) {
        if (accent != 0.0) {
            noteOn(accent);
        } else {
            noteOn();
        }
    }

    fun void noteOn() {
        contour.noteOn();
        bt1.noteOn();
        bt2.noteOn();
    }

    fun void setFreq1(float freq) {
        freq => bt1.setFreq;
    }

    fun void setFreq2(float freq) {
        freq => bt2.setFreq;
    }

    fun void setDecay1(float decay) {
        decay => bt1.setDecay;
    }

    fun void setDecay2(float decay) {
        decay => bt2.setDecay;
    }
}