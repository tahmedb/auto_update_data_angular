import { HttpClient } from '@angular/common/http';
import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-add-user',
  templateUrl: './add-user.component.html',
  styleUrls: ['./add-user.component.css']
})
export class AddUserComponent implements OnInit {
  public form:any ={};
  public error:string='';
  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string,private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router) { }

  ngOnInit() {
  }

  addUser(e){
    e.preventDefault();
    this.http.post(this.baseUrl + 'addusers',this.form).subscribe(result => {
      this.router.navigate(['all-users'], { relativeTo: this.route });  
    }, error => error = 'Something went wrong.');
  }
}
