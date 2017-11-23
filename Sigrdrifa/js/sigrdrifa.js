// main javascript of Sigdrifa
var server_host = 'http://127.0.0.1:5000/api';
var restful_urls = [];
restful_urls['login'] = server_host + '/login';
restful_urls['client'] = server_host + '/client';
restful_urls['user'] = server_host + '/user';
restful_urls['transactions'] = server_host + '/transactions';
var user = {};
var client = {};
var transactions = {};
var current_price = 35;
var rate = [0.002,0.015];

// waif function
function wait(ms){
  var date = new Date(); // create new date object
  while(new Date().getTime() - date.getTime() < ms){}; // now() - begin time < wait interval
}


// load core htmls depends on user type
function load_core_htmls(){
  switch(user['type'])
  {
    case 0:
    get_client();
    break;
    case 1:
    break;
    case 2:
    break;
    default:
    break;
  }
}

// check if current user has already signed in
function is_login(){
  $.ajax({
    url: restful_urls['user'],
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
      user[cld] = data[0][cld];
    }
    load_core_htmls();
  }, function(){
    Cookies.remove("token");
    $(".container").load("htmls/login.html", function(){$('.btn').click(function(){signin();})});
  });
}

/* get client info */
function get_client(){
  $.ajax({
    url: restful_urls['client'],
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
    $(".container").load("htmls/core_client.html",
                         function(){core_client_onload();});
  }, function(){
    Cookies.remove("token");
    $(".container").load("htmls/login.html", function(){$('.btn').click(function(){signin();})});
  });
}

/* load transactions */
function load_transactions(){
  console.log(transactions);
  for(var idx in transactions){
    var dom_content = "<tr>";
    dom_content += '<th>' + transactions[idx]['t_id'] + '</th>';
    dom_content += '<td>' + transactions[idx]['t_date'] + '</td>';
    dom_content += '<td>' + transactions[idx]['amount'] + '</td>';
    dom_content += '<td>' + transactions[idx]['comm_rate'] + '</td>';
    dom_content += '<td>' + transactions[idx]['price'] + '</td>';
    dom_content += '<td>' + transactions[idx]['comm_oil'] + '</td>';
    dom_content += '<td>' + transactions[idx]['comm_cash'] + '</td>';
    dom_content += '<td>' + transactions[idx]['oil_balan'] + '</td>';
    dom_content += '<td>' + transactions[idx]['cash_balan'] + '</td>';
    dom_content += '</tr>'
    $(".table#id_transactions tbody").append(dom_content);
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

/* new transaction */
function new_transaction(t_data){
  $.ajax({
    url: restful_urls['transactions'],
    /* safari support*/
    cache: true,
    async: false,
    method: 'PUT',
    // headers: {
    //   'Authorization': 'Iceland ' + Cookies.get('token'),
    // },
    data: {
      't_type': t_data['t_type'],
      'comm_type': t_data['comm_type'],
      'amount': t_data['amount'],
      'c_id': t_data['c_id'],
    },
    beforeSend : function( xhr ) {
      xhr.setRequestHeader( 'Authorization', 'Iceland ' + Cookies.get('token') );
    },
  }).then(function(data){
    console.log(data);
    var data = $.parseJSON(data);
    console.log(data);
  }, function(e){
    console.log(e);
  });
}


$(document).ready(function(){
  $(".glyphicon-log-out").parent().click(function(){
    logout();
  });
  if(Cookies.get('token')!==null && Cookies.get('token')!==undefined){
    is_login();
  }else{
    $(".container").load("htmls/login.html", function(){$('.btn').click(function(event){event.preventDefault();signin();})});
  }
});
