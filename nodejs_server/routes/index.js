var express = require('express');
var router = express.Router();
var path = require('path');
var mysql = require('mysql');


//mysql  connection
var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "raspi",
 database: "steam"

});

//login function 
router.post('/login', function(req, res, next) {
  console.log(req.body)
  if(req.body.email&&req.body.pass){
    var email = req.body.email
    var pass = req.body.pass
      var sql = "SELECT * FROM users WHERE email = ?";
      con.query(sql,email, function(err, result, fields) {
        if (err) throw err;
         if(result.length ){
          if(pass == result[0].pass){
             return res.send("loged" )
         }else
         {
          return res.send("email_dons't_exist")
         }
        }else{
          return res.send("wrong_email_or_password")
        }
       })     
  }
  else{
    return res.send("missing email or password")
  }
});

//sginup function 
router.post('/register', function(req, res, next) {
  if(req.body.email&&req.body.pass){
    var email = req.body.email
    var pass = req.body.pass  
      var sql = "SELECT * FROM users WHERE email = ?";
      con.query(sql,email, function(err, result, fields) {
        if (err) throw err;
         if(result.length ==!"0" ){
          var sql = "INSERT INTO `users` (`email`, `pass`) VALUES ('"+email+"','"+ pass+"')";
              con.query(sql, function (err, result) {
                if (err) throw err;
               return res.send("email_sign_up_sucsess")
              });
         }else{
          return res.send("email_exist")
            }
       })     
        }else
      {
         return res.send("missing_data")
     }
   });
    
// send user data function
   router.post('/get_data', function(req, res, next) {
     var id =req.body.id
    if(id){
        var sql = "SELECT * FROM users_";
        con.query(sql,id, function(err, result, fields) {
          if (err) throw err;
          console.log(result)
          return res.send(result)
         })     
        } else{
           return res.send("missing_data")
       }
     });
  
  
module.exports = router;
