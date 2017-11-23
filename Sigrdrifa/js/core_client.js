/* core_client.html onload function */

function core_client_onload(){
  $('div.modal#new_transaction_modal').find('.btn-primary').prop('disabled', true);
  $('div.modal#new_transaction_modal').find('.btn-primary').attr('disabled', true);
  $('div.modal#new_transaction_modal').find('.btn-primary').on('click', function(){submit_new_transaction_modal();});
  $(".glyphicon-log-out").parent().show();
  $("#id_welcome").text('Welcome ' + client.first_name + ' ' + client.last_name);
  $("#h6_first_name").text(client.first_name);
  for(var attr in client){
    var dom_content = "<a href='#' class='list-group-item list-group-item-light flex-column align-items'><div class='d-flex w-100 justify-content-between'><h6 class='mb-1'>" + attr.toUpperCase() + ":</h6><h6 class='mb-1' id='h6_" + attr + "'>" + client[attr] + "</h6></div></a>";
    $(".list-group#id_clientinfo").append(dom_content);
  }
  $("input#transaction_amount").on('input', function(){
    show_transaction_cash();
  });
  $("input[name='transaction_type_options']").on('change', function(){
    new_transaction_handler();
  });
  $("input[name='commission_options']").on('change', function(){
    new_transaction_handler();
  });
  $('div.modal#new_transaction_modal').find('.btn-secondary').on('click', function(){reset_new_transaction_modal();});
  get_transactions();
}

function show_transaction_cash(){
  var amount = $("input#transaction_amount").val();
  if(amount != ""){
    $("input#transaction_amount").next('label').text('≈ ' + amount * current_price);
  }
  new_transaction_handler();
}


/* show estimated cost in new transaction modal */
function show_est_cost(c_cost, c_type, t_cost, t_type){
  $alert=$("input#transaction_amount").parent('.form-group').siblings('div.alert');
  total_cost_0 = c_type==0?c_cost:0 + t_type==0?t_cost:0; //total oil cost
  total_cost_1 = c_type==1?c_cost:1 + t_type==1?t_cost:1; //total cash cost
  $alert.removeClass('alert-danger');
  $alert.removeClass('alert-info');
  if(total_cost_0 > client['oil_balan']){
    /* if not enough oil, make submit invalid */
    $('div.modal#new_transaction_modal').find('.btn-primary').prop('disabled', true);
    $('div.modal#new_transaction_modal').find('.btn-primary').attr('disabled', true);
    $alert.addClass('alert-danger');
    $($alert[0]).text("Estimated commission cost: " + c_cost + (c_type == 0 ? " barrels" : " USD"));
    $($alert[1]).text("Estimated base cost: " + t_cost + (t_type == 0 ? " barrels" : " USD"));
    $($alert[2]).text("Estimated total cost: " + total_cost_0 +  " barrels and " + total_cost_1 + " USD" + ' (No enough oil balance, current oil balance: '+ client['oil_balan'] + ')');
  }else{
    $('div.modal#new_transaction_modal').find('.btn-primary').prop('disabled', false);
    $('div.modal#new_transaction_modal').find('.btn-primary').attr('disabled', false);
    $alert.addClass('alert-info');
    $($alert[0]).text("Estimated commission cost: " + c_cost + (c_type == 0 ? " barrels" : " USD"));
    $($alert[1]).text("Estimated base cost: " + t_cost + (t_type == 0 ? " barrels" : " USD"));
    $($alert[2]).text("Estimated total cost: " + total_cost_0 +  " barrels and " + total_cost_1 + " USD");
  }
}

/* handle any change in new_transaction modal */
function new_transaction_handler(){
  var transaction_type = $("input[name='transaction_type_options']:checked").val();
  var commission_type = $("input[name='commission_options']:checked").val();
  var amount = $("input#transaction_amount").val();
  if(amount != "" && transaction_type != undefined && commission_type != undefined ){
    if(commission_type == '0'){
      est_comm_cost = amount * rate[client['level']];
      if(transaction_type == '0'){
        cash_cost = amount * current_price;
        show_est_cost(est_comm_cost, 0, cash_cost, 1);
      }else{
        oil_cost = amount;
        show_est_cost(est_comm_cost, 0, oil_cost, 0);
      }
    }else{
      est_comm_cost = amount * rate[client['level']] * current_price;
      if(transaction_type == '0'){
        cash_cost = amount * current_price;
        show_est_cost(est_comm_cost, 1, cash_cost, 1);
      }else{
        oil_cost = amount;
        show_est_cost(est_comm_cost, 1, oil_cost, 0);
      }
    }
  }
}

/* close modal */
function reset_new_transaction_modal(){
  $('div.modal#new_transaction_modal').find('.btn-primary').prop('disabled', true);
  $('div.modal#new_transaction_modal').find('.btn-primary').attr('disabled', true);
  $("input[name='transaction_type_options']:checked").prop('checked', false);
  $("input[name='commission_options']:checked").prop('checked', false);
  $("input#transaction_amount").val("");
  $("input#transaction_amount").next('label').text("");
  $alert=$("input#transaction_amount").parent('.form-group').siblings('div.alert');
  $alert.removeClass('alert-info');
  $alert.removeClass('alert-danger');
  $($alert[0]).text("");
  $($alert[1]).text("");
  $($alert[2]).text("");
}

/* submit transaction */
function submit_new_transaction_modal(){
  var t_data = {}
  t_data['t_type'] = $("input[name='transaction_type_options']:checked").val();
  t_data['comm_type'] = $("input[name='commission_options']:checked").val();
  t_data['amount'] = $("input#transaction_amount").val();
  t_data['c_id'] = client['uid'];
  new_transaction(t_data);
  reset_new_transaction_modal();
}
