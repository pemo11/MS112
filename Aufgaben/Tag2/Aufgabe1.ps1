<#
 .SYNOPSIS
 Umsetzung der Aufgabe 1 von Tag 2
#>
using module .\Flashcard.psm1

function Get-Flashcard
{
    $Url = "https://nanoquiz-backend-woe2w.ondigitalocean.app/api/flashcards"
    $Response = Invoke-RestMethod -Uri $Url 
    $Response.flashcards | ForEach-Object {
        [Flashcard]::new($_.id, $_.title, $_.description)
    }
}

Get-Flashcard