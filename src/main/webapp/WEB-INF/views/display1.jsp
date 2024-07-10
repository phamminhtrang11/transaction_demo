<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
    <meta charset="UTF-8">
    <title>Display Page</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
</head>
<body ng-controller="myController">
<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h1>Display Page</h1>
        </div>
        <div class="card-body text-center">
            <p>This is the display page.</p>
            <button class="btn btn-primary" ng-click="redirectToSuccess()">Go to Success</button>
        </div>
    </div>
</div>

<!-- AngularJS Script -->
<script>
    var app = angular.module('myApp', []);
    app.controller('myController', function($scope, $http, $window) {
        $scope.redirectToSuccess = function() {
            $http.post('/transaction' ).then(function(response) {
            console.log(response);
            let data = JSON.parse(response.data)
            if (data.success) {
                window.location.href = data.redirectURL;
                } else {
                    console.error('Invalid response:', data);
                }
            }).catch(function(error) {
                console.error('Error:', error);
            });
        };
    });
</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
