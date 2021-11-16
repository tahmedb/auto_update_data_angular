using auto_update_data.database;
using auto_update_data.Hubs;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace auto_update_data.Repositories
{
    public class UserRepository
    {
        string connectionString;
        IHubContext<AutoUpdateHub> _hubContext;
        public UserRepository(IConfiguration configuration, IHubContext<AutoUpdateHub> hubContext)
        {
            connectionString = configuration.GetConnectionString("ConnectionString");
            _hubContext = hubContext;
        }

        public List<Users> GetAllUsers()
        {
            List<Users> users = new List<Users>();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlDependency.Start(connectionString);
                SqlCommand selectCommand = new SqlCommand("select id,first_name,last_name,email,home_address from dbo.users order by id desc", con);
                SqlDependency sqlDependency = new SqlDependency(selectCommand);                
                sqlDependency.OnChange += new OnChangeEventHandler(SqlDependency_OnChange);
                var reader = selectCommand.ExecuteReader();
                while (reader.Read())
                {
                    users.Add(new Users
                    {
                        Id = Convert.ToInt32( reader["id"]),
                        Email = reader["email"].ToString(),
                        FirstName = reader["first_name"].ToString(),
                        LastName = reader["last_name"].ToString(),
                        HomeAddress = reader["home_address"].ToString()
                    });
                }
            }

            return users;
        }

        private void SqlDependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            if(e.Info != SqlNotificationInfo.Invalid)
                _hubContext.Clients.All.SendAsync("UserUpdated");
        }
    }
}
