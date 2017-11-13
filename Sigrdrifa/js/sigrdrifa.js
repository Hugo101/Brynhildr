// main javascript of Sigdrifa
var server_host = 'http://127.0.0.1:5000/api';
var restful_urls = [];
restful_urls['login'] = server_host + '/login';
restful_urls['clients'] = server_host + '/clients';
restful_urls['transactions'] = server_host + '/transactions';
var client = {};
var transactions = {};

// logout function
// empty cookie
function logout(){
  console.log("logout");
  Cookies.remove("token");
  location.reload();
}

function is_login(){
  $.ajax({
    url: restful_urls['clients'],
    /* safari support*/
    cache: true,
    async: false,
    method: 'GET',
    // headers: {
    //   'Authorization': 'Iceland ' + Cookies.get('token'),
    // },
    beforeSend : function( xhr ) {
      xhr.setRequestHeader( 'Authorization', 'Iceland ' + Cookies.get('token') );
    },
  }).then(function(data){
    console.log(data);
    var data = $.parseJSON(data);
    console.log(data);
    for(var cld in data[0]){
      client[cld] = data[0][cld];
    }
    $(".container").load("htmls/core.html",
                         function(){core_onload();});
  }, function(){
    Cookies.remove("token");
    $(".container").load("htmls/login.html", function(){$('.btn').click(function(){signin();})});
  });
}

/* load transactions */
function load_transactions(){
  console.log(transactions);
  for(var idx in transactions){
    var dom_content = "<a href='#' class='list-group-item list-group-item-light flex-column align-items'><div class='d-flex w-100 justify-content-between'><h6 class='mb-1'>" + JSON.stringify(transactions[idx]) + "</h6></div></a>";
    $(".list-group#id_transactions").append(dom_content);
  }
}

/* get transactions */
function get_transactions(){
  $.ajax({
    url: restful_urls['transactions'],
    /* safari */
    cache: true,
    //async: false,
    method: 'GET',
    beforeSend : function( xhr ) {
      xhr.setRequestHeader( 'Authorization', 'Iceland ' + Cookies.get('token') );
    },
  }).then(function(data){
    console.log(data);
    transactions = $.parseJSON(data);
    load_transactions();
  }, function(){
    alert('Service not available');
  });
}

function signin(){
  console.log('click');
  $.ajax({
    url: restful_urls['login'],
    /* safari */
    cache: true,
    //async: false,
    method: 'POST',
    data: {
      'email': $("#id_email").val(),
      'password': $("#id_password").val(),
    },
  }).then(function(data){
    console.log(data);
    var data = $.parseJSON(data);
    Cookies.set("c_id", data.c_id);
    Cookies.set("token", data.token);
    console.log(Cookies.get("c_id"));
    location.reload();
  }, function(){
    alert('Service not available');
  });
}

function core_onload(){
  $(".glyphicon-log-out").parent().show();
  $("#id_welcome").text('Welcome ' + client.first_name + ' ' + client.last_name);
  $("#h6_first_name").text(client.first_name);
  for(var attr in client){
    var dom_content = "<a href='#' class='list-group-item list-group-item-light flex-column align-items'><div class='d-flex w-100 justify-content-between'><h6 class='mb-1'>" + attr.toUpperCase() + ":</h6><h6 class='mb-1' id='h6_" + attr + "'>" + client[attr] + "</h6></div></a>";
    $(".list-group#id_clientinfo").append(dom_content);
  }
  get_transactions();
}

$(document).ready(function(){
  $(".glyphicon-log-out").parent().click(function(){
    logout();
  });
  if(Cookies.get('token')!==null && Cookies.get('token')!==undefined){
    is_login();
  }else{
    $(".container").load("htmls/login.html", function(){$('.btn').click(function(){signin();})});
  }
});
