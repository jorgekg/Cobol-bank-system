using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WcfService1;
using WcfPeople;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            People p = new PeopleGet();
            var ret = p.isCpfExists("08766825903");
        }

        [TestMethod]
        public void TesteXmlLoad()
        {
            People p = new PeopleGet();
            string xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            xml += "<PeopleModel><cpf>08766825903</cpf>" +
                "<senha>123</senha></PeopleModel>";
            p.isCpfSenhaAceitos(xml);
        }

        [TestMethod]
        public void cadastro()
        {
            People p = new PeopleGet();
            string xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            xml += "<PeopleModel><cpf>08766825903</cpf>" +
                "<senha>123</senha>" +
                "<telefone>33325019</telefone>" +
                "<nome>Jorge</nome></PeopleModel>";
            p.cadastrarCliente(xml);
        }

        [TestMethod]
        public void Nome()
        {
            People p = new PeopleGet();
            p.getNomeCliente("08766825903");
        }
    }
}
