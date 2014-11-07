
<?php
require_once '../config.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Flu Predictions Overview</title>

    <!-- Bootstrap core CSS -->
    <link href="<?php echo SERVER_PATH?>public/css/bootstrap.min.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="<?php echo SERVER_PATH?>public/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="<?php echo SERVER_PATH?>public/css/carousel.css" rel="stylesheet">
</head>
<!-- NAVBAR
================================================== -->
<body>
<div class="navbar-wrapper">
    <div class="container">

        <div class="navbar navbar-inverse navbar-static-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Flu Tracker</a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="<?php echo SERVER_PATH?>login">Login</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</div>


<!-- Carousel
================================================== -->
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <div class="item active">
            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="First slide">
            <div class="container">
                <div class="carousel-caption">
                    <h1>Overview</h1>
                    <p>This is a website for tracking Flu activity in the United States. This system is mostly useful for epidemiologists for comparing and contrasting prediction qualities of various flu tracking systems like Google Flu trends, Health Map, etc.</p>


                    <p><a class="btn btn-lg btn-primary" href="<?php echo SERVER_PATH?>register">Sign up today</a></p>
                </div>
            </div>
        </div>
        <div class="item">
            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAGZmZgAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Second slide">
            <div class="container">
                <div class="carousel-caption">
                    <h1>Make Predictions.</h1>
                  
                    <p > . Once the user is registered on the website, he/she can provide their own predictions and finally, after CDC (Centers for Disease Control and Prevention) publishes actual data based on ground surveillance reports, the user predictions are evaluated in terms of accuracy..</p>
                    <p><a class="btn btn-lg btn-primary" href="<?php echo SERVER_PATH?>register" role="button" role="button">Sign up today</a></p>
                </div>
            </div>
        </div>
        <div class="item">
            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAFVVVQAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Third slide">
            <div class="container">
                <div class="carousel-caption">
                    <h1>Get a prediction ranking</h1>
                    <p>Every user is given certain points based on the accuracy of his estimates and points get accumulated over time to give user a rank. The website acts a single place to download various data sets. The overall objective of the application is to increase flu awareness in the society and help data analysts and epidemiologists in better modeling and predicting flu activity</p>
                    <p><a class="btn btn-lg btn-primary" href="<?php echo SERVER_PATH?>register" role="button">Sign up today</a></p>
                </div>
            </div>
        </div>
    </div>
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>

?>
</div><!-- /.carousel -->



<!-- Marketing messaging and featurettes
================================================== -->
<!-- Wrap the rest of the page in another container to center all the content. -->

<div class="container marketing">







    <!-- START THE FEATURETTES -->

    <hr class="featurette-divider">

    <div class="row featurette">
        <div class="col-md-7">
            <h2 class="featurette-heading">Google Flu Trends 2013-2014 <span class="text-muted">.</span></h2>
            <p class="lead"> Summary Statistics for flu in the USA.
                <br> <b>Interpretation:</b>

                <br>Solid Blue: Actual flu cases as report by CDC.
                <br>Light Blue: Multiple predictions are made depending upon on severity of the flu disease in the current season.</p>
        </div>
        <div class="col-md-5">
            <a href ="<?php echo SERVER_PATH?>public/img/gft.png">
            <img class="featurette-image img-responsive" src="<?php echo SERVER_PATH?>public/img/gft.png" alt="Generic placeholder image">
            </a>

        </div>
    </div>


    <hr class="featurette-divider">


    <!-- /END THE FEATURETTES -->


    <!-- FOOTER -->
    <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2014 Flu Tracker, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p>
    </footer>

</div><!-- /.container -->


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<?php echo SERVER_PATH?>public/js/jquery-1.11.0.js"></script>
<script src="<?php echo SERVER_PATH?>public/js/bootstrap.min.js"></script>
<script src="<?php echo SERVER_PATH?>public/js/docs.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="<?php echo SERVER_PATH?>public/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
