public class ExpEnvSwing extends Chubgraph {
    inlet => Envelope env1 => Envelope env2 => HalfRect hr => outlet;

    500::ms => env1.duration => env2.duration;

    fun void noteOn() {
        1 => env1.value => env2.value;
        env1.keyOff();
        env2.keyOff();
    }

    fun void setTau(float withTau) {
        (withTau/0.1419) * 1::ms => env1.duration => env2.duration;
    }
}