app = angular.module("corsTest", [])

app.controller("TestCtrl", ["$scope", "$http", ($scope, $http) ->
  $scope.tests = CorsTest.all_tests.map (test_class) ->
    new test_class($http)

  $scope.run_tests = ->
    $scope.tests.forEach (test) ->
      test.run()

  window.foobar = $scope
])
