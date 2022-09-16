<#
 .Synopsis
 Definition der Klasse SpezialServer
#>

# Pfad muss angepasst werden - keine Variable möglich
using module G:\2022\Trainings\MS112\MS112-Repo\UebungNr7\Server.psm1

class SpezialServer : Server
{
    [Int]$Laufzeit
    [System.Timers.Timer]$tmr

    $SBTimerTick = {
        # $Event ist eine automatische Variable, die aber nur im Rahmen eines sog. Event-Handlers zur Verfügung steht
        # Eventhandler = Scriptblock, der als Reaktion auf das Eintreten eines "Events" ausgeführt wird
        $Server = $Event.MessageData
        if ($Server.Status -eq "Running")
        {
            $Server.Laufzeit += 1
        }
    }
    
    SpezialServer([String]$Name,[String]$Description)
    {
        $this.Id = [Guid]::NewGuid().Guid
        $this.Description = $Description
        $this.Name = $Name
        $this.Status = "Stopped"
        $this.tmr = [System.Timers.Timer]::new(1000)
        $this.tmr.Enabled = $true
        # $this.tmr.add_elapsed($this.SBTimerTick)
        Unregister-Event -SourceIdentifier ServerTimer -Force -ErrorAction Ignore
        Register-ObjectEvent -InputObject $this.tmr -EventName Elapsed -Action $this.SBTimerTick `
         -SourceIdentifier ServerTimer -MessageData $this

    }

    [string]ToString()
    {
        return "Name=$($this.Name) ID=$($this.Id) Status=$($this.Status) Laufzeit=$($this.Laufzeit)"
    }

    [bool]Start()
    {
        $this.Status = "Running"
        $this.tmr.Enabled = $true
        Return $true
    }

    [bool]Stop()
    {
        $this.Status = "Stopped"
        $this.tmr.Enabled = $false
        Return $true
    }

}