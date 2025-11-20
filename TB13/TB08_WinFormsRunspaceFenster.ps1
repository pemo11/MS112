Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Core

# Gemeinsamer, threadsicherer Status
$state = [hashtable]::Synchronized(@{
    Progress  = 0
    Status    = "Bereit."
    IsRunning = $false
    Cancel    = $false
})

# Merker für den letzten IsRunning-Zustand (zur Erkennung "gerade fertig geworden")
$script:lastRunning = $false

#---------------- GUI erstellen ----------------#

$form = New-Object System.Windows.Forms.Form
$form.Text = "Runspace-Async-Demo"
$form.Width = 420
$form.Height = 220
$form.StartPosition = "CenterScreen"

$btnStart = New-Object System.Windows.Forms.Button
$btnStart.Text = "Start"
$btnStart.Location = "20,20"
$btnStart.Width = 80

$btnCancel = New-Object System.Windows.Forms.Button
$btnCancel.Text = "Abbrechen"
$btnCancel.Location = "120,20"
$btnCancel.Width = 80
$btnCancel.Enabled = $false

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = "20,70"
$progressBar.Size = "360,25"
$progressBar.Minimum = 0
$progressBar.Maximum = 100

$lblStatus = New-Object System.Windows.Forms.Label
$lblStatus.Location = "20,110"
$lblStatus.Size = "360,25"
$lblStatus.Text = "Bereit."

$form.Controls.AddRange(@($btnStart, $btnCancel, $progressBar, $lblStatus))

#---------------- Timer für UI-Updates ----------------#

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 100 # ms

$timer.Add_Tick({
    # UI immer aus dem gemeinsamen Status aktualisieren
    $progress = [int]$state.Progress

    if ($progress -lt $progressBar.Minimum) { $progress = $progressBar.Minimum }
    if ($progress -gt $progressBar.Maximum) { $progress = $progressBar.Maximum }

    $progressBar.Value = $progress
    $lblStatus.Text    = $state.Status

    # Prüfen, ob der Hintergrundvorgang gerade fertig geworden ist
    if ($script:lastRunning -and -not $state.IsRunning) {
        # Vorgang beendet (fertig oder abgebrochen) → Buttons wieder in Grundstellung
        $btnStart.Enabled  = $true
        $btnCancel.Enabled = $false
    }

    # Zustand für den nächsten Tick merken
    $script:lastRunning = $state.IsRunning
})

#---------------- Runspace-Logik ----------------#

$workScript = {
    param($sharedState)

    $sharedState.IsRunning = $true
    $sharedState.Status    = "Langer Vorgang läuft..."

    try {
        for ($i = 1; $i -le 100; $i++) {

            # Abbruch gewünscht?
            if ($sharedState.Cancel) {
                # Kein UI-Status mehr setzen – die UI hat sich schon zurückgesetzt
                $sharedState.IsRunning = $false
                return
            }

            # "Arbeit" simulieren
            Start-Sleep -Milliseconds 80

            # Fortschritt aktualisieren
            $sharedState.Progress = $i
            $sharedState.Status   = "Fortschritt: $i %"
        }

        # Normales Ende
        $sharedState.Status = "Fertig."
        $sharedState.Progress = 100
    }
    catch {
        $sharedState.Status = "Fehler: $($_.Exception.Message)"
    }
    finally {
        $sharedState.IsRunning = $false
    }
}

$runspace = $null

#---------------- Button: Start ----------------#

$btnStart.Add_Click({
    if ($state.IsRunning) { return }

    # Status zurücksetzen
    $state.Progress = 0
    $state.Status   = "Starte..."
    $state.Cancel   = $false

    $progressBar.Value = 0
    $lblStatus.Text    = $state.Status

    $btnStart.Enabled  = $false
    $btnCancel.Enabled = $true

    # Runspace erzeugen
    $runspace = [runspacefactory]::CreateRunspace()
    $runspace.ApartmentState = "MTA"
    $runspace.ThreadOptions  = "ReuseThread"
    $runspace.Open()

    $ps = [powershell]::Create().AddScript($workScript).AddArgument($state)
    $ps.Runspace = $runspace

    # Asynchron starten
    [void]$ps.BeginInvoke()
})

#---------------- Button: Abbrechen ----------------#

$btnCancel.Add_Click({
    if (-not $state.IsRunning) { return }

    # Abbruch-Flag für den Runspace setzen
    $state.Cancel = $true

    # Deine gewünschte Reaktion bei Abbruch:
    # Buttons umschalten, Fortschritt auf 0, Label löschen
    $btnStart.Enabled  = $true
    $btnCancel.Enabled = $false

    $state.Progress = 0
    $state.Status   = ""

    $progressBar.Value = 0
    $lblStatus.Text    = ""
})

#---------------- FormClosing: Aufräumen ----------------#

$form.Add_FormClosing({
    $timer.Stop()
    $state.Cancel = $true

    if ($runspace -and $runspace.RunspaceStateInfo.State -eq 'Opened') {
        $runspace.Close()
        $runspace.Dispose()
    }
})

# Timer starten und Formular anzeigen
$timer.Start()
[System.Windows.Forms.Application]::Run($form)
