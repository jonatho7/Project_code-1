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


    <script src="<?=SERVER_PATH?>public/js/dashboardAddNewPrediction.js"></script>
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
                        <th>Comment</th>
                     </tr>
                 </thead>
                 <?php 
                 	$regions = Region::getAllRegions();
                 	

                 	/*
                 	 * Select any region as of them will have the same latest date
                 	 */
                 	$min_date = Region::getLatestPredictionDateById($regions[0]->getRegionId())
                 ?>
                 <tbody> <!--  Start of rows -->
					<tr>
						<!--  Region selection -->
						<td><div class="form-group">
                            <select class="form-control" name="regionName" id="regionSelected">
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
								<input type="text" required class="form-control"  readonly id="predDate" name="predDate">
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
