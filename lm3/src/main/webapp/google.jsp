<html>
<head>
    <title>Login</title>
    <meta name="google-signin-client_id" content="YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com">
    <script async defer src="https://apis.google.com/js/platform.js"></script>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js"></script>

    <script>
      // Google Login Initialization
      function onSignIn(googleUser) {
          var id_token = googleUser.getAuthResponse().id_token;
          var xhr = new XMLHttpRequest();
          xhr.open('POST', 'GoogleLoginServlet');
          xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
          xhr.onload = function() {
              if (xhr.status === 200) {
                  window.location.href = 'dashboard.jsp';
              }
          };
          xhr.send('idtoken=' + id_token);
      }

      // Facebook Login Initialization
      window.fbAsyncInit = function() {
        FB.init({
          appId      : 'YOUR_FACEBOOK_APP_ID',
          cookie     : true,
          xfbml      : true,
          version    : 'v10.0'
        });
      };

      function checkLoginState() {
        FB.getLoginStatus(function(response) {
          if (response.status === 'connected') {
            FB.api('/me', {fields: 'name,email'}, function(profile) {
              var xhr = new XMLHttpRequest();
              xhr.open('POST', 'FacebookLoginServlet');
              xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
              xhr.onload = function() {
                  if (xhr.status === 200) {
                      window.location.href = 'dashboard.jsp';
                  }
              };
              xhr.send('userId=' + profile.id + '&name=' + profile.name + '&email=' + profile.email);
            });
          }
        });
      }
    </script>
</head>
<body>
    <h2>Login</h2>
    
    <!-- Google Login Button -->
    <div class="g-signin2" data-onsuccess="onSignIn"></div>

    <!-- Facebook Login Button -->
    <div class="fb-login-button" data-width="" data-size="large" data-button-type="continue_with"
         data-layout="default" data-auto-logout-link="false" data-use-continue-as="true"
         onlogin="checkLoginState();"></div>
</body>
</html>
