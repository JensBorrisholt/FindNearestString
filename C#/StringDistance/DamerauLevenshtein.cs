using System;

namespace StringDistance
{
    public static class DamerauLevenshtein
    {
        public static int Get(string str1, string str2)
        {
            int Min(int a, int b, int c)
            {
                var result = a;
                if (b < result)
                    result = b;
                if (c < result)
                    result = c;
                return result;
            }

            var lenStr1 = str1.Length;
            var lenStr2 = str2.Length;

            if (lenStr1 * lenStr2 == 0)
                return Math.Max(lenStr1, lenStr1);

            var d = new int[lenStr2 + 1];

            for (var i = 0; i <= lenStr2; i++)
                d[i] = i;

            for (var i = 1; i <= lenStr1; i++)
            {
                var s1 = str1[i - 1];
                var prevCost = i - 1;
                var cost = i;

                for (var j = 1; j <= lenStr2; j++)
                {
                    var s2 = str2[j - 1];

                    cost = s1 == s2 || i > 1 && j > 1 && s1 == str2[j - 1] && s2 == str1[i - 1]
                        ? prevCost
                        : 1 + Min(cost, prevCost, d[j]);

                    prevCost = d[j];
                    d[j] = cost;
                }
            }
            
            return d[lenStr2];
        }
    }
}
