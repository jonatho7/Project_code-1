<?php 
	
	$e_Title = "HIT PreView";
	$e_Preview = true;
	require_once 'basicAmtWorkerHeader.tpl';
?>

<div class="row">
	
	<!-- 
		This is the graph that is displayed to user (left column) 
	-->
	<div class="col-lg-6 col-md-6 col-sm-6">
		<img src="<?=SERVER_PATH?>public/amtdata/task1.png" class="img-responsive img-rounded" alt="Sample image for preview HIT">
	</div>
	
	<!--  form that is displayed to user in Preview Mode (right column starts)-->
	<div class="col-lg-6 col-md-6 col-sm-6">
		
		<form role="form">
			<div class="form-group">
				<label>
					Which curve, in your opinion, fits the black curve well?
				</label>
				
				<div class="radio">
  					<label>
    					<input type="radio" name="optionUser">
    						Red curve fits better.
  						</label>
				</div>
			
				<div class="radio">
  					<label>
    					<input type="radio" name="optionUser">
    						Blue curve fits better.
  					</label>
				</div>
			
				<div class="radio">
					<label>
						<input type="radio" name="optionUser">
    						Red and Blue look the same.
					</label>
				</div>
			</div>
			
			<div class="form-group">
				<textarea class="form-control" rows="3" placeholder="Write any comments you have about the task"></textarea>
			</div>
			<button type="button" class="btn btn-primary disabled">Next</button>
		</form> 
		<!--  end of form -->
	</div>
		<!--  end of right column -->
</div>

<?php 
	#echo "<br> Debuggin here.";
	require_once 'basicAmtWorkerFooter.tpl';
?>