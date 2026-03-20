using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DumbCore;

namespace DumbApplication
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
            ResultLabel.Text = "Паліндром? "+result.ToString();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var result = TextOperations.Concat(textBox1.Text, textBox2.Text);
            ResultLabel.Text = result.ToString();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var result = TextOperations.GetLength(textBox1.Text);
            ResultLabel.Text = "Довжина = "+result.ToString();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            var result = TextOperations.ToUpperCase(textBox1.Text);
            ResultLabel.Text = result.ToString();
        }
    }
}
