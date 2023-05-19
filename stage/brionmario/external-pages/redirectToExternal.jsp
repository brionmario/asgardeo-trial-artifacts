<%--
  ~ Copyright (c) 2023, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
  ~
  ~ WSO2 LLC. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
--%>

<%--  
    This template is used to redirect to an external page using the adaptive auth dynamic prompt capability.
    An example prompt usage in adaptive script is shown below:

    prompt("externalPage", {
                "redirectURL": "https://ayshsandu.github.io/asgardeo-trial-artifacts/external-pages/commonauth-post.html",
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

    // Read promptId from request
    String promptId = (String) request.getAttribute("promptId");

    // Read the data from request
    Object dataObj = request.getAttribute("data");

    // Extract redirect URL from the request data
    String redirectURL = "";
    Map<String, String> properties = new HashMap<>();

    if (dataObj instanceof Map) {
        Map<String, Object> data = (Map<String, Object>) dataObj;
        redirectURL = (String) data.get("redirectURL");
    }

    StringBuilder queryStringBuilder = new StringBuilder();
    
    // Append promptID as a query parameter
    queryStringBuilder.append("promptId=").append(promptId);å
    // Append query string to redirect URL
        if (redirectURL.contains("?")) {
            redirectURL += "&" + queryStringBuilder.toString();
        } else {
            redirectURL += "?" + queryStringBuilder.toString();
        }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script>
        window.location.href = "<%= redirectURL %>";
    </script>
</head>
<body>
    <h4>Redirecting...</h4>
    <p>If you are not redirected, <a href="<%= redirectURL %>">click here</a>.</p>
</body>
</html>
