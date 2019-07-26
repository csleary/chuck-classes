BPM bpm;
bpm.sixteenthNote => dur sixteenth;

class FilterModule extends Chubgraph {
    inlet => WPKorg35 filter => outlet;
    SinOsc lfo1 => blackhole;
    SawOsc lfo2 => lfo1;
    
    1. => lfo1.gain;
    2 => lfo1.sync;
    600 => float filterCutoff;
    500 => float modAmount;
    1 => float modDepth;
    Math.random2f(.2, 1.5) => float lfo1Freq;
    Math.random2f(200, 8000) => float lfo2Freq;
    Math.random2(1200, 10000) => float lfo2Gain;
    Math.random2f(1.2, 1.8) => float filterRes;
    
    fun void modulate()
    {
        lfo1Freq => lfo1.freq;
        lfo2Freq => lfo2.freq;
        lfo2Gain => lfo2.gain;
        filterRes => filter.resonance;

        while (true)
        {
            lfo1.last() * (modAmount * modDepth) + filterCutoff => float value;
            if (value < 0)
            {
                0 => value; 
            }
            value => filter.cutoff; 
            samp => now; 
        } 
    }

    fun void setCutoff(float freq)
    {
        freq => filterCutoff;
    }

    fun void setRes(float res)
    {
        res => filterRes;
    }

    fun void setLfo1Freq(float freq)
    {
        freq => lfo1Freq;
    }

    fun void setLfo2Freq(float freq)
    {
        freq => lfo2Freq;
    }

    fun void setLfo2Gain(float gain)
    {
        gain => lfo2Gain;
    }

    fun void setModAmount(float amount)
    {
        amount => modAmount;
    }

    fun void setModDepth(float depth)
    {
        depth => modDepth;
    }
}

/*
Params:
setHpfFreq (float Hertz)
setPanSpread (float -1 to 1)
setVoiceCount (int)
*/

public class ModPoly extends Chubgraph
{
    Gain channelL => dac.left;
    Gain channelR => dac.right;
    .2 => channelL.gain => channelR.gain;
    1. => float panSpread;
    2 => int voiceCount;
    150 => float hpfFreq;


    fun void noteOn(int note, int currentVoice)
    {
        BlitSaw saw => HPF hpf => FilterModule filter => ADSR envAmp => Pan2 panner;
        panner.left => channelL;
        panner.right => channelR;
        spork ~ filter.modulate();
        .1 => saw.gain;
        Std.mtof(note + Math.random2f(-.1, .1)) => saw.freq;
        hpfFreq => hpf.freq;

        envAmp.set(4::sixteenth, 3::sixteenth, .3, 20::sixteenth);

        (Std.fabs(panSpread) * 2) / (voiceCount - 1) => float spreadStep;
        -panSpread + (spreadStep * currentVoice) => float pan;
        pan => panner.pan;


        envAmp.keyOn();
        4::sixteenth => now;
        envAmp.keyOff();
        envAmp.releaseTime() => now;
    }

    fun void setHpfFreq(float freq)
    {
        freq => hpfFreq;
    }

    fun void setPanSpread(float newPanSpread)
    {
        newPanSpread => panSpread;
    }

    fun void setVoiceCount(int newVoiceCount)
    {
        newVoiceCount => voiceCount;
    }
}