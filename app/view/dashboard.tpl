<?php 

	/*
	 * For this script to operate a lot of things need to be included
	 * before including this script.
	 */
	require_once '../model/Region.class.php';
	require_once '../model/UserState.class.php';
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
					echo "<h3>This user was not found.</h3>";
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
			<ol class="breadcrumb">
				<li>
					<i class="fa fa-dashboard"></i>  <a href="#">Dashboard</a>
				</li>
				
				<!--  Not Required as of Now. See me later.
					<li class="active">
						<i class="fa fa-file"></i>My Predictions
					</li>
				 -->
			</ol>
        </div>
     </div>
	
	<?php
		//echo "<p>$e_userState: {$e_userState}</p>";
	?>
     
     <!-- End of Basic Header -->
     <div class="row">
     	<div class="col-lg-6">
     	
     		<?php 
     			/*
     		 	* Get all the regions from The database as array
     		 	*/
     				$regions = Region::getAllRegions();
     				#$size = count($regions);
     				#for ($i =0; $i < $size; $i++) {
					#	echo "Region id = " . $regions[$i]->getRegionId(). " name = " . $regions[$i]->getRegionName() . "<br>";
					#}
     				$userState = $e_userState;
     				$r_name = $userState->getCurrentActiveRegion(UserState::DASHBOARD_PAGE);
     				$userPredList = $userState->getPredictionsforRegion($r_name);
					
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
									if ($r_name== $regions[$i]->getRegionName())
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
							echo 'List of predictions made for '.$r_name;
						} else {
							echo 'No predictions yet made for '.$r_name;
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
											<button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processDashboardEdit.php" class="btn btn-warning btn-xs" <?php if ($userPredList[$i]->isExpriredPrediction()) {echo "disabled"; } ?> name="up_id" value="<?php echo $userPredList[$i]->getup_pk()?>">Edit</button>
											<button type="submit" formmethod="post" formaction="<?php echo SERVER_PATH?>processDashboardDelete.php" class="btn btn-danger btn-xs" <?php if ($userPredList[$i]->isExpriredPrediction()) {echo "disabled"; } ?> name="up_id" value="<?php echo $userPredList[$i]->getup_pk()?>">Delete</button>
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
     	
     	</div>
     
     </div>