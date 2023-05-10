<%--  
    This template is used to redirect to an external page using the adaptive auth dynamic prompt capability.
    An example prompt usage in adaptive script is shown below:

    prompt("externalPage", {
                "redirectURL": "https://ayshsandu.github.io/asgardeo-trial-artifacts/external-pages/commonauth-post.html",
                "properties": {
                    "username": username,
                    "fName": "First Name"
                }
            }, {
                onSuccess: function(context) {
                    Log.info("Successfully redirected to external page");
                },
                onFail: function(context, data) {
                    Log.info("Error occurred during the prompt.");
                }
            });

    * "properties" will be appended as query parameters in the redirect URL.
--%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.*" %>

<%

    // Read promptId from requestScope
    String promptId = (String) request.getAttribute("promptId");
    System.out.println("====ExternalPageTemplate:  promptId: " + promptId);

    // Read the data from requestScope
    Object dataObj = request.getAttribute("data");

    // Extract values from the complex attribute
    String redirectURL = "";
    Map<String, String> properties = new HashMap<>();

    if (dataObj instanceof Map) {
        Map<String, Object> data = (Map<String, Object>) dataObj;
        redirectURL = (String) data.get("redirectURL");
        System.out.println("====ExternalPageTemplate:  redirectURL: " + promptId);
        Object propertiesObj = data.get("properties");
        if (propertiesObj instanceof Map) {
            properties = (Map<String, String>) propertiesObj;
        }
    }

    StringBuilder queryStringBuilder = new StringBuilder();
    
    //Append promptID as a query parameter
    queryStringBuilder.append("promptId=").append(promptId);
    
    // Build query string from properties
    for (Map.Entry<String, String> entry : properties.entrySet()) {
        String key = entry.getKey();
        String value = entry.getValue();
        String encodedKey = java.net.URLEncoder.encode(key, "UTF-8");
        String encodedValue = java.net.URLEncoder.encode(value, "UTF-8");
        if (queryStringBuilder.length() > 0) {
            queryStringBuilder.append("&");
        }
        queryStringBuilder.append(encodedKey).append("=").append(encodedValue);
    }

    // Append query string to redirect URL
    if (queryStringBuilder.length() > 0) {
        if (redirectURL.contains("?")) {
            redirectURL += "&" + queryStringBuilder.toString();
        } else {
            redirectURL += "?" + queryStringBuilder.toString();
        }
    }
    System.out.println("====ExternalPageTemplate: redirectURLFinal: " + redirectURL);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirecting...</title>
    <script>
        window.location.href = "<%= redirectURL %>";
    </script>
</head>
<body>
    <p>If you are not redirected, <a href="<%= redirectURL %>">click here</a>.</p>
</body>
</html>
