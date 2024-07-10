<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Success</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h1>Transaction Successful!</h1>
        </div>
        <div class="card-body">
            <p class="lead">Transaction Details:</p>
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <th>ID</th>
                    <td>${transaction.id}</td>
                </tr>
                <tr>
                    <th>Amount</th>
                    <td>${transaction.amount}</td>
                </tr>
                <tr>
                    <th>Description</th>
                    <td>${transaction.description}</td>
                </tr>
                <tr>
                    <th>Date</th>
                    <td>${transaction.transactionDate}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="card-footer text-center">
            <a href="/" class="btn btn-primary">Go to Home</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies (optional) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
