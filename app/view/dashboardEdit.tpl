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
	 *           3) $e_userState
	 */
?>
	<!-- Basic Header -->
	<div class="row">
    	<div class="col-lg-12">
        	<h1 class="page-header">
                            DashBoard	
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="<?=SERVER_PATH?>dashboard.php">Dashboard</a>
                            </li>
                            <li class="active">
                            	<i class="fa fa-dashboard" ></i>  <a href="#">Edit Page</a>
                            </li>
                        </ol>
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
                        <th>Predicted Value</th>
                        <th>Comment</th>
                        <th>Last Modified</th>
                     </tr>
                 </thead>
                 <?php 
                 	$userState = $e_userState;
                 	$r_name = $userState->getCurrentActiveRegion(UserState::DASHBOARD_PAGE);
                 	$p_date = $e_userPred->getDateFormatted();
                 	$p_value = $e_userPred->getValue();
                 	$p_comment = $e_userPred->getComment();
                 	$p_lastModified = $e_userPred->getLastModifiedFormatted();
                 	/* Save prediction id in SESSION */
                 	$_SESSION['PREDICTION_ID'] = $e_userPred->getup_pk();
                 ?>
                 <tbody> <!--  Start of rows -->
					<tr>
						<td><?=$r_name?></td>
						<td><?=$p_date?></td>
						<td>
							<div class="col-md-6">
								<input type="text" class="form-control" name="<?=$e_userPred->getup_pk().'-'.'value'?>" value="<?=$p_value?>">
							</div>
						</td>
						<td>
							<div class="col-md-6">
								<input type="text" class="form-control" name="<?= $e_userPred->getup_pk().'-'.'comment'?>" value="<?=$p_comment?>">
							</div>
						</td>
						<td><?=$p_lastModified?></td>
					</tr>
                  </tbody> <!-- End of rows --> 
                  
              </table> <!-- <!-- End of table format -->
              
              <!--  Add the buttons now side by side -->
              <button formmethod="post" formaction="<?=SERVER_PATH?>dashboard.php" type="submit" class="btn btn-primary btn-sm">Discard Changes</button>
              <button formmethod="post" formaction="<?=SERVER_PATH?>processHandlePredictionChanges.php" type="submit" class="btn btn-primary btn-sm">Submit Changes</button>
     	
     	</form> <!-- End of form -->
     </div>