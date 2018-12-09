unit LevenshteinTest;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TDamerauLevenshteinTest = class(TObject)
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure EqualStringsNoEdits;
  end;

implementation

procedure TDamerauLevenshteinTest.EqualStringsNoEdits;
begin
  Assert.AreEqual (0, EditDistance ("test", "test"));
end;

procedure TDamerauLevenshteinTest.Setup;
begin
end;

procedure TDamerauLevenshteinTest.TearDown;
begin
end;


initialization

TDUnitX.RegisterTestFixture(TDamerauLevenshteinTest);

end.
