unit LevenshteinTest;

interface

uses
  DUnitX.TestFramework, DUnitX.Assert.Ex;

type

  [TestFixture]
  TDamerauLevenshteinTest = class(TObject)
  private
    function Distance(const Str1, Str2: string): Integer;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure EqualStringsNoEdits;
    [Test]
    procedure Additions;
    [Test]
    procedure AdditionsPrependAndAppend;
    [Test]
    procedure AdditionOfRepeatedCharacters;
    [Test]
    procedure Deletion;
    [Test]
    procedure Transposition;
    [Test]
    procedure AdditionWithTransposition;
    [Test]
    procedure TranspositionOfRepeatedCharacters;
    [Test]
    procedure EmptyStringsNoEdits;
  end;

implementation

uses
  FindNearestStringU;

procedure TDamerauLevenshteinTest.AdditionOfRepeatedCharacters;
begin
  Assert.AreEqual(1, Distance('test', 'teest'));
end;

procedure TDamerauLevenshteinTest.Additions;
begin
  Assert.AreEqual(1, Distance('test', 'tests'));
  Assert.AreEqual(1, Distance('test', 'stest'));
  Assert.AreEqual(2, Distance('test', 'mytest'));
  Assert.AreEqual(7, Distance('test', 'mycrazytest'));
end;

procedure TDamerauLevenshteinTest.AdditionsPrependAndAppend;
begin
  Assert.AreEqual(9, Distance('test', 'mytestiscrazy'));
end;

procedure TDamerauLevenshteinTest.AdditionWithTransposition;
begin
  Assert.AreEqual(2, Distance('test', 'tsets'));
end;

procedure TDamerauLevenshteinTest.Deletion;
begin
  Assert.AreEqual(1, Distance('test', 'tst'));
end;

function TDamerauLevenshteinTest.Distance(const Str1, Str2: string): Integer;
begin
  Result := TDamerauLevenshtein.Distance(Str1, Str2);
end;

procedure TDamerauLevenshteinTest.EmptyStringsNoEdits;
begin
  Assert.AreEqual(0, Distance('', ''));
end;

procedure TDamerauLevenshteinTest.EqualStringsNoEdits;
begin
  Assert.AreEqual(0, Distance('Test', 'Test'));
end;

procedure TDamerauLevenshteinTest.Setup;
begin
end;

procedure TDamerauLevenshteinTest.TearDown;
begin
end;

procedure TDamerauLevenshteinTest.Transposition;
begin
  Assert.AreEqual(1, Distance('test', 'tset'));
end;

procedure TDamerauLevenshteinTest.TranspositionOfRepeatedCharacters;
begin
  Assert.AreEqual(1, Distance('banana', 'banaan'));
  Assert.AreEqual(1, Distance('banana', 'abnana'));
  Assert.AreEqual(1, Distance('banana', 'baanaa'));
  Assert.AreEqual(1, Distance('nana', 'anaa'));
end;

initialization

TDUnitX.RegisterTestFixture(TDamerauLevenshteinTest);

end.
