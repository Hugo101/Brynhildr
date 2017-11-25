/* core_manager.html onload function */

function core_manager_onload(){
  $(".glyphicon-log-out").parent().show();
  $('#id_dat1').datetimepicker({format:'Y-m-d H:i',});
  $('#id_dat2').datetimepicker({format:'Y-m-d H:i',});
  /* initial status of two date */
  $('#date_type_monthly').prop('checked', true);
  $('#id_dat1').val(dat[0]);
  $('#id_dat2').val(dat[1]);
  date_types_handler();
  /* register check box handler */
  $("input[name='date_types']").on('change', function(){
    date_types_handler();
  });
  $("button.btn-secondary").on('click', function(){
    dat = [$('#id_dat1').val(), $('#id_dat2').val()];
    get_agg(0);
  });
  /* load_aggregation_info */
  load_aggregation();
}

/* clear aggregation */
function clear_aggregation(){
  $(".table#id_aggregation tbody").text('');
}
/* load aggregations */
function load_aggregation(){
  clear_aggregation();
  var dom_content = "<tr class='table-warning'>";
  dom_content += '<th>' + dnull(agg[0]['buy']) + '</th>';
  dom_content += '<td>' + dnull(agg[0]['sell']) + '</td>';
  dom_content += '<td>' + dnull(agg[0]['total_oil']) + '</td>';
  dom_content += '<td>' + dnull(agg[0]['total_cash']) + '</td>';
  dom_content += '<td>' + dnull(agg[0]['total_comm_oil']) + '</td>';
  dom_content += '<td>' + dnull(agg[0]['total_comm_cash']) + '</td>';
  dom_content += '<td>' + dnull(agg[0]['total_payment']) + '</td>';
  dom_content += '</tr>';
  $(".table#id_aggregation tbody").append(dom_content);
}

function date_types_handler(){
  var date_type = $("input[name='date_types']:checked").val();
  if(date_type==0){
    $('#id_dat1').datetimepicker({
      format:'Y-m-d H:i',
      onChangeDateTime:function(dp,$input){
        $('#id_dat2').val(offsetday($input.val(), 1));
      }
    });
    $('#id_dat2').datetimepicker({
      format:'Y-m-d H:i',
      onChangeDateTime:function(dp,$input){
        $('#id_dat1').val(offsetday($input.val(), -1));
      }
    });
    $('#id_dat1').val(offsetday($('#id_dat2').val(), -1));
  }
  if(date_type==1){
    $('#id_dat1').datetimepicker({
      format:'Y-m-d H:i',
      onChangeDateTime:function(dp,$input){
        $('#id_dat2').val(offsetweek($input.val(), 1));
      }
    });
    $('#id_dat2').datetimepicker({
      format:'Y-m-d H:i',
      onChangeDateTime:function(dp,$input){
        $('#id_dat1').val(offsetweek($input.val(), -1));
      }
    });
    $('#id_dat1').val(offsetweek($('#id_dat2').val(), -1));
  }
  if(date_type==2){
    $('#id_dat1').datetimepicker({
      format:'Y-m-d H:i',
      onChangeDateTime:function(dp,$input){
        $('#id_dat2').val(offsetmonth($input.val(), 1));
      }
    });
    $('#id_dat2').datetimepicker({
      format:'Y-m-d H:i',
      onChangeDateTime:function(dp,$input){
        $('#id_dat1').val(offsetmonth($input.val(), -1));
      }
    });
    $('#id_dat1').val(offsetmonth($('#id_dat2').val(), -1));
  }
}

function offsetday(dat1, type){
  var now = new Date(dat1);
  now.setDate(now.getDate() + type);
  var d = now.getDate();
  var y = now.getFullYear();
  var m = now.getMonth() + 1;
  var H = now.getHours();
  if(H<10){H = '0'+H}
  var M = now.getMinutes();
  if(M<10){M = '0'+M}
  return y + '-' + m + '-' + d + ' ' + H + ':' + M;
}


function offsetweek(dat1, type){
  var now = new Date(dat1);
  now.setDate(now.getDate() + type * 7);
  var d = now.getDate();
  var y = now.getFullYear();
  var m = now.getMonth() + 1;
  var H = now.getHours();
  if(H<10){H = '0'+H}
  var M = now.getMinutes();
  if(M<10){M = '0'+M}
  return y + '-' + m + '-' + d + ' ' + H + ':' + M;
}

function offsetmonth(dat1, type){
  var now = new Date(dat1);
  var d = now.getDate();
  var y = now.getFullYear();
  var m = now.getMonth() + 1 + type;
  y += (Math.ceil(m/12)-1);
  m = m%12;
  if(m==0){m=12;}
  var H = now.getHours();
  if(H<10){H = '0'+H;}
  var M = now.getMinutes();
  if(M<10){M = '0'+M;}
  return y + '-' + m + '-' + d + ' ' + H + ':' + M;
}
