// main javascript of Sigdrifa
var server_host = 'http://127.0.0.1:5000/api';
var restful_urls = [];
restful_urls['login'] = server_host + '/login';
restful_urls['client'] = server_host + '/client';
restful_urls['clients'] = server_host + '/clients';
restful_urls['user'] = server_host + '/user';
restful_urls['transactions'] = server_host + '/transactions';
var user = {};
var client = {};
var clients = {};
var transactions = {};
var current_price = 35;
var rate = [0.0002,0.0015];
// var url = new URL(location.href);
// var pageid = url.searchParams.get("pageid");
// if(pageid == undefined || pageid == null){
//   pageid = 1;
// }
var pageid = 1;
console.log(pageid);

// waif function
function wait(ms){
  var date = new Date(); // create new date object
  while(new Date().getTime() - date.getTime() < ms){}; // now() - begin time < wait interval
}

// transfer undefined to ''
function udef(c){
  return c==undefined?'':c;
}

// load core htmls depends on user type
function load_core_htmls(){
  switch(user['type'])
  {
  case 0:
    get_client();
    break;
  case 1:
    get_clients();
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
    // async: false,
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
    // async: false,
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

/* get clients info
 for trader user */
function get_clients(){
  $.ajax({
    url: restful_urls['clients'],
    /* safari support*/
    cache: true,
    // async: false,
    method: 'GET',
    // headers: {
    //   'Authorization': 'Iceland ' + Cookies.get('token'),
    // },
    beforeSend : function( xhr ) {
      xhr.setRequestHeader( 'Authorization', 'Iceland ' + Cookies.get('token') );
    },
  }).then(function(data){
    console.log(data);
    clients = $.parseJSON(data);
    console.log(clients);
    $(".container").load("htmls/core_trader.html",
                         function(){core_trader_onload();});
  }, function(){
    Cookies.remove("token");
    $(".container").load("htmls/login.html", function(){$('.btn').click(function(){signin();})});
  });
}

/* clear transactions */
function clear_transactions(){
  $(".table#id_transactions tbody").text('');
}
/* load transactions */
function load_transactions(){
  clear_transactions();
  for(var idx=0+(pageid-1)*10;idx<(pageid*10>transactions.length?transactions.length:pageid*10);idx++){
    var trclass = '';
    switch(transactions[idx]['t_type']){
    case 0:
      trclass = 'table-info';
      break;
    case 1:
      trclass = 'table-warning';
      break;
    case 2:
      trclass = 'table-success';
      break;
    default:
      break;
    }
    var dom_content = "<tr class='" + trclass + "'>";
    dom_content += '<th>' + transactions[idx]['t_id'] + '</th>';
    dom_content += '<td>' + transactions[idx]['t_date'] + '</td>';
    dom_content += '<td>' + transactions[idx]['amount'] + '</td>';
    dom_content += '<td>' + udef(transactions[idx]['comm_rate']) + '</td>';
    dom_content += '<td>' + udef(transactions[idx]['price']) + '</td>';
    dom_content += '<td>' + udef(transactions[idx]['comm_oil']) + '</td>';
    dom_content += '<td>' + udef(transactions[idx]['comm_cash']) + '</td>';
    dom_content += '<td>' + udef(transactions[idx]['oil_balan']) + '</td>';
    dom_content += '<td>' + transactions[idx]['cash_balan'] + '</td>';
    dom_content += '</tr>';
    $(".table#id_transactions tbody").append(dom_content);
  }
}

/* get transactions */
function get_transactions(){
  $.ajax({
    url: restful_urls['transactions'],
    /* safari */
    cache: true,
    // async: false,
    method: 'GET',
    data:{
      'uid': client['uid'],
    },
    beforeSend : function( xhr ) {
      xhr.setRequestHeader( 'Authorization', 'Iceland ' + Cookies.get('token') );
    },
  }).then(function(data){
    console.log(data);
    transactions = $.parseJSON(data);
    pagination();
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
    // async: falss,
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
    show_result(data);
  }, function(e, text){
    console.log(e.status);
    console.log(e.statusText);
    console.log(e.responseText);
    show_result($.parseJson(responseText));
    console.log(text);
  });
}

/* function for deal with result response with result modal */
function show_result(data){
  $('#result_modal').on('hide.bs.modal', function(){
    get_transactions();
    pagination();
    load_transactions();
  });
  $title = $('#result_modal').find('#result_modal_label');
  $alert = $('#result_modal').find('.alert');
  $alert.removeClass('alert-danger');
  $alert.removeClass('alert-success');
  if(data['t_id']!=undefined){
    $title.text('Success');
    $alert.addClass('alert-success');
    $alert.text('Transaction submitted successfully');
  }else{
    $title.text('Error');
    $alert.addClass('alert-danger');
    $alert.text(data);
  }
  $('#result_modal').modal('show');
  setTimeout(function(){$('#result_modal').modal('hide');}, 3000);
}

/* result modal function finished */

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
