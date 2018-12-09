unit FindNearestStringU;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TDamerauLevenshtein = class
  public
    class function Distance(const Str1, Str2: string): Integer; static;
    class function GetDistance(const s, t: string): Integer; static;
  end;

  FindNearestString = record
  public
    class function Get(aSourceList: TStrings; aComapreString: string; aCaseSensetive: Boolean = false): string; overload; static;
    class function Get(aSourceList: TEnumerable<string>; aComapreString: string; aCaseSensetive: Boolean = false): string; overload; static;
  end;

implementation

uses
  System.Sysutils, System.Math, System.Types;

{ TLevenshteinDistance }

class function TDamerauLevenshtein.GetDistance(const s, t: string): Integer;
  function Min(const A, B, C: Integer): Integer; overload;
  begin
    Result := A;
    if B < Result then
      Result := B;
    if C < Result then
      Result := C;
  end;

  function Min(const A, B: Integer): Integer; overloaD;
  begin
    if A < B then
      Result := A
    else
      Result := B;
  end;

var
  bounds: TPoint;
  matrix: Array of array of Integer;
  height, width: UINT32;
  cost, insertion, deletion, substitution, Distance: Integer;

begin
  bounds.Y := s.Length + 1;
  bounds.x := t.Length + 1;
  SetLength(matrix, bounds.Y, bounds.x);

  for height := 1 to bounds.Y - 1 do
    for width := 1 to bounds.x do
    begin
      if (s[height - 1] = t[width - 1]) then
        cost := 0
      else
        cost := 1;

      insertion := matrix[height, width - 1] + 1;
      deletion := matrix[height - 1, width] + 1;
      substitution := matrix[height - 1, width - 1] + cost;
      Distance := Min(insertion, deletion, substitution);

      if (height > 1) and (width > 1) and (s[height - 1] = t[width - 2]) and (s[height - 2] = t[width - 1]) then
        Distance := Min(Distance, matrix[height - 2, width - 2] + cost);

      matrix[height, width] := Distance;
    end;

  Result := matrix[bounds.Y - 1, bounds.x - 1];
end;

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
  i, j, cost, PrevCost: Integer;
  pStr1, pStr2, S1, S2: PChar;
  d: PIntegerArray;
begin
  LenStr1 := Length(Str1);
  LenStr2 := Length(Str2);

  if LenStr1 * LenStr2 = 0 then
    Exit(Max(LenStr1, LenStr1));

  pStr1 := PChar(Str1);
  pStr2 := PChar(Str2);

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
      if (I = 3) and (j = 3) then
        PrevCost := PrevCost;

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
