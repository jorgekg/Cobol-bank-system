using System;
using System.Diagnostics;
using System.IO;
using System.Xml;
using System.Xml.Serialization;
using WcfService1.app;

namespace WcfPeople
{
    public class PeopleGet : People
    {
        public string cadastrarCliente(string xml)
        {
            try
            {
                XmlSerializer serializer = new XmlSerializer(typeof(PeopleModel));

                var people = new PeopleModel();
                using (TextReader reader = new StringReader(xml))
                {
                    people = (PeopleModel)serializer.Deserialize(reader);
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\input\operation.data"))
                {
                    file.Write(Parametros.API_SERVICO_CLIENTE_CADASTRO);
                    file.Flush();
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\input\people.data"))
                {
                    file.Write(people.ToString());
                    file.Flush();
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\output\people.data"))
                {
                    file.Write("");
                    file.Flush();
                }

                var start = Process.Start(@"C:\cobol\bin\SystemBank.bat");
                start.WaitForExit();

                var ret = "";
                using (var file =
                new StreamReader(@"C:\cobol\bin\output\people.data"))
                {
                    ret = file.ReadLine();
                }

                return ret.Equals("1") ? "S" : "N";
            }
            catch (Exception e)
            {
                return "N";
            }
        }

        public string getNomeCliente(string cpf)
        {
            try
            {
                using (var file =
                new StreamWriter(@"C:\cobol\bin\input\operation.data"))
                {
                    file.Write(Parametros.API_SERVICO_NOME_CLIENTE);
                    file.Flush();
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\input\name.data"))
                {
                    file.Write(cpf);
                    file.Flush();
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\output\name.data"))
                {
                    file.Write("");
                    file.Flush();
                }

                var start = Process.Start(@"C:\cobol\bin\SystemBank.bat");
                start.WaitForExit();

                var ret = "";

                using (var file =
                new StreamReader(@"C:\cobol\bin\output\name.data"))
                {
                    ret = file.ReadLine();
                }

                return ret;
            }
            catch (Exception e)
            {
                return "";
            }
        }

        public string isCpfExists(string value)
        {
            try
            {
                using (var file =
                new StreamWriter(@"C:\cobol\bin\input\operation.data"))
                {
                    file.Write(Parametros.API_SERVICO_USUARIO_VALIDACAO);
                    file.Flush();
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\input\cpfexists.data"))
                {
                    file.Write(value);
                    file.Flush();
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\output\cpfexists.data"))
                {
                    file.Write("");
                    file.Flush();
                }
                var start = Process.Start(@"C:\cobol\bin\SystemBank.bat");
                start.WaitForExit();

                var ret = "";

                using (var file =
                new StreamReader(@"C:\cobol\bin\output\cpfexists.data"))
                {
                    ret = file.ReadLine();
                }

                return ret.Equals("1") ? "S" : "N";
            }catch(Exception e)
            {
                return "N";
            }
        }

        public string isCpfSenhaAceitos(string xml)
        {

            if (string.IsNullOrEmpty(xml))
            {
                return "N";
            }

            try
            {
                XmlSerializer serializer = new XmlSerializer(typeof(PeopleModel));

                var people = new PeopleModel();
                using (TextReader reader = new StringReader(xml))
                {
                    people = (PeopleModel)serializer.Deserialize(reader);
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\input\operation.data"))
                {
                    file.Write(Parametros.API_SERVICO_USUARIO_VALIDACAO);
                    file.Flush();
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\input\cpfexists.data"))
                {
                    file.Write(people.cpf);
                    file.Flush();
                }

                using (var file =
                new StreamWriter(@"C:\cobol\bin\output\cpfexists.data"))
                {
                    file.Write("");
                    file.Flush();
                }
                var start = Process.Start(@"C:\cobol\bin\SystemBank.bat");
                start.WaitForExit();

                var ret = "";

                using (var file =
                new StreamReader(@"C:\cobol\bin\output\cpfexists.data"))
                {
                    ret = file.ReadLine();
                }

                return ret.Equals("1") ? "S" : "N";
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        
    }

    [Serializable()]
    public class PeopleModel
    {
        [XmlElement("cpf")]
        public string cpf { get; set; }

        [XmlElement("senha")]
        public string senha { get; set; }

        [XmlElement("nome")]
        public string nome { get; set; }

        [XmlElement("telefone")]
        public string telefone { get; set; }

        public override string ToString()
        {
            return validarStr(nome, 255)+validarStr(cpf,11)+validarStr(telefone,10)+validarStr(senha,8);
        }

        private string validarStr(string str, int qtdEmbranco)
        {
            var branco = qtdEmbranco - str.Length;
            return str + new string(' ', branco);
        }
    }
}
