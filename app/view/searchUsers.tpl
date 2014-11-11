<?php 

	/*
	 * This is the script for searching users in the application having public profiles.
	 *
	 */
	require_once '../model/Region.class.php';
	require_once '../model/UserState.class.php';
?>
	<!-- Basic Header -->
	<div class="row">
    	<div class="col-lg-12">
        	<h1 class="page-header">
                            Find Users
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard" ></i>  <a href="#">Find users</a>
                            </li>
                            
                            <!--  Not Required as of Now. See me later.
                            	<li class="active">
                                	<i class="fa fa-file"></i>My Predictions
                            	</li>
                             -->
                        </ol>
                    </div>
     </div>
     
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
                            <button formmethod="post" formaction="<?=SERVER_PATH?>ProcessSearchUsersChangeRegion.php"
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

                    	// get users who have made a prediction as a list. getUsersforRegion($r_name) gets users


                    	$userState = $e_userState;
                    	$r_name = $userState->getCurrentActiveRegion(UserState::DASHBOARD_PAGE);
                        $userPredList = $userState->getUsersForRegion($r_name);

                    ?>
                    <p class="h4">
                    	<?php 
                    	if (count($userPredList) != 0) {
							echo 'List of users who have predictions for '.$r_name;
						} else {
							echo 'No users with predictions yet made for '.$r_name;
                    	}
						?>
                	</p>
                    
                    
                   <?php //Table appears only if there are any entries
                   if (count($userPredList) != 0) { ?>
                    <!-- table starts -->
                    <table class="table table-bordered table-hover">
                        <thead>
                         	<tr>
                              <th>UserName</th>

                            </tr>
                        </thead>
                        <tbody>
                         <?php
                         	$count = count($userPredList);

                         	for ($i=0; $i < $count; $i++) {
                         	if ($userPredList[$i]==$userName)
                         	continue;
                         	$friendPath = SERVER_PATH . "users/" . $userPredList[$i];
                         	?>
								<tr>
									<td><a href=<?=$friendPath?>><?=$userPredList[$i]?></a></td>

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