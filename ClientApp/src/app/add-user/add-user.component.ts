import { HttpClient } from '@angular/common/http';
import { Component, Inject, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'oidc-client';

@Component({
  selector: 'app-add-user',
  templateUrl: './add-user.component.html',
  styleUrls: ['./add-user.component.css']
})
export class AddUserComponent implements OnInit {
  public form:any ={};
  public error:string='';
  public loading:boolean=false;
  public id : any = ''; 
  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string,
    private router: Router,private route: ActivatedRoute) { }

  ngOnInit() {
    this.id =this.route.snapshot.queryParamMap.get('id');
    if(this.id)
      this.http.get<any>(this.baseUrl + 'api/users/'+this.id).subscribe(result => {
        this.form = result;
      }, error => console.error(error));
  }

  addUser(){
    this.loading = true;
    if(this.id){
      this.http.put(this.baseUrl + 'api/users/'+this.id,this.form).subscribe(result => {
        this.loading = false;
        alert('record created')
        this.router.navigate(['all-users']);  
      }, error => {
        error = 'Something went wrong.';
        this.loading = false;
      });
    }else{
      this.http.post(this.baseUrl + 'api/users',this.form).subscribe(result => {
        this.loading = false;
        alert('record created')
        this.router.navigate(['all-users']);  
      }, error => {
        error = 'Something went wrong.';
        this.loading = false;
      });
    }
  }
}
