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