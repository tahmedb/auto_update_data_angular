using auto_update_data.database;
using auto_update_data.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace auto_update_data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : Controller
    {
        // GET: UserController
        Auto_UpdatedbContext _auto_UpdatedbContext;
        UserRepository _userRepository;
        public UsersController(Auto_UpdatedbContext auto_UpdatedbContext, UserRepository userRepository)
        {
            _auto_UpdatedbContext = auto_UpdatedbContext;
            _userRepository = userRepository;
        }

        [HttpGet]
        public List<Users> Index()
        {
            var data = _userRepository.GetAllUsers();
            return data;
        }
        [HttpGet("{id}")]
        public Users Get(int id)
        {
            var user = _auto_UpdatedbContext.Users.Find(id);
            return user;
        }

        [HttpPost]
        public Users Create(Users user)
        {
            _auto_UpdatedbContext.Users.Add(user);
            _auto_UpdatedbContext.SaveChanges();
            return (user);            
        }


        [HttpPut("{id}")]
        public Users Edit(int id,Users user)
        {
            var updateUser = _auto_UpdatedbContext.Users.Find(id);
            updateUser.FirstName = user.FirstName;
            updateUser.LastName = user.LastName;
            updateUser.Email = user.Email;
            updateUser.HomeAddress = user.HomeAddress;
            _auto_UpdatedbContext.Users.Update(updateUser);
            _auto_UpdatedbContext.SaveChanges();
            return user;
        }

        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var user = _auto_UpdatedbContext.Users.Find(id);
            _auto_UpdatedbContext.Users.Remove(user);
            _auto_UpdatedbContext.SaveChanges();
            return Ok();
        }
    }
}
