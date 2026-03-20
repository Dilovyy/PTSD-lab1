using DumbCore;

    [TestClass]
    public class UnitTests
    {
        [TestMethod]
        public void Palindrome_True()
        {
            Assert.IsTrue(TextOperations.IsPalindrome("level"));
        }

        [TestMethod]
        public void Palindrome_False()
        {
            Assert.IsFalse(TextOperations.IsPalindrome("hello"));
        }

        [TestMethod]
        public void Concat_Test()
        {
            Assert.AreEqual("HelloWorld", TextOperations.Concat("Hello", "World"));
        }

        [TestMethod]
        public void Length_Test()
        {
            Assert.AreEqual(5, TextOperations.GetLength("Hello"));
        }

        [TestMethod]
        public void Upper_Test()
        {
            Assert.AreEqual("HELLO", TextOperations.ToUpperCase("hello"));
        }

       [TestMethod]
       public void Test()
       {
        var result = TextOperations.Concat("A", "B");
        Assert.AreEqual("AB", result);
       }
}
