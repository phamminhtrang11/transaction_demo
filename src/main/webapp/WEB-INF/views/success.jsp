<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Success</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr ng-repeat="item in listData">
                    <td>{{item.id}}</td>
                    <td>{{item.amount}}</td>
                    <td>{{item.description}}</td>
                    <td>{{item.transactionDate | date:'MM/dd/yyyy'}}</td>
                    <td>
                        <button class="btn btn-warning btn-sm" ng-click="openUpdateModal(item)">Update</button>
                        <button class="btn btn-danger btn-sm" ng-click="deleteTransaction(item.id)">Delete</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item" ng-class="{'disabled': currentPage === 0}">
                        <a class="page-link" href="#" ng-click="previousPage()" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <li class="page-item" ng-repeat="page in getPageArray()" ng-class="{'active': currentPage === page}">
                        <a class="page-link" href="#" ng-click="goToPage(page)">{{page + 1}}</a>
                    </li>
                    <li class="page-item" ng-class="{'disabled': currentPage === totalPages - 1}">
                        <a class="page-link" href="#" ng-click="nextPage()" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="text-center">
                <button class="btn btn-secondary" ng-click="previousPage()" ng-disabled="currentPage === 0">Previous</button>
                <button class="btn btn-secondary" ng-click="nextPage()">Next</button>
            </div>
            <div class="text-center mt-3">
                <button class="btn btn-success" ng-click="openAddModal()">Add Transaction</button>
            </div>
        </div>
    </div>
</div>

<!-- Add Transaction Modal -->
<div class="modal fade" id="addTransactionModal" tabindex="-1" aria-labelledby="addTransactionModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addTransactionModalLabel">Add Transaction</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="amount">Amount:</label>
                        <input type="number" class="form-control" id="amount" ng-model="newTransaction.amount">
                    </div>
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <input type="text" class="form-control" id="description" ng-model="newTransaction.description">
                    </div>
                    <div class="form-group">
                        <label for="transactionDate">Date:</label>
                        <input type="date" class="form-control" id="transactionDate" ng-model="newTransaction.transactionDate">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" ng-click="addTransaction()">Save</button>
            </div>
        </div>
    </div>
</div>

<!-- Update Transaction Modal -->
<div class="modal fade" id="updateTransactionModal" tabindex="-1" aria-labelledby="updateTransactionModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateTransactionModalLabel">Update Transaction</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="amount">Amount:</label>
                        <input type="number" class="form-control" id="amount" ng-model="selectedTransaction.amount">
                    </div>
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <input type="text" class="form-control" id="description" ng-model="selectedTransaction.description">
                    </div>
                    <div class="form-group">
                        <label for="transactionDate">Date:</label>
                        <input type="date" class="form-control" id="transactionDate" ng-model="selectedTransaction.transactionDate">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" ng-click="updateTransaction()">Save</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>

<script>
    var app = angular.module('myApp', []);
    app.controller('myController', function($scope, $http) {
        $scope.currentPage = 0;
        $scope.pageSize = 5;
        $scope.totalItems = 0;
        $scope.totalPages = 0;
        $scope.newTransaction = {};
        $scope.selectedTransaction = {};
        $scope.listData = [];

        $scope.init = function() {
            $scope.loadTransactions();
        };

        $scope.loadTransactions = function() {
            $http.post('/transaction', {
                page: $scope.currentPage,
                size: $scope.pageSize
            }).then(function(response) {
                console.log('Server response:', response.data);
                let data = response.data.success;
                console.log('Data:', data);
                if (data) {
                    $scope.listData = data;
                    $scope.totalItems = response.data.totalItems;
                    $scope.totalPages = Math.ceil($scope.totalItems / $scope.pageSize);
                    console.log('List data:', $scope.listData);
                    console.log('Total items:', $scope.totalItems);
                    console.log('Total pages:', $scope.totalPages);
                } else {
                    console.error('Invalid response:', data);
                }
            }).catch(function(error) {
                console.error('Error:', error);
            });
        };

        $scope.goToPage = function(page) {
            $scope.currentPage = page;
            $scope.loadTransactions();
        };

        $scope.getPageArray = function() {
            var totalPages = $scope.totalPages;
            var currentPage = $scope.currentPage;
            var delta = 2;
            var range = [];

            // Generate range for page numbers
            for (var i = Math.max(0, currentPage - delta); i <= Math.min(totalPages - 1, currentPage + delta); i++) {
                range.push(i);
            }

            // Add leading ellipsis if there are skipped pages before the start of the range
            if (range[0] > 0) {
                if (range[0] > 1) {
                    range.unshift('...');
                }
                range.unshift(0);
            }

            // Add trailing ellipsis if there are skipped pages after the end of the range
            if (range[range.length - 1] < totalPages - 1) {
                if (range[range.length - 2] < totalPages - 2) {
                    range.push('...');
                }
                range.push(totalPages - 1);
            }

            return range;
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

        $scope.openAddModal = function() {
            $scope.newTransaction = {};
            $('#addTransactionModal').modal('show');
        };

        $scope.addTransaction = function() {
            $http.post('/transaction/add', $scope.newTransaction).then(function(response) {
                if (response.status === 200) {
                    $('#addTransactionModal').modal('hide');
                    $scope.loadTransactions();
                    $scope.newTransaction = {};
                } else {
                    alert("Error occurred while adding transaction!");
                }
            }).catch(function(error) {
                console.error('Error:', error);
            });
        };

        $scope.openUpdateModal = function(item) {
            $scope.selectedTransaction = angular.copy(item);
            $('#updateTransactionModal').modal('show');
        };

        $scope.updateTransaction = function() {
            $http.put('/transaction/update/' + $scope.selectedTransaction.id, $scope.selectedTransaction).then(function(response) {
                if (response.status === 200) {
                    $('#updateTransactionModal').modal('hide');
                    $scope.loadTransactions();
                    $scope.selectedTransaction = {};
                } else {
                    alert("Error occurred while updating transaction!");
                }
            }).catch(function(error) {
                console.error('Error:', error);
            });
        };

        $scope.deleteTransaction = function(id) {
            if (confirm('Are you sure you want to delete this transaction?')) {
                $http.delete('/transaction/delete/' + id).then(function(response) {
                    $scope.loadTransactions();
                }).catch(function(error) {
                    console.error('Error:', error);
                });
            }
        };
    });
</script>
</body>
</html>
