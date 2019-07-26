public class BridgedT extends Chubgraph {
    Impulse i => BPF b => HardLimit h1 => outlet;
    inlet => b;

    440 => b.freq;
    512 * 4.0 => b.gain;
    512 => b.Q;

    fun void noteOn() {
        1 => i.next;
    }

    fun void setFreq(float withFreq) {
        withFreq => b.freq;
    }

    fun void setDecay(float withDecay) {
        Math.max(Math.min(withDecay, 10.0), 1.0) => withDecay;
        Math.pow(2.0, withDecay) => b.Q;
        Math.pow(2.0, withDecay) * 64.0 => b.gain;
    }
}