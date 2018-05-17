using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using WcfService1.app;

namespace WcfService1
{
    // OBSERVAÇÃO: Você pode usar o comando "Renomear" no menu "Refatorar" para alterar o nome da classe "Service1" no arquivo de código, svc e configuração ao mesmo tempo.
    // OBSERVAÇÃO: Para iniciar o cliente de teste do WCF para testar esse serviço, selecione Service1.svc ou Service1.svc.cs no Gerenciador de Soluções e inicie a depuração.
    public class PeopleGet : People
    {
        public string isCpfExists(string value)
        {
            using (var file =
            new StreamWriter(@"C:\Users\jorge\Documents\cobol\cobol\bin\input\operation.data"))
            {
                file.WriteLine(Parametros.API_SERVICO_USUARIO_VALIDACAO);
                file.Flush();
            }

            using (var file =
            new StreamWriter(@"C:\Users\jorge\Documents\cobol\cobol\bin\input\cpfexists.data"))
            {
                file.WriteLine(value);
                file.Flush();
            }

            using (var file =
            new StreamWriter(@"C:\Users\jorge\Documents\cobol\cobol\bin\output\cpfexists.data"))
            {
                file.WriteLine("");
                file.Flush();
            }

            Process myProcess = Process.Start(@"main.exe");
            myProcess.WaitForExit();

            var ret = "";
            using (var file =
            new StreamReader(@"C:\Users\jorge\Documents\cobol\cobol\bin\output\cpfexists.data"))
            {
                ret = file.ReadLine();
            }

            return ret.Equals("1") ? "S" : "N";
        }
    }
}
