<?php
	
	require_once '../controller/sessionAttributes.php';
	require_once '../model/Event.class.php';
	if (!isset($e_user)) {
		# Redirect as user is not logged in.
    	session_unset();
    	header('Location: '. SERVER_PATH. 'login/');
    	exit();
	}

?>

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header activityFeedPageHeader">Activity Feed</h1>

		<?php

            $myUserID = $e_user->getUserPKId();
            $activities = Event::getEventsFromFollowing($myUserID);

			//Max number of activity feed items to show.
			$max_activity_feed = 20;

			//iterate over the activity feed.
			for($index = 0; $index < count($activities) && $index < $max_activity_feed; $index++){
				$activity = $activities[$index]; ?>
                <div class="panel panel-info activityFeedDiv">
                    <div class="panel-body">
                        <p class="activityFeedText"><a href="<?= SERVER_PATH . 'users/'.$activity->getEventCreater()?>"><?=$activity->getEventCreater()?></a></p>
                        <p class="activityFeedDate" style="float: right"><?=$activity->getEventTime()?></p>
                        <p><?=$activity->getEventLog()?></p>
                    </div>
                </div>
	<?php  } ?>

        </div>
    </div>

</div>







