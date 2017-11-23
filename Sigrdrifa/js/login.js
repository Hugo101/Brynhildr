// show login failed feedback
function login_failed_feedback(s){
  $alert = $('input.form-control#id_password').next('.alert');
  $alert.addClass('alert-danger');
  $alert.text(s);
}


// show login success feedback
function login_success_feedback(s){
  $alert = $('input.form-control#id_password').next('.alert');
  $alert.addClass('alert-success');
  $alert.text(s);
}


// logout function
// empty cookie
function logout(){
  console.log("logout");
  Cookies.remove("token");
  location.reload();
}


/* signin function */
function signin(){
  console.log('signin');
  $.ajax({
    url: restful_urls['login'],
    /* safari */
    cache: true,
    //async: false,
    method: 'POST',
    data: {
      'email': $("#id_email").val(),
      'password': md5($("#id_password").val()),
    },
  }).then(function(data){
    console.log(data);
    var data = $.parseJSON(data);
    if(data.status == 535){
      login_failed_feedback(data.message);
      setTimeout(function(){location.reload()}, 1500);
      return;
    }
    if(data.status == 409){
      login_failed_feedback(data.message);
      setTimeout(function(){location.reload()}, 1500);
      return;
    }
    login_success_feedback('successfully signin');
    Cookies.set("uid", data.uid);
    user['uid'] = data.uid;
    user['type'] = data.type;
    Cookies.set("token", data.token);
    console.log(Cookies.get("uid"));
    setTimeout(function(){location.reload()}, 500);
      }, function(){
    alert('Service not available');
  });
}
