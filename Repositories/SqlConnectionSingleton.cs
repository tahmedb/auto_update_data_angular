using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace auto_update_data.Repositories
{
    public class SqlConnectionSingleton
    {
        public SqlConnection con;
        public SqlConnectionSingleton(IConfiguration configuration)
        {
            string connectionString = configuration.GetConnectionString("ConnectionString");
            con = new SqlConnection(connectionString);            
            con.Open();            
        }        
    }
}
