<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Search</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body ng-controller="myController">

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h1>Transaction Search</h1>
        </div>
        <div class="card-body">
            <div class="input-group mb-3">
                <input type="text" class="form-control" placeholder="Search by description" ng-model="description">
            </div>
            <div class="input-group mb-3">
                <input type="number" class="form-control" placeholder="Min amount" ng-model="minAmount">
                <input type="number" class="form-control" placeholder="Max amount" ng-model="maxAmount">
            </div>
            <div class="input-group mb-3">
                <input type="date" class="form-control" placeholder="Start date" ng-model="minDate">
                <input type="date" class="form-control" placeholder="End date" ng-model="maxDate">
            </div>
            <div class="text-center mb-3">
                <button class="btn btn-outline-secondary" type="button" ng-click="searchAll()">Search</button>
            </div>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Amount</th>
                    <th>Description</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody id="rs">

                </tbody>
            </table>
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
        $scope.searchAll = function() {
            // $scope.searchByDescription();
            // $scope.searchByAmount();
            // $scope.searchByDate();


            var req = {
                minAmount:  $scope.minAmount,
                maxAmount: $scope.maxAmount,
                description: $scope.description,
                minDate: $scope.minDate,
                maxDate: $scope.maxDate,
            }
            $http.post('/transaction/search', req)
                .then(function(response) {
                    console.log(response);
                    if (response.status == 200) {
                        let jsonData = JSON.parse(response.data)
                        let data = jsonData.success;
                        if (data) {
                            var body = "";
                            if (Array.isArray(data) && data.length > 0) {
                                data.forEach(function (item) {
                                    body += "<tr>";
                                    body += "<td>" + item.id + "</td>";
                                    body += "<td>" + item.amount + "</td>";
                                    body += "<td>" + item.description + "</td>";
                                    body += "<td>" + new Date(item.transactionDate).toLocaleDateString() + "</td>";
                                    body += "</tr>";
                                });
                            } else {
                                console.error('Invalid response:', data);
                            }
                            document.getElementById("rs").innerHTML = body;
                        }
                    } else {
                        console.error('Invalid response:', data);
                    }

                })
                .catch(function(error) {
                    console.error('Error:', error);
                });
        };
    });
</script>
<!-- Bootstrap JS and dependencies (optional) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
