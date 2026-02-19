# ============================================
# Cortex QA Protocol Structure Normalization
# ============================================

Write-Host "Starting protocol normalization..."

$root = Get-Location
$corePath = Join-Path $root "protocols\core"
$protocolsPath = Join-Path $root "protocols"

# Ensure core folder exists
if (!(Test-Path $corePath)) {
    New-Item -ItemType Directory -Path $corePath | Out-Null
    Write-Host "Created /protocols/core"
}

# Files at root of /protocols to move
$filesToMove = @(
    "FEATURE_FLAG_TESTING_PROTOCOL.md",
    "MSSP_VALIDATION_PROTOCOL.md",
    "ROLLBACK_VALIDATION_PROTOCOL.md",
    "BACKEND_TAMPER_RECOVERY_PROTOCOL.md"
)

foreach ($file in $filesToMove) {
    $source = Join-Path $protocolsPath $file
    if (Test-Path $source) {
        Move-Item $source $corePath -Force
        Write-Host "Moved $file to /protocols/core"
    }
}

# Handle duplicate PAPI protocol
$rootPapi = Join-Path $protocolsPath "PAPI_VALIDATION_PROTOCOL.md"
$corePapi = Join-Path $corePath "PAPI_VALIDATION_PROTOCOL.md"

if ((Test-Path $rootPapi) -and (Test-Path $corePapi)) {
    Rename-Item $rootPapi "PAPI_VALIDATION_PROTOCOL.legacy.md"
    Write-Host "Renamed duplicate root PAPI protocol to .legacy"
}

# If BACKEND_TAMPER_RECOVERY and BACKEND_INTEGRITY both exist
$coreBackendIntegrity = Join-Path $corePath "BACKEND_INTEGRITY_PROTOCOL.md"
$coreBackendTamper = Join-Path $corePath "BACKEND_TAMPER_RECOVERY_PROTOCOL.md"

if ((Test-Path $coreBackendIntegrity) -and (Test-Path $coreBackendTamper)) {
    Rename-Item $coreBackendTamper "BACKEND_TAMPER_RECOVERY_PROTOCOL.legacy.md"
    Write-Host "Renamed BACKEND_TAMPER_RECOVERY_PROTOCOL to .legacy"
}

Write-Host "Normalization complete."
Write-Host "Review changes, then run:"
Write-Host "git add ."
Write-Host "git commit -m `"Normalize protocol hierarchy`""
Write-Host "git push"
