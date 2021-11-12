import { HttpClient } from '@angular/common/http';
import { Component, Inject, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-add-user',
  templateUrl: './add-user.component.html',
  styleUrls: ['./add-user.component.css']
})
export class AddUserComponent implements OnInit {
  public form:any ={};
  public error:string='';
  public loading:boolean=false;
  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string,
    private router: Router) { }

  ngOnInit() {
  }

  addUser(){
    this.loading = true;
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
