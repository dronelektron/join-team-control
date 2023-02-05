#include <sourcemod>
#include <dhooks>

#include "jtc/dynamic-hook"
#include "jtc/use-case"

#include "modules/console-variable.sp"
#include "modules/dynamic-hook.sp"
#include "modules/use-case.sp"

#define AUTO_CREATE_YES true

public Plugin myinfo = {
    name = "Join team control",
    author = "Dron-elektron",
    description = "Allows you to control the 'jointeam' command",
    version = "0.1.0",
    url = "https://github.com/dronelektron/join-team-control"
};

public void OnPluginStart() {
    Variable_Create();
    DynamicHook_Create();
    AutoExecConfig(AUTO_CREATE_YES, "join-team-control");
}

public void OnPluginEnd() {
    DynamicHook_Destroy();
}
