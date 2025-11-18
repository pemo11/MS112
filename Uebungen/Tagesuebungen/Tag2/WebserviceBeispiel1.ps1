<#
 .SYNOPSIS
 Webservice-Aufruf mit Invoke-WebRequest
#>

$url = "https://nanoquiz-backend-woe2w.ondigitalocean.app/api"

$response = Invoke-WebRequest -Uri $url -Method Get -AllowInsecureRedirect
$response.Content

$url = "https://nanoquiz-backend-woe2w.ondigitalocean.app/api/flashcards"

$response = Invoke-WebRequest -Uri $url -Method Get -AllowInsecureRedirect
$response.Content