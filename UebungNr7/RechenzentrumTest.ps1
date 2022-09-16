<#
 .SYNOPSIS
 Testet Functions aus dem Modul PSRechenzentrum.psm1
#>

using module G:\2022\Trainings\MS112\MS112-Repo\UebungNr7\PSRechenzentrum.psm1
using module G:\2022\Trainings\MS112\MS112-Repo\UebungNr7\Server.psm1

$RS = [PSRechenzentrum]::new()
$RS.NewServer("Server1", "Windows Server 2016")
$RS.NewServer("Server2", "Windows Server 2012R2")

$RS.ServerListe