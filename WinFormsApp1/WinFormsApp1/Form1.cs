using ClassLibrary1;

namespace WinFormsApp1
{

    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var result = TextOperations.IsPalindrome(textBox1.Text);
            label1.Text = "Паліндром? " + result.ToString();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var result = TextOperations.Concat(textBox1.Text, textBox2.Text);
            label1.Text = result.ToString();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var result = TextOperations.GetLength(textBox1.Text);
            label1.Text = "Довжина = " + result.ToString();
        }


        private void button4_Click_1(object sender, EventArgs e)
        {
            var result = TextOperations.ToUpperCase(textBox1.Text);
            label1.Text = result.ToString();
        }
    }
}
