<?php 

	/*
	 * For this script to operate a lot of things need to be included
	 * before including this script.
	 */
	require_once '../model/Region.class.php';
	require_once '../model/UserState.class.php';
	
	/*
	 * arguments 1) $e_user
	 *           2) $e_userPred
	 *           3) $e_region (variable)
	 */
?>
	<!-- Basic Header -->
	<div class="row">
    	<div class="col-lg-12">
        	<h1 class="page-header">DashBoard</h1>
        </div>
     </div>
     <!-- End of Basic Header -->
     
     <div class="row">
     	<form role="form"> <!--  Start of form -->
     		<table class="table table-bordered table-hover">
             	<thead>
                 	<tr>
                    	<th>Region</th>
                        <th>Prediction Date</th>
                        <th>Comment</th>
                        <th>Last Modified</th>
                     </tr>
                 </thead>
                 <?php
                 	$p_date = $e_userPred->getDateFormatted();
                 	$p_comment = $e_userPred->getComment();
                 	$p_lastModified = $e_userPred->getLastModifiedFormatted();
                 	/* Save prediction id in SESSION */
                 	$_SESSION['PREDICTION_ID'] = $e_userPred->getup_pk();
                 ?>
                 <tbody> <!--  Start of rows -->
					<tr>
						<td><?php echo $e_region?></td>
						<td><?php echo $p_date?></td>
						<td>
							<div class="col-md-6">
								<input type="text" class="form-control" name="<?php echo  $e_userPred->getup_pk().'-'.'comment'?>" value="<?php echo $p_comment?>">
							</div>
						</td>
						<td><?php echo $p_lastModified?></td>
					</tr>
                  </tbody> <!-- End of rows --> 
                  
              </table> <!-- <!-- End of table format -->
            <?php
                /*
                * Put the region name here so that server knows which
                * region to display.
                */
                $array = array('userQuery'=>$userQuery,'region'=>$e_region);

                // Construct query parameter and post it to administration.php
                $query = http_build_query($array);
            ?>
              <!--  Add the buttons now side by side -->
              <button formmethod="post" formaction="<?php echo SERVER_PATH?>administration?<?=$query?>" type="submit" class="btn btn-primary btn-sm">Discard Changes</button>
              <button formmethod="post" formaction="<?php echo SERVER_PATH?>processHandleAdminPredictionChanges?<?=$query?>" type="submit" class="btn btn-primary btn-sm">Submit Changes</button>
     	
     	</form> <!-- End of form -->
     </div>