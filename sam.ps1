# Using TLS 1.2 instead of PowerShell default TLS 1.0. Because Secret Server Cloud explicitly supports TLS 1.2 - this version includes fixes for known vulnerabilities in older TLS versions, and will eventually be required for PCI compliance.
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12



$AppInfoDataPost = [ordered]@{ "domain" = "demo-api-abrar";    "muleVersion" = [ordered]@{ "version"="4.2.2"  };    "properties" = [ordered]@{ "mule.env"="Sandbox";   "monitoringEnabled"="true";    "monitoringAutoRestart"="true";    "workers" = [ordered]@{        "amount"="1";        "type" = [ordered]@{ "name"="micro" }};    "loggingNgEnabled"="true";    "persistentQueues"="false";    "objectStoreV1"="true"} }


$AppInfoDataPut = [ordered]@{    "muleVersion" = [ordered]@{ "version"="4.2.2" };    "properties" = [ordered]@{ "mule.env"="Sandbox";   "monitoringEnabled"="true";    "monitoringAutoRestart"="true";    "workers" = [ordered]@{        "amount"="1";        "type" = [ordered]@{ "name"="micro"  }    };    "loggingNgEnabled"="true";    "persistentQueues"="false";    "objectStoreV1"="true"} } 

$ApiName = "demo-api-abrar"

$Creds = @{
           username = "mdabrar1"
           password = "@burosE4"
           }

$HeadersToken = $null

# Api Call to get access token
$Response = Invoke-RestMethod "https://anypoint.mulesoft.com/accounts/login" -Method Post -Body $Creds -Headers $HeadersToken
$Token = $Response.access_token
Write-Output $Token
#Write-Output $token

$HeadersApi = @{"Authorization"="Bearer $Token"; "X-ANYPNT-ENV-ID"="8cad4662-1dbe-4712-b89a-9bdf40c65e2e"}

$GetApi = Invoke-RestMethod "https://anypoint.mulesoft.com/cloudhub/api/v2/applications" -Method Get -Headers $HeadersApi -ContentType 'application/json' -ErrorAction SilentlyContinue

Write-Output $GetApi




#Jar file path

$JarFile = "target\demo-api-abrar.1.0.0-SNAPSHOT-mule-application.jar"



#AppInfoData for PUT method - Update application
$PutData = $AppInfoDataPut

$AppJsonPut = $PutData | ConvertTo-Json -Depth 100 | % { [System.Text.RegularExpressions.Regex]::Unescape($_) }

#AppInfoData for POST method - Create application
$PostData = #{AppInfoDataPost}

$AppJsonPost = $PostData | ConvertTo-Json -Depth 100 | % { [System.Text.RegularExpressions.Regex]::Unescape($_) }


#Curl Arguments for to Update Application
$CurlArgumentsFileDeploy = '--request', 'PUT', 
                           "https://anypoint.mulesoft.com/cloudhub/api/v2/applications/$ApiName",
                           '--header', "authorization: bearer $Token",
                           '--header', "cache-control: no-cache",
                           '--header', "x-anypnt-env-id: $EnvId",
                           '--header', "content-type: multipart/form-data",
                           '--form', "appInfoJson=$AppJsonPut",
                           '--form', "file=@$JarFile"

#Curl Arguments for Creating Api and Deploying jar
$CurlArgumentsApiDeploy = '--request', 'POST', 
                          "https://anypoint.mulesoft.com/cloudhub/api/v2/applications",
                          '--header', "authorization: bearer $Token",
                          '--header', "cache-control: no-cache",
                          '--header', "x-anypnt-env-id: $EnvId",
                          '--header', "content-type: multipart/form-data",
                          '--form', "appInfoJson=$AppJsonPost",
                          '--form', "autoStart=true",
                          '--form', "file=@$JarFile"
