<?php
  
	/*
	 * While including do the following:
	 *  1) Include global configuration file
	 *  2) $e_Title = Title of the page.
	 *  3) $e_user = user object.
	 */

?>

<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><?php echo $e_Title?></title>

    <!-- Bootstrap Core CSS -->
    <link href="<?php echo  SERVER_PATH ?>public/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="<?php echo  SERVER_PATH ?>public/css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<?php echo  SERVER_PATH ?>public/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- jQuery Version 1.11.0 -->
    <script src="<?php echo  SERVER_PATH ?>public/js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<?php echo  SERVER_PATH ?>public/js/bootstrap.min.js"></script>

	<link href="<?php echo  SERVER_PATH ?>public/css/profilePage.css" rel="stylesheet">
	<link href="<?php echo  SERVER_PATH ?>public/css/flutracker.css" rel="stylesheet">
	<script src="<?php echo  SERVER_PATH ?>public/js/flutracker.js"></script>

</head>

<body data-server-path="<?=SERVER_PATH?>" data-username="<?=$e_user->getUserid()?>">

    <!---    
		This wraps everything in the page.
    -->
    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <a class="navbar-brand" href="<?php echo  SERVER_PATH ?>dashboard.php">Flu Tracker</a>
            </div>
            
            <!-- 
            	Top Menu Items 
				These appear as horizontal columns
            -->

            <ul class="nav navbar-right top-nav">
                
                <!-- 
                	
                	Commented out *** CHANGE.
                	We need to remove this if we are not able to add any functionality. 
                	
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu alert-dropdown">
                        <li>
                            <a href="#">Alert Name <span class="label label-default">Alert Badge</span></a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">View All</a>
                        </li>
                    </ul>
                </li>
                -->
                
                
                <li class="dropdown">
                    <?php 
                    	/*
                    	 * get the first and last name of the user from $e_user object.
                    	 */
                    	if (empty($e_user)) {
							$firstName = "foo";
    						$lastName  = "bar";
						} else {
							$firstName = $e_user->getFirstName();
							$lastName = $e_user->getLastName();
						}
                    ?>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    	<i class="fa fa-user"></i> <?php echo  $firstName. " ". $lastName ?> 
                    		<b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
							<?php
								$userName = $e_user->getUserid();
								$redirectPath = SERVER_PATH . 'users/' . $userName;
							?>
                            <a href="<?php echo $redirectPath?>"><i class="fa fa-fw fa-user"></i> Profile</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <?php 
                            	/*
                            	 * 
                            	 * Again Change me. The link should be home page. 
                            	 * With some error popped out or something.
                            	 * 
                            	 * 
                            	 */
                            
                            ?>
                            <a href="<?php echo SERVER_PATH?>logout.php"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <!-- 
				
				******** END of HORIZONTAL COLUMNS ***************

            -->

            <!-- 
            	Sidebar Menu Items - These collapse to the responsive navigation menu on small screens 
				
            -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <!--  START
                    	Will add as per requirements
                    
                    <li>
                        <a href="tables.html"><i class="fa fa-fw fa-table"></i> Tables</a>
                    </li>
                    	END OF COMMENTS
                     -->
					 <li>
                        <a href="<?php echo SERVER_PATH?>activityFeed"><i class="fa fa-fw fa-wrench"></i> Activity Feed</a>
                    </li>
					 
					<li>
                        <a href="<?php echo SERVER_PATH?>dashboard.php"><i class="fa fa-fw fa-wrench"></i> My Predictions</a>
                    </li>
					
					<li>
                        <a href="#"><i class="fa fa-fw fa-wrench"></i> Others Predictions</a>
                    </li>
					
                    <li>
                        <a href="<?php echo SERVER_PATH?>dashboardAddNewPrediction.php"><i class="fa fa-fw fa-wrench"></i> Make New Predictions</a>
                    </li>
                	
                	<!--       
                    		Commented out and We need to reconsider whether we need
                    		to add these are not.	
                    <li>
                        <a href="#"><i class="fa fa-fw fa-wrench"></i>Download Data</a>
                    </li>
                    
                    -->
                
                </ul>
            </div>
            <!-- 
					End of horizontal menu bar. Anything which goes in here will appear
					as horizontal menu bar.
	
            -->

            <!-- /.navbar-collapse -->
        </nav>


        <div id="page-wrapper">			
			<div class="container-fluid">
			<?php 
				
			/*
			 *  This is where the content for each page will go in.
			 *  One could add breadcrumbs, header, and other elements.
			 */
			?>