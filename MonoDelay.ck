public class MonoDelay extends Chubgraph
{
    // inlet => Gain dry => outlet;
    inlet => Delay delay => outlet;
    delay => Gain feedback => delay;

    220500::samp => delay.max;
    0.8 => feedback.gain;
    1::second => delay.delay;

    fun void setDelayTime(dur delayTime)
    {
        delayTime => delay.delay;
    }

    fun void setFeedback(float gain)
    {
        gain => feedback.gain;
    }
}