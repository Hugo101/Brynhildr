/* core_manager.html onload function */

function core_manager_onload(){
  $(".glyphicon-log-out").parent().show();
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
  dom_content += '<th>' + agg[0]['buy'] + '</th>';
  dom_content += '<td>' + agg[0]['sell'] + '</td>';
  dom_content += '<td>' + agg[0]['total_oil'] + '</td>';
  dom_content += '<td>' + agg[0]['total_cash'] + '</td>';
  dom_content += '<td>' + agg[0]['total_comm_oil'] + '</td>';
  dom_content += '<td>' + agg[0]['total_comm_cash'] + '</td>';
  dom_content += '<td>' + agg[0]['total_payment'] + '</td>';
  dom_content += '</tr>';
  $(".table#id_aggregation tbody").append(dom_content);
}
