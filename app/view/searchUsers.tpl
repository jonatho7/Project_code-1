<?php 

	/*
	 * This is the script for searching users in the application having public profiles.
	 *
	 */
	require_once '../model/Region.class.php';
	require_once '../model/UserState.class.php';
    /*
     *
     * INPUTS: $e_user (object)
	         $e_region (name)
     */
?>
	<!-- Basic Header -->
	<div class="row">
    	<div class="col-lg-12">
        	<h1 class="page-header">
                            Find Users who made predictions (region-wise)
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard" ></i>  <a href="#">Find users</a>
                            </li>
                        </ol>
                    </div>
     </div>
     
     <!-- End of Basic Header -->
     <div class="row">
     	<div class="col-lg-6">
     	
     		<?php 
     			/*
     		 	* Get all the regions from the database as array
     		 	*/
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
                            <button formmethod="post" formaction="<?=SERVER_PATH?>ProcessSearchUsersChangeRegion.php"
                            		type="submit" class="btn btn-primary">
                           		Change Region
                            </button>
                        </div>
                    </form>
                </div>
             </div> <!-- End of panel -->
            </div> <!-- Row ends -->
     		 	
    		

                <!-- Start of table-->
                <div class="table-responsive">
                    <?php 

                    	// get users who have made a prediction as a list
                        // getUsersforRegion($r_name) gets users

                        $usersList = UserData::getUsersForRegion($e_region);

                    ?>
                    <p class="h4">
                    	<?php 
                    	if (count($usersList) != 0) {
							echo 'List of users who have predictions for '.$e_region;
						} else {
							echo 'No users have yet made predictions made for '.$e_region;
                    	}
						?>
                	</p>
                    
                    
                   <?php //Table appears only if there are any entries
                   if (count($usersList) != 0) { ?>
                    <!-- table starts -->
                    <table class="table table-bordered table-hover">
                        <thead>
                         	<tr>
                              <th>UserName</th>

                            </tr>
                        </thead>
                        <tbody>
                         <?php
                         	$count = count($usersList);

                         	for ($i=0; $i < $count; $i++) {
                         	    if ($usersList[$i]==$userName)
                         	        continue;
                         	    $friendPath = SERVER_PATH . "users/" . $usersList[$i];
                         	?>
								<tr>
									<td><a href=<?=$friendPath?>><?=$usersList[$i]?></a></td>

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