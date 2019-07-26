class Fuzz extends Chugen
{
    3.0 => float p;
    2 => intensity;
    
    fun float tick(float in)
    {
        Math.sgn(in) => float sgn;
        return Math.pow(Math.fabs(in), p) * sgn;
    }
    
    fun void intensity(float i)
    {
        if (i > 1) 1.0/i => p;
    }
}