using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WcfService1;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            People p = new PeopleGet();
            p.isCpfExists("08766825903");
        }
    }
}
