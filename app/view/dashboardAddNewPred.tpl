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
                                <i class="fa fa-dashboard"></i>  <a href="<?php echo SERVER_PATH?>dashboard.php">Dashboard</a>
                            </li>
                            <li class="active">
                            	<i class="fa fa-dashboard" ></i>  <a href="#">Make new Prediction</a>
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
                        <th>Tag</th>
                     </tr>
                 </thead>
                 <?php 
                 	$regions = Region::getAllRegions();
                 	
                 	/*$userState = $e_userState;
                 	$r_name = $userState->getCurrentActiveRegion(UserState::DASHBOARD_PAGE);
                 	$p_date = $e_userPred->getDateFormatted();
                 	$p_value = $e_userPred->getValue();
                 	$p_comment = $e_userPred->getComment();
                 	$p_lastModified = $e_userPred->getLastModified();
                 	/* Save prediction id in SESSION */
                 	//$_SESSION['PREDICTION_ID'] = $e_userPred->getup_pk();
                 	/*
                 	 * Select any region as of them will have the same latest date
                 	 */
                 	$min_date = Region::getLatestPredictionDateById($regions[0]->getRegionId())
                 ?>
                 <tbody> <!--  Start of rows -->
					<tr>
						<!--  Region selection -->
						<td><div class="form-group">
                            <select class="form-control" name="regionName">
                            <?php 
                                $size = count($regions);
                                for ($i =0; $i < $size; $i++) {	
                                    echo "<option>". $regions[$i]->getRegionName() . '</option>';
                                }
                            ?>
                        	</select>
                        </td>
						
						<td>
							<div class="col-md-8">
								<input type="date" required class="form-control" min="<?php echo $min_date->format('Y-m-d')?>" name="predDate"> 
							</div>
						</td>
						<td>
							<div class="col-md-6">
								<input type="text" required class="form-control" name="value">
							</div>
						</td>
						<td>
							<div class="col-md-6">
								<input type="text"  class="form-control" name="comment">
							</div>
						</td>
					</tr>
                  </tbody> <!-- End of rows --> 
                  
              </table> <!-- <!-- End of table format -->
              
              <!--  Add the buttons now side by side -->
              <button data-redirect-url="<?php echo SERVER_PATH?>dashboard.php" class="btn btn-primary btn-sm actionRedirect" >Discard Changes</button>
              <button formmethod="post" formaction="<?php echo SERVER_PATH?>processUserEdit.php" type="submit" class="btn btn-primary btn-sm">Submit Changes</button>

     	</form> <!-- End of form -->
     </div>
