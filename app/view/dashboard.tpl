<?php 

	/*
	 * For this script to operate a lot of things need to be included
	 * before including this script.
	 */
	require_once '../model/Region.class.php';
	require_once '../model/UserState.class.php';
	/*
	INPUTS: $e_user (object)
	         $e_region (name)
	*/
?>
	
	<?php
		//TODO. Get user role from database.
		//userRole options: 0 = "registered_user", 1 = "moderator", 2 = "admin".
		$userRole = 2;
		
		//The logged in user's username
		$userName = $e_user->getUserid();
		
		//Whether the user is viewing their own page or someone else's page.
		$viewingOwnPage = true;
		
		if ($userRole > 0){
			if (isset($_GET["userQuery"])){
				$userQuery = $_GET["userQuery"];
				
				//We need to determine whether the username from the userQuery is a valid user in the database.
				$profile_user = User::getUserByUserName($userQuery);
				if ($profile_user == null){
					//This user does not exist in the DB. Display a message.
					echo "<h2>I'm sorry</h2>";
                    echo "<h4 class='userNotFound'>This user was not found.</h4>";
					$redirectPath = SERVER_PATH . 'dashboard.php';
					echo '<p><a href="' . $redirectPath . '">Your Dashboard</a></p>';
					die();
				}
				
				$profile_userName = $profile_user->getUserid();
				if ($profile_userName == $userName){
					$viewingOwnPage = true;
				} else {
					$viewingOwnPage = false;
				}
			}
		}
		
	?>

	<!-- Basic Header -->
	<div class="row">
    	<div class="col-lg-12">
			<?php
				if ($userRole > 0 && $viewingOwnPage == true ){
					echo "<h1 class='page-header'>DashBoard</h1>";
				} else {
					echo "<h1 class='page-header'>DashBoard (for {$userQuery})</h1>";
				}
			?>

        </div>
     </div>

     <!-- End of Basic Header -->
     <div class="row">
     	<div class="col-lg-6">
            <h3>Predictions List View</h3>
     		<?php 
     			/*
     		 	* Get all the regions from The database as array
     		 	*/

     				$userPredList = UserData::getPredictionsForRegion($e_user,$e_region);
                    $regions = Region::getAllRegions();
     		?>
     	      <!-- Row starts-->
              <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Select Region </h3>
                </div>
            
                <div class="panel-body">
                    <form role="form">
                        <div class="form-group">
                            <select class="form-control" name="ChangeRegionName">
                            <?php 
                                $size = count($regions);
                                for ($i =0; $i < $size; $i++) {
									$selected = '';
									if ($e_region== $regions[$i]->getRegionName())
										$selected = "selected";	
                                    echo "<option $selected>". $regions[$i]->getRegionName() . '</option>';
                                }
                            ?>
                        </select>
                        </div>
                        <div class="form-group">
                            <button formmethod="post" formaction="<?php echo SERVER_PATH?>ProcessDashBoardChangeRegion.php" 
                            		type="submit" class="btn btn-primary">
                           		Change Region
                            </button>
                        </div>
                    </form>
                </div>
             </div> <!-- End of panel -->
            </div> <!-- Row ends -->
     		 	
    		
            <!--  <div class="row"> 
                <p class="h3">
                    Bordered Table
                </p> -->
                
                <!-- Start of table-->
                <div class="table-responsive">
                    <?php 
                    	/*$userState = $e_userState;
                    	$r_name = $userState->getCurrentActiveRegion(UserState::DASHBOARD_PAGE);
                    	$userPredList = $userState->getPredictionsforRegion($r_name);*/
                    	//echo count($userPredList);
                    ?>
                    <p class="h4">
                    	<?php 
                    	if (count($userPredList) != 0) {
							echo 'List of predictions made for '.$e_region;
						} else {
							echo 'No predictions yet made for '.$e_region;
                    	}
						?>
                	</p>
                    
                    
                   <?php //Table appears only if there are any entries
                   if (count($userPredList) != 0) { ?>
                    <!-- table starts -->
                    <table class="table table-bordered table-hover">
                        <thead>
                         	<tr>
                              <th>Date</th>
                              <th>Value</th>
                              <th>Comment</th>
                              <th>Modify</th>
                            </tr>
                        </thead>
                        <tbody>
                         <?php
                         	$count = count($userPredList);
                         	for ($i=0; $i < $count; $i++) { ?>
								<tr>
									<td><?php echo $userPredList[$i]->getDateFormatted()?></td>
									<td><?php echo $userPredList[$i]->getValue()?></td>
									<td><?php echo $userPredList[$i]->getComment()?></td>
									<td>
										<form role="role">
                                            <?php
                                                /*
                                                 * Put the region name here so that server knows which
                                                 * region to display.
                                                 */
                                                $array = array('region'=>$e_region);

                                                // Construct query parameter and post it to dashboard.php
                                                $query = http_build_query($array);
                                            ?>
                                            <button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processDashboardEdit.php?<?=$query?>" class="btn btn-warning btn-xs" <?php if ($userPredList[$i]->isExpriredPrediction()) {echo "disabled"; } ?> name="up_id" value="<?php echo $userPredList[$i]->getup_pk()?>">Edit</button>
											<button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processDashboardDelete.php?<?=$query?>" class="btn btn-danger btn-xs" <?php if ($userPredList[$i]->isExpriredPrediction()) {echo "disabled"; } ?> name="up_id" value="<?php echo $userPredList[$i]->getup_pk()?>">Delete</button>
										</form>
									</td>
								</tr>
							<?php }
                         ?>
                        </tbody>
                    </table> <!-- <!-- End of table format -->
                   <?php } ?>
                </div> <!--  Row Ending -->
    	
    	</div>
    	<!--  End of left side -->
     	
     	<!--  Right side start-->
     	<div class="col-lg-6">
     		
     		<?php 
     			if ($e_user->isAdmin()) { ?>
					
					<button type="button" class="adminMode btn btn-primary">Enter Admin Mode</button>
					
					<script >
						$(".adminMode").show();
						$("li.adminMode").hide();
						var adminMode = false;
					</script>
				<?php }
     		?>
           <h3>Predictions Graph View</h3>
            <div id="container" style="height: 400px"></div>
            <div id="drag"></div>
            <div id="drop"></div>
            <script src="<?php echo SERVER_PATH?>public/js/highcharts/proj5chart.js"></script>

            <div>
                <button class="changeValue" type="button">
                    Zoom
                </button>
            </div>
     	
     	</div>

     
     </div>