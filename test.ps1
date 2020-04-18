$Creds = @{
           username = ""
           password = ""
           }

$HeadersToken = $null

# Api Call to get access token
$Response = Invoke-RestMethod "https://anypoint.mulesoft.com/accounts/login" -Method Post -Body $Creds -Headers $HeadersToken
$Token = $Response.access_token
Write-Output $Token
#Write-Output $token

$HeadersApi = @{"Authorization"="Bearer $Token"; "X-ANYPNT-ENV-ID"=EnvId}

$GetApi = Invoke-RestMethod "https://anypoint.mulesoft.com/cloudhub/api/v2/applications" -Method Get -Headers $HeadersApi -ContentType 'application/json' -ErrorAction SilentlyContinue

Write-Output $GetApi


