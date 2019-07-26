public class HardLimit extends Chubgraph {
    inlet => Dyno d => outlet;

    d.limit();
    0::ms => d.attackTime => d.releaseTime;
    0. => d.slopeAbove;
    1. => d.thresh;
}