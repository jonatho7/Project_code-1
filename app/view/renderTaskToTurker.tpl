<?php 

require_once '../config.php';
require_once '../controller/AMTTurkerState.php';
/*
 *	This view is responsible for rendering the a given
 *  task for AMT Turker 
 * 
 */
$currentTask = getCurrentTask();
$e_Title = "HIT in Progress";
$e_Preview = false;
require_once 'basicAmtWorkerHeader.tpl';
?>

<div class="row">
	
	<!-- 
		This is the graph that is displayed to user (left column) 
	-->
	<div class="col-lg-6 col-md-6 col-sm-6">
		<img src="<?=SERVER_PATH?>public/amtdata/task<?=$currentTask?>.png" class="img-responsive img-rounded" alt="Sample image for preview HIT">
	</div>
	
	<!--  form that is displayed to user in Preview Mode (right column starts)-->
	<div class="col-lg-6 col-md-6 col-sm-6">
		
		<form id="Questionformid" role="form" method="post" action="<?= SERVER_PATH . 'handleTurkerRequest'?>">
			<div class="form-group">
				<label>
					Which curve, in your opinion, fits the black curve well?
				</label>
				
				<div class="radio">
  					<label>
    					<input type="radio" name="task_answer_<?=$currentTask?>" value="red" required>
    						Red curve fits better.
  						</label>
				</div>
			
				<div class="radio">
  					<label>
    					<input type="radio" name="task_answer_<?=$currentTask?>" value="blue">
    						Blue curve fits better.
  					</label>
				</div>
			
				<div class="radio">
					<label>
						<input type="radio" name="task_answer_<?=$currentTask?>" value="same">
    						Red and Blue look the same.
					</label>
				</div>
			</div>
			
			<div class="form-group">
				<textarea class="form-control" name="task_comment_<?=$currentTask?>" rows="3" placeholder="Write any comments you have about the task"></textarea>
			</div>
			
			<div class="form-group">
				<input type="hidden" name="<?=WORKER_ID?>" value="<?=getWorkerId()?>"
			</div>
			
			<button type="submit" class="btn btn-primary">Next</button>
		</form> 
		<!--  end of form -->
		
		<script>
			//Small code here to validate the Question.Better this be here rather than
			// anywhere else
			$(document).ready(function() {
				$("#Questionformid").validate();
			}
		</script>
	</div>
		<!--  end of right column -->
</div>

<?php 
	#echo "<br> Debuggin here.";
	require_once 'basicAmtWorkerFooter.tpl';
?>