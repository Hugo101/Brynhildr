/* deal with the pagination */
function set_page_a(i,p){
  $page_as = $($pagi).find('.page-link');
  if($($page_as[i]).attr('aria-label')==undefined){
    $($page_as[i]).text(p);
  }else{
    $($page_as[i]).parent('.page-item').removeClass('disabled');
  }
  $($page_as[i]).attr('label', 'label_pageid_' + p);
  if(p==pageid){
    $($page_as[i]).parent('.page-item').addClass('active');
  }
  $($page_as[i]).off();
  $($page_as[i]).on('click', function(){
    var label = $(this).attr('label');
    pageid=parseInt(label.slice(13,label.length));
    pagination();
    load_transactions();
  });
}
function pagination(){
  $pagi = $('.pagination');
  $page_items = $($pagi).find('.page-item');
  $page_items.removeClass('active');
  $($page_items[0]).addClass('disabled');
  $($page_items[$page_items.length-1]).addClass('disabled');
  var num_xacts = transactions.length;
  var num_pages = Math.ceil(num_xacts / 10);
  var i = 0;
  if(num_pages > 5){
    if($page_items.length <7){
      for(i=0; i<(7-$page_items.length);i++){
        $($page_items[0]).after('<li class="page-item"><div class="page-link"></div></li>');
      }
    }
    if(pageid>=3){
      if(pageid<num_pages-1){
        set_page_a(0,pageid-1);
        set_page_a(6,pageid+1);
        set_page_a(1,pageid-2);
        set_page_a(2,pageid-1);
        set_page_a(3,pageid);
        set_page_a(4,pageid+1);
        set_page_a(5,pageid+2);
      }else if(pageid==num_pages-1){
        set_page_a(0,pageid-1);
        set_page_a(6,pageid+1);
        set_page_a(1,pageid-3);
        set_page_a(2,pageid-2);
        set_page_a(3,pageid-1);
        set_page_a(4,pageid);
        set_page_a(5,pageid+1);
      }else{
        set_page_a(0,pageid-1);
        set_page_a(1,pageid-4);
        set_page_a(2,pageid-3);
        set_page_a(3,pageid-2);
        set_page_a(4,pageid-1);
        set_page_a(5,pageid);
      }
    }else if(pageid==2){
      set_page_a(0,pageid-1);
      set_page_a(6,pageid+1);
      set_page_a(1,pageid-1);
      set_page_a(2,pageid);
      set_page_a(3,pageid+1);
      set_page_a(4,pageid+2);
      set_page_a(5,pageid+3);
    }else{
      set_page_a(6,pageid+1);
      set_page_a(1,pageid);
      set_page_a(2,pageid+1);
      set_page_a(3,pageid+2);
      set_page_a(4,pageid+3);
      set_page_a(5,pageid+4);
    }
  }else{
    for(i=0; i<(num_pages-$page_items.length+2);i++){
      $($page_items[0]).after('<li class="page-item"><div class="page-link"></div></li>');
  }
    for(i=0; i<num_pages;i++){
      set_page_a(i+1,i+1);
    }
    if(pageid!=1){
      set_page_a(0,pageid-1);
    }
    if(pageid!=num_pages){
      set_page_a(num_pages+1,pageid+1);
    }
  }
}
