#include "DebugModeHandle.h"

DebugModeHandle::DebugModeHandle() {}

void DebugModeHandle::enableDebugMode() {
    isDebugModeEnabled = true;
    qWarning() << "Uruchomiono tryb debug!";
}
void DebugModeHandle::disableDebugMode() {
    isDebugModeEnabled = false;
    qWarning() << "Wylaczono tryb debug!";
}
bool DebugModeHandle::debugModeStatus() {
    return isDebugModeEnabled;
}
