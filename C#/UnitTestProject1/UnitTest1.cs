using Microsoft.VisualStudio.TestTools.UnitTesting;
using StringDistance;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {
        private static int Distance(string original, string modified) =>
            DamerauLevenshtein.Get(original, modified);

        [TestMethod]
        public void EqualStringsNoEdits()
        {
            Assert.AreEqual(0, Distance("test", "test"));
        }

        [TestMethod]
        public void Additions()
        {
            Assert.AreEqual(1, Distance("test", "tests"));
            Assert.AreEqual(1, Distance("test", "stest"));
            Assert.AreEqual(2, Distance("test", "mytest"));
            Assert.AreEqual(7, Distance("test", "mycrazytest"));
        }

        [TestMethod]
        public void AdditionsPrependAndAppend()
        {
            Assert.AreEqual(9, Distance("test", "mytestiscrazy"));
        }

        [TestMethod]
        public void AdditionOfRepeatedCharacters()
        {
            Assert.AreEqual(1, Distance("test", "teest"));
        }

        [TestMethod]
        public void Deletion()
        {
            Assert.AreEqual(1, Distance("test", "tst"));
        }

        [TestMethod]
        public void Transposition()
        {
            Assert.AreEqual(1, Distance("test", "tset"));
        }

        [TestMethod]
        public void AdditionWithTransposition()
        {
            Assert.AreEqual(2, Distance("test", "tsets"));
        }

        [TestMethod]
        public void TranspositionOfRepeatedCharacters()
        {
            Assert.AreEqual(1, Distance("banana", "banaan"));
            Assert.AreEqual(1, Distance("banana", "abnana"));
            Assert.AreEqual(1, Distance("banana", "baanaa"));
            Assert.AreEqual(1, Distance("nana", "anaa"));
        }

        [TestMethod]
        public void EmptyStringsNoEdits()
        {
            Assert.AreEqual(0, Distance("", ""));
        }
    }
}
