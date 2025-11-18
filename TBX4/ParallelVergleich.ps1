<#
 .SYNOPSIS
 Vergleich der Ausführungszeit von sequentieller vs. paralleler Verarbeitung in PowerShell 7+.
#>

#requires -version 7.0

# -----------------------------------------
# Klassen definieren
# -----------------------------------------
class EMail
{
    [string]   $Subject
    [string]   $To
    [string]   $From
    [datetime] $TimeStamp

    EMail([string]$subject, [string]$to, [string]$from, [datetime]$timestamp) {
        $this.Subject   = $subject
        $this.To        = $to
        $this.From      = $from
        $this.TimeStamp = $timestamp
    }
}

class MailServer {
    [string]  $Name
    [EMail[]] $Inbox = @()

    MailServer([string]$name, [EMail[]]$inbox) {
        $this.Name  = $name
        $this.Inbox = $inbox
    }
}

# -----------------------------------------
# Testdaten erzeugen
# -----------------------------------------
function New-RandomEmail
{
    param(
        [string]$ToDomain = "example.com",
        [string[]]$SubjectPool,
        [string]$SpecialSubject = "SPECIAL-REPORT",
        [int]$SpecialProbabilityPercent = 10  # ~10% Mails mit Such-Betreff
    )

    $rnd = Get-Random -Minimum 1 -Maximum 101
    if ($rnd -le $SpecialProbabilityPercent) {
        $subject = $SpecialSubject
    }
    else {
        $subject = Get-Random -InputObject $SubjectPool
    }

    $userTo   = "user{0}@{1}" -f (Get-Random -Minimum 1 -Maximum 500), $ToDomain
    $userFrom = "sender{0}@{1}" -f (Get-Random -Minimum 1 -Maximum 200), $ToDomain
    $time     = (Get-Date).AddMinutes(-1 * (Get-Random -Minimum 0 -Maximum 100000))

    return [EMail]::new($subject, $userTo, $userFrom, $time)
}

function New-MailServerTestData
{
    param(
        [int]$ServerCount      = 1000,
        [int]$MailsPerServer   = 100,
        [string]$SpecialSubject = "SPECIAL-REPORT"
    )

    $subjectPool = @(
        "Newsletter",
        "Daily Report",
        "Rechnung",
        "Meeting Einladung",
        "Statusupdate",
        "Info",
        "Systemmeldung",
        "Reminder"
    )

    $servers = [System.Collections.Generic.List[MailServer]]::new()

    Write-Host "Erzeuge $ServerCount Mailserver mit je $MailsPerServer Mails..."

    for ($i = 1; $i -le $ServerCount; $i++) {
        $inbox = New-Object System.Collections.Generic.List[EMail]

        for ($m = 1; $m -le $MailsPerServer; $m++) {
            $mail = New-RandomEmail -SubjectPool $subjectPool -SpecialSubject $SpecialSubject
            $inbox.Add($mail)
        }

        $serverName = "mailserver-$i"
        $server     = [MailServer]::new($serverName, $inbox.ToArray())
        $servers.Add($server)
    }

    return $servers.ToArray()
}

# -----------------------------------------
# Suche SEQUENTIELL (ohne Parallel)
# -----------------------------------------
function Find-MailSequential
{
    param(
        [MailServer[]]$Servers,
        [string]$Subject,
        [int]$SimulateNetworkDelayMs = 0
    )

    $results = foreach ($server in $Servers) {
        # Simuliere Netzwerk-Latenz (z.B. Verbindung zum Server)
        if ($SimulateNetworkDelayMs -gt 0) {
            Start-Sleep -Milliseconds $SimulateNetworkDelayMs
        }
        
        foreach ($mail in $server.Inbox) {
            if ($mail.Subject -eq $Subject) {
                [PSCustomObject]@{
                    Server    = $server.Name
                    Subject   = $mail.Subject
                    From      = $mail.From
                    To        = $mail.To
                    TimeStamp = $mail.TimeStamp
                }
            }
        }
    }

    return $results
}

# -----------------------------------------
# Suche PARALLEL mit ForEach-Object -Parallel
# -----------------------------------------
function Find-MailParallel 
{
    param(
        [MailServer[]]$Servers,
        [string]$Subject,
        [int]$ThrottleLimit = 8,
        [int]$SimulateNetworkDelayMs = 0
    )

    # Achtung: Im Parallel-Block ist $_ der aktuelle Server
    $Servers | ForEach-Object -Parallel {
        $server = $_
        Write-Warning "Verarbeite Server: $($server.Name)"
        # Simuliere Netzwerk-Latenz (z.B. Verbindung zum Server)
        if ($using:SimulateNetworkDelayMs -gt 0) {
            Start-Sleep -Milliseconds $using:SimulateNetworkDelayMs
        }
        
        foreach ($mail in $server.Inbox) {
            if ($mail.Subject -eq $using:Subject) {
                [PSCustomObject]@{
                    Server    = $server.Name
                    Subject   = $mail.Subject
                    From      = $mail.From
                    To        = $mail.To
                    TimeStamp = $mail.TimeStamp
                }
            }
        }
    } -ThrottleLimit $ThrottleLimit
}

# -----------------------------------------
# Demo / Zeitvergleich
# -----------------------------------------

# 1) Testdaten erstellen
$specialSubject = "SPECIAL-REPORT"
# Weniger Server, aber mit simulierter Netzwerk-Latenz für realistische Demo
$servers        = New-MailServerTestData -ServerCount 50 -MailsPerServer 100 -SpecialSubject $specialSubject
$networkDelay   = 50  # 50ms Latenz pro Server (simuliert echte Netzwerkverbindung)

Write-Host "Testdaten fertig. ($($servers.Count) Server)`n" -ForegroundColor Green

# 2) Sequentielle Suche messen
Write-Host "Starte sequentielle Suche (mit simulierter Netzwerk-Latenz)..." -ForegroundColor Yellow
$seqTime = Measure-Command {
    $seqResults = Find-MailSequential -Servers $servers -Subject $specialSubject -SimulateNetworkDelayMs $networkDelay
}
Write-Host "Sequentielle Suche fertig.`n" -ForegroundColor Green

# 3) Parallele Suche messen
Write-Host "Starte parallele Suche (mit simulierter Netzwerk-Latenz)..." -ForegroundColor Yellow
$parTime = Measure-Command {
    $parResults = Find-MailParallel -Servers $servers -Subject $specialSubject -ThrottleLimit 8 -SimulateNetworkDelayMs $networkDelay 
}
Write-Host "Parallele Suche fertig.`n" -ForegroundColor Green

# 4) Vergleich ausgeben
Write-Host "----------- Ergebnisvergleich -----------"
Write-Host ("Treffer (sequentiell): {0}" -f $seqResults.Count)
Write-Host ("Treffer (parallel)   : {0}" -f $parResults.Count)
Write-Host ("Zeit sequentiell     : {0:N3} Sekunden" -f $seqTime.TotalSeconds)
Write-Host ("Zeit parallel        : {0:N3} Sekunden" -f $parTime.TotalSeconds)
$speedup = $seqTime.TotalSeconds / $parTime.TotalSeconds
Write-Host ("Speedup              : {0:N2}x schneller" -f $speedup) -ForegroundColor Cyan
Write-Host "------------------------------------------"

# 5) ThrottleLimit-Vergleich
Write-Host "`n----------- ThrottleLimit Vergleich -----------" -ForegroundColor Yellow
Write-Host "Teste verschiedene ThrottleLimit-Werte...`n"

$throttleLimits = @(1, 2, 4, 8, 16, 25)
$results = foreach ($limit in $throttleLimits) {
    $time = Measure-Command {
        $null = Find-MailParallel -Servers $servers -Subject $specialSubject -ThrottleLimit $limit -SimulateNetworkDelayMs $networkDelay
    }
    
    [PSCustomObject]@{
        ThrottleLimit = $limit
        Zeit_Sekunden = [math]::Round($time.TotalSeconds, 3)
        Speedup       = [math]::Round($seqTime.TotalSeconds / $time.TotalSeconds, 2)
    }
}

$results | Format-Table -AutoSize
Write-Host "-----------------------------------------------" -ForegroundColor Yellow