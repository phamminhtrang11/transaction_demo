<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Success</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body ng-app="myApp" ng-controller="myController" ng-init="init()">
<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h1>Transaction Successful!</h1>
            <i class="fas fa-search" ng-click="redirectToSearch()" style="cursor: pointer; float: right;"></i>
        </div>
        <div class="card-body">
            <p class="lead">Transaction Details:</p>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Amount</th>
                    <th>Description</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody id="rs"></tbody>
            </table>
            <div class="text-center">
                <button class="btn btn-secondary" ng-click="previousPage()" ng-disabled="currentPage === 0">Previous</button>
                <button class="btn btn-secondary" ng-click="nextPage()">Next</button>
            </div>
        </div>
        <div class="card-footer text-center">
            <a href="/" class="btn btn-primary">Go to Home</a>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
<script>
    var app = angular.module('myApp', []);
    app.controller('myController', function($scope, $http) {
        $scope.currentPage = 0;
        $scope.pageSize = 5;

        $scope.init = function() {
            $scope.loadTransactions();
        };

        $scope.loadTransactions = function() {
            $http.post('/transaction', {
                page: $scope.currentPage,
                size: $scope.pageSize
            }).then(function(response) {
                console.log('Full Response:', response);
                let data = response.data.success;
                if (data) {
                    if (Array.isArray(data) && data.length > 0) {
                        let body = "";
                        data.forEach(item => {
                            body += "<tr>";
                            body += "<td>" + item.id + "</td>";
                            body += "<td>" + item.amount + "</td>";
                            body += "<td>" + item.description + "</td>";
                            body += "<td>" + new Date(item.transactionDate).toLocaleDateString() + "</td>";
                            body += "</tr>";
                        });
                        document.getElementById("rs").innerHTML = body;
                    } else {
                        document.getElementById("rs").innerHTML = "<tr><td colspan='4'>No transactions found.</td></tr>";
                    }
                } else {
                    console.error('Invalid response:', data);
                }
            }).catch(function(error) {
                console.error('Error:', error);
            });
        };


        $scope.previousPage = function() {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.loadTransactions();
            }
        };

        $scope.nextPage = function() {
            $scope.currentPage++;
            $scope.loadTransactions();
        };

        $scope.redirectToSearch = function() {
            window.location.href = 'search';
        };
    });
</script>
<!-- Bootstrap JS and dependencies (optional) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
