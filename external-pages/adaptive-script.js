var onLoginRequest = function(context) {
    executeStep(1, {
        onSuccess: function(context) {
            var username = context.steps[1].subject.username;
            Log.info("========== Promt call is about to execute");
            prompt("externalPage", {
                "redirectURL": "https://ayshsandu.github.io/asgardeo-trial-artifacts/external-pages/commonauth-post.html",
                "properties": {
                    "username": username,
                    "fName": "First Name"
                }
            }, {
                onSuccess: function(context) {
                   	var customClaim = "";
                    if (context.request.params && context.request.params.customClaim){
                       customClaim = context.request.params.customClaim[0];
                    }
                    //var lname = context.request.params.lname[0];
                    //Log.info(context.request.params.fname);
                    //Log.info(fname);
                    Log.info("Successfully redirected to external page");
                    Log.info(customClaim);
                   
                    var origin = context.request.headers["origin"];
                    Log.info("Request came from the Origin: " + origin);
                    if (!origin.startsWith("https://ayshsandu.github.io") ){
                        var parameterMap = {'errorCode': 'access_denied', 'errorMessage': 'Invalid host found.'};
                        fail(parameterMap);
                    }
                    executeStep(2);
                },
                onFail: function(context, data) {
                    Log.info("Error occurred while prompt");
                }
            });
            Log.info("========== Promt call is executed");
        }
    });
};