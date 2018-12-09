using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using StringDistance;

namespace ConsoleApp1
{

    class Program
    {
        static void Main(string[] args)
        {
            var gWordList = new List<string>();

            foreach (var s in File.ReadAllLines("../../../../In Search of Lost Time/Swann's Way.txt"))
                gWordList.AddRange(s.Split(' ').Where(t => t.Trim() != string.Empty));

            const string searchWord = "HEST";

            var stopwatch = Stopwatch.StartNew();
            var word = gWordList.FindNearestString(searchWord);
            stopwatch.Stop();

            Console.WriteLine("Test 1: CaseSsensetive: False");
            Console.WriteLine($"Number of elements in list: {gWordList.Count}");
            Console.WriteLine($"Nearest word to {searchWord} : {word}");
            Console.WriteLine($"Elapsed Milliseconds: {stopwatch.ElapsedMilliseconds}");
            Console.WriteLine($"Average speed elements/ms:{ (int)(gWordList.Count / stopwatch.ElapsedMilliseconds) }");

            stopwatch = Stopwatch.StartNew();
            word = gWordList.FindNearestString(searchWord, true);
            stopwatch.Stop();

            Console.WriteLine("");
            Console.WriteLine("");
            Console.WriteLine("Test 2: CaseSsensetive: True");
            Console.WriteLine($"Number of elements in list: {gWordList.Count}");
            Console.WriteLine($"Nearest word to {searchWord} : {word}");
            Console.WriteLine($"Elapsed Milliseconds: {stopwatch.ElapsedMilliseconds}");
            Console.WriteLine($"Average speed elements/ms:{ (int)(gWordList.Count / stopwatch.ElapsedMilliseconds) }");

            Console.WriteLine();
            Console.ReadLine();
        }
    }
}


