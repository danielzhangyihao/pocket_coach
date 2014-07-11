$(document).ready(function(){

  $("#instructor_companyadmin_true").click(function(){
  
     $("#create-company").toggle(true);
     $("#add-company").toggle(false);

 
});
  $("#instructor_companyadmin_false").click(function(){
  
     $("#create-company").toggle(false);
     $("#add-company").toggle(true);
 
});
   
   
});