using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;

namespace auto_update_data.Hubs
{
    public class AutoUpdateHub : Hub
    {
        public async Task SendMessage(string user, string message)
        {
            await Clients.All.SendAsync("ReceiveMessage", user, message);
        }
    }
}