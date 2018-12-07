unit FindNearestStringU;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TDamerauLevenshtein = record
  public
    class function Distance(const Str1, Str2: string): Integer; static;
  end;

  FindNearestString = record
  public
    class function Get(aSourceList: TStrings; aComapreString: string; aCaseSensetive: Boolean = false): string; overload; static;
    class function Get(aSourceList: TEnumerable<string>; aComapreString: string; aCaseSensetive: Boolean = false): string; overload; static;
  end;

implementation

uses
  System.Sysutils, System.Math;

{ TLevenshteinDistance }

class function TDamerauLevenshtein.Distance(const Str1, Str2: string): Integer;
  function Min(const A, B, C: Integer): Integer;
  begin
    Result := A;
    if B < Result then
      Result := B;
    if C < Result then
      Result := C;
  end;

var
  LenStr1, LenStr2: Integer;
  i, j, t, cost, PrevCost: Integer;
  pStr1, pStr2, S1, S2: PChar;
  d: PIntegerArray;
begin
  LenStr1 := length(Str1);
  LenStr2 := length(Str2);

  // save a bit memory by making the second index points to the shorter string
  if LenStr1 < LenStr2 then
  begin
    t := LenStr1;
    LenStr1 := LenStr2;
    LenStr2 := t;
    pStr1 := PChar(Str2);
    pStr2 := PChar(Str1);
  end
  else
  begin
    pStr1 := PChar(Str1);
    pStr2 := PChar(Str2);
  end;

  // bypass leading identical characters
  while (LenStr2 <> 0) and (pStr1^ = pStr2^) do
  begin
    Inc(pStr1);
    Inc(pStr2);
    Dec(LenStr1);
    Dec(LenStr2);
  end;

  // bypass trailing identical characters
  while (LenStr2 <> 0) and ((pStr1 + LenStr1 - 1)^ = (pStr2 + LenStr2 - 1)^) do
  begin
    Dec(LenStr1);
    Dec(LenStr2);
  end;

  // is the shorter string empty? so, the edit distance is length of the longer one
  if LenStr2 = 0 then
    Exit(LenStr1);

  // calculate the edit distance
  GetMem(d, (LenStr2 + 1) * SizeOf(Integer));

  for i := 0 to LenStr2 do
    d[i] := i;

  S1 := pStr1;
  for i := 1 to LenStr1 do
  begin
    PrevCost := i - 1;
    cost := i;
    S2 := pStr2;

    for j := 1 to LenStr2 do
    begin
      if (S1^ = S2^) or ((i > 1) and (j > 1) and (S1^ = (S2 - 1)^) and (S2^ = (S1 - 1)^)) then
        cost := PrevCost
      else
        cost := 1 + Min(cost, PrevCost, d[j]);

      PrevCost := d[j];
      d[j] := cost;
      Inc(S2);
    end;
    Inc(S1);
  end;

  Result := d[LenStr2];
  FreeMem(d);
end;

{ TFindNearestString }

class function FindNearestString.Get(aSourceList: TEnumerable<string>; aComapreString: string; aCaseSensetive: Boolean): string;
var
  Distance, MinDistance: Integer;
  aWord: string;
begin
  MinDistance := MaxInt;
  Result := '';

  if not aCaseSensetive then
    aComapreString := AnsiUpperCase(aComapreString);

  for aWord in aSourceList do
  begin
    if aCaseSensetive then
      Distance := TDamerauLevenshtein.Distance(aWord, aComapreString)
    else
      Distance := TDamerauLevenshtein.Distance(AnsiUpperCase(aWord), aComapreString);

    if Distance = 0 then
      Exit(aWord);

    if Distance < MinDistance then
    begin
      MinDistance := Distance;
      Result := aWord;
    end;
  end;
end;

class function FindNearestString.Get(aSourceList: TStrings; aComapreString: string; aCaseSensetive: Boolean): string;
var
  Distance, MinDistance: Integer;
  aWord: string;
begin
  MinDistance := MaxInt;
  Result := '';

  if not aCaseSensetive then
    aComapreString := AnsiUpperCase(aComapreString);

  for aWord in aSourceList do
  begin
    if aCaseSensetive then
      Distance := TDamerauLevenshtein.Distance(aWord, aComapreString)
    else
      Distance := TDamerauLevenshtein.Distance(AnsiUpperCase(aWord), aComapreString);

    if Distance = 0 then
      Exit(aWord);

    if Distance < MinDistance then
    begin
      MinDistance := Distance;
      Result := aWord;
    end;
  end;

end;

end.
