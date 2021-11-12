import { HttpClient } from '@angular/common/http';
import { ApplicationRef, Component, Inject, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import * as signalR from '@microsoft/signalr';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  public users:User[]=[];
  public refresh:boolean=true;
  constructor(private router: Router,private http: HttpClient, @Inject('BASE_URL') private baseUrl: string,private appRef: ApplicationRef) {
    this.getUsers()
  }
  
  ngOnInit() {
    let connection = new signalR.HubConnectionBuilder()
    .withUrl(this.baseUrl+'autoupdateHub')
    .withAutomaticReconnect()
    .build();
    connection.start().then(() => console.log('connection success.'));
    connection.onreconnected(()=>this.getUsers());
    connection.on('UserUpdated',()=>{
      if(this.refresh)
       { 
           this.refresh = false;
           this.getUsers();
           setTimeout(() => {
             this.refresh = true;
           }, 1000);
       }
    });
  }
  objToStr(obj){
    return JSON.stringify(obj);
  }
  deleteUser(id:number){
    this.http.delete(this.baseUrl + 'api/users/'+id).subscribe(result => {  
      alert('record deleted')    
    }, error => console.error(error));
  }
  editUser(id:number){
    this.router.navigateByUrl('/add-user?id='+id)
  }
  getUsers(){
    this.http.get<User[]>(this.baseUrl + 'api/users').subscribe(result => {
      this.users = result;
      this.appRef.tick();
    }, error => console.error(error));
  }

}

interface User {
  id:number,
  firstName:string,
  lastName:string,
  email:string,
  homeAddress:string
}