// 2018 Christopher Leary (ochremusic.com)
// Generate Euclidean rhythm arrays. E.g. pattern(5, 13) returns [1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0].

public class Euclidean
{
    fun int[] pattern (int pulses, int steps)
    {
        if (pulses > steps)
        {
            <<< "Error! Steps should be > pulses." >>>;
        }

        if (steps % pulses == 0)
        {
            int array[0];
            steps / pulses => int quotient; 
            for (0 => int i; i < pulses; i++)
            {
                array << 1;
                repeat(quotient - 1) array << 0;
            }
            return array;
        }

        int array[steps][0];
        steps - pulses => int rests;
        for (0 => int i; i < pulses; i++)
        {
            array[i] << 1;
        }
        for (pulses => int i; i < steps; i++)
        {
            array[i] << 0;
        }

        int m, r;
        if (pulses > rests)
        {
            pulses => m;
        }
        else
        {
            rests => m;
        }

        while (true)
        {
            for (m => int i; i < array.size(); i++)
            {
                for (0 => int j; j < array[i].size(); j++)
                {
                    array[i][j] => int remainder;
                    array[i - m] << remainder;
                }

                if (array[i].size() > 0) 
                {
                    repeat(array[i].size()) array[i].popBack();
                }
            }

            while (array[array.size() - 1].size() == 0)
            {
                array.popBack();
            }

            for (1 => int i; i < array.size(); i++)
            {
                if (array[i].size() < array[i-1].size()) i => m;
                array.size() - m => r;
            }
            if (r == 1) break;
        }

        int flattened[0];
        for (0 => int i; i < array.size(); i++)
        {
            for (0 => int j; j < array[i].size(); j++)
            {
                flattened << array[i][j];
            }
        }
        return flattened;
    }
}