var app = angular.module('HighFive', [

])

app.service( 'customerService', function ($http, $q) {

    return({
        getCustomers: getCustomers,
        addCustomer: addCustomer,
        deleteCustomer: deleteCustomer
    });

    function getCustomers() {
        var request = $http({method: "get", url: "/customers.json"});
        return (request.then( handleSuccess, handleError ));
    }

    function addCustomer(name, address) {
        var request = $http({method:"post", url: '/customers.json',
            data : {name: name, address: address}
        });
        return( request.then( handleSuccess, handleError) );
    }

    function deleteCustomer( id ) {
        var request = $http({ method:"delete", url: '/customers/' + id + '.json' });
        return( request.then( handleSuccess, handleError) );
    }

    function handleSuccess( response ) {
        return( response.data );
    }

    function handleError( response ) {
        return ( $q.reject("An unknown error occurred") );
    }

});

app.controller('CustomerController', function($scope, customerService) {

    function renderCustomers(customers) {
        $scope.customers = customers;
    }

    function getCustomers() {
        customerService.getCustomers().then(
            function( customers ) {
                renderCustomers( customers );
            }
        )
    }

    $scope.addCustomer = function() {
        customerService.addCustomer( $scope.form.name, $scope.form.address );
        getCustomers();
    }

    $scope.deleteCustomer = function(customer) {
        customerService.deleteCustomer( customer.id ).then( getCustomers() )
    }

    // load on page loads
    getCustomers();

});