# FindNearestString
How to find the nearest string in a list

## Find the nearest string in a list

Locating a string in a list is pretty straightforward: List.IndexOf. If the return value is zero or greater than zero then you have a match.  The only problem is if you by accident typed **Hest** instead of **Dest** then your IndexOf will fail. Eventhough its pretty close.

The solution is to implement an algorithm to calcualte the "distance" between two strings and return the word with the minimum distance.

For this purpose I've chosen the Damerau-Levenshtein algorithm.

Damerau-Levenshtein distance is an extension to Levenshtein distance. It is also defined as minimum number of simple edit operations on string to change it into another, but the list of allowed operations is extended.

As it is written on Wikipedia there are 4 allowed edits: deletion, insertion and substitution of an single character and an transposition of two adjacent characters.

Example. Such defined distance between words gifts and profit is 5:

* gifts   => pgifts    (insertion of 'p')
* pgifts  => prgifts   (insertion of 'r')
* prgifts => proifts   (substitution of 'g' to 'o')
* proifts => profits   (transposition of 'if' to 'fi')
* profits => profit    (deletion of 's')

Inorder for making use of this in a list I've create a helper class acception either a TStrings or a TEnumerable<string> as source list. The interface is simple: 

```
  FindNearestString = record
  public
    class function Get(aSourceList: TStrings; aComapreString: string; aCaseSensetive: Boolean = false): string; overload; static;
    class function Get(aSourceList: TEnumerable<string>; aComapreString: string; aCaseSensetive: Boolean = false): string; overload; static;
  end;
```

### Demo

The enclosed Demo Application sweeps through a directour and find all pas filed, and make a simple attempt to get all words in the pas file. Theese words a placed in a list and uses for test. The path is hardcoded to **C:\Program Files (x86)\Embarcadero\Studio\19.0\source\** change it to fit you Delphi installation.  I just needed an quick and dirthy way to get test data. 

![Program Demo](https://github.com/JensBorrisholt/FindNearestString/blob/master/Screenshot.png)

The application will perform the test using both a TStringlist and a TList<string> to perform at Find Nearest Strign  case insensetive. 

### Techniques

In this solution, different techniques have been Implemented.

* Find Nearest String in TStrings (decendant) 
* Find Nearest String in TEnumerable<string> (decendant) 
* Calculate the Damerau-Levenshtein distance between two strings


