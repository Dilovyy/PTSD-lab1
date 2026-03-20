namespace ClassLibrary
{
    public static class TextOperations
    {
        public static bool IsPalindrome(string text)
        {
            string reversed = new string(text.Reverse().ToArray());
            return text.Equals(reversed, StringComparison.OrdinalIgnoreCase);
        }

        public static string Concat(string a, string b)
        {
            return a + b;
        }

        public static int GetLength(string text)
        {
            return text.Length;
        }

        public static string ToUpperCase(string text)
        {
            return text.ToUpper();
        }
    }
}
