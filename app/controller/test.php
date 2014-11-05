<?php
	$e_Title="test";	
	require_once '../config.php';
	require_once '../view/basic_header.tpl';
	require_once '../model/DBAccess.class.php';
	require_once '../model/User.class.php';
	require_once '../model/Region.class.php';
	require_once '../model/UserPred.class.php';

?>


<h1>
	
	<div class="fluent-menu">
    <ul class="tabs-holder">
        <li><a href="#content_id_1">Tab Name 1</a></li>
        ...
        <li><a href="#content_id_n">Tab Name N</a></li>
    </ul>
 
    <div class="tabs-content">
        <div class="tab-panel" id="content_id_1">
            <div class="tab-panel-group">
                <div class="tab-group-content">set of menu elements</div>
                <div class="tab-group-caption">group name</div>
            </div>
        </div>
        ...
        <div class="tab-panel" id="content_id_n">
            <div class="tab-panel-group">
                <div class="tab-group-content">set of menu elements</div>
                <div class="tab-group-caption">group name</div>
            </div>
        </div>
    </div>
</div>
	
	
	<? 
		/*
		 * Just adding this variable to suggest that "content" described
		 * by this variable needs to be implemented/worked on/temporally
		 * being on working on by someone in the team and linking should be done
		 * properly at later stage.
		 */
		echo $e_implement;
		
		//print_r (Region::getLatestPredictionDateById("38"));
		
		 UserPred::getPreditionForId("11");
		 User::getUserbyUserID(1);
		

	?>
</h1>
<div class="row">

<!-- Single button -->
<!-- Split button -->
<div class="btn-group">
  <button type="button" class="btn btn-danger">Action</button>
  <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
    <span class="caret"></span>
    <span class="sr-only">Toggle Dropdown</span>
  </button>
  <ul class="dropdown-menu" role="menu">
    <li><a href="#">Action</a></li>
    <li><a href="#">Another action</a></li>
    <li><a href="#">Something else here</a></li>
    <li class="divider"></li>
    <li><a href="#">Separated link</a></li>
  </ul>
</div>


<?php 

	require_once '../view/basic_footer.tpl';
	

?>
<script>

$(document).ready(function() {
    $('dropdown-toggle').dropdown()
});
</script>