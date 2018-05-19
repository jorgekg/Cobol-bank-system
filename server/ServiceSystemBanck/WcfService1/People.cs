using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfPeople
{
    // OBSERVAÇÃO: Você pode usar o comando "Renomear" no menu "Refatorar" para alterar o nome da interface "IService1" no arquivo de código e configuração ao mesmo tempo.
    [ServiceContract]
    public interface People
    {

        [OperationContract]
        string isCpfExists(string cpf);

        [OperationContract]
        string isCpfSenhaAceitos(string xml);

        [OperationContract]
        string cadastrarCliente(string xml);
        
    }

}
