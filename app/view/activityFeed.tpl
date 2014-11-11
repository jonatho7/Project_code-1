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
	
	<div class="userActivityFeed">
		<div>
			<h2 class="activityFeedPageHeader">Activity Feed</h2>
		</div>
		
		
		<?php
			
			$activities = Event::getEventsfromAll();
			
			
			//Max number of activity feed items to show.
			$max_activity_feed = 20;
			
			//iterate over the activity feed.
			for($index = 0; $index < count($activities) && $index < $max_activity_feed; $index++){
				$activity = $activities[$index]; ?>
				<div class="activityFeedDiv">
					<p><a href="<?= SERVER_PATH . 'users/'.$activity->getEventCreater()?>"><?=$activity->getEventCreater()?></a>&nbsp;&nbsp;<?=$activity->getEventTime()?></p>
					<p><?=$activity->getEventLog()?></p>
				</div>
							
	<?php  } ?>
		
	</div>
	
</div>







