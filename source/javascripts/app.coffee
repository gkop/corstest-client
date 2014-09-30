app = angular.module("corsTest", [])

app.controller("TestCtrl", ["$scope", "$http", ($scope, $http) ->
  $scope.tests = CorsTest.all_tests.map (test_class) ->
    new test_class($http, -> $scope.$apply() )

  $scope.run_tests = ->
    #$scope.tests.slice(0,1).forEach (test) ->
    $scope.tests.forEach (test) ->
      # Don't run insecure tests from HTTPS page,
      # because they may succeed but "break" the padlock icon
      if window.location.protocol == "http:" ||
         test.display_name.match(/HTTPS|TLS|SPDY/)
        test.run()

  window.foobar = $scope

])

app.controller("ProtocolCtrl", ["$scope", ($scope) ->
  $scope.is_https = ->
    window.location.protocol == "https:"

  $scope.current_url = (protocol) ->
    url = window.location.toString()
    if protocol == "https"
      url = url.replace(/^http:/, "https:")
    else if protocol == "http"
      url = url.replace(/^https:/, "http:")
])
