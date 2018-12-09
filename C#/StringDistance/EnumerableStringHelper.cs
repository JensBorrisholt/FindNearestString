using System.Collections.Generic;

namespace StringDistance
{
    public static class EnumerableStringHelper
    {
        public static string FindNearestString(this IEnumerable<string> sourceList, string compareString, bool caseSensetive = false)
        {
            var minDistance = int.MaxValue;
            var result = string.Empty;

            if (!caseSensetive)
                compareString = compareString.ToUpper();

            foreach (var word in sourceList)
            {
                var distance = DamerauLevenshtein.Get(caseSensetive ? word : word.ToUpper(), compareString);

                if (distance == 0)
                    return word;

                if (distance < minDistance)
                {
                    minDistance = distance;
                    result = word;
                }
            }

            return result;
        }
    }
}
