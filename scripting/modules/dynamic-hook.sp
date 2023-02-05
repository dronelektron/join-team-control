static Handle g_joinTeam = null;
static Handle g_teamFull = null;
static Handle g_teamStacked = null;
static int g_joinTeamClient = CLIENT_NOT_FOUND;

void DynamicHook_Create() {
    Handle gameConfig = LoadGameConfigFile(GAME_CONFIG);

    if (gameConfig != null) {
        g_joinTeam = DynamicHook_FromConfig(gameConfig, FUNCTION_JOIN_TEAM);
        g_teamFull = DynamicHook_FromConfig(gameConfig, FUNCTION_TEAM_FULL);
        g_teamStacked = DynamicHook_FromConfig(gameConfig, FUNCTION_TEAM_STACKED);

        DHookEnableDetour(g_joinTeam, POST_NO, DynamicHook_JoinTeam);
        DHookEnableDetour(g_teamFull, POST_NO, DynamicHook_TeamFull);
        DHookEnableDetour(g_teamStacked, POST_NO, DynamicHook_TeamStacked);
        CloseHandle(gameConfig);
    }
}

void DynamicHook_Destroy() {
    DHookDisableDetour(g_joinTeam, POST_NO, DynamicHook_JoinTeam);
    DHookDisableDetour(g_teamFull, POST_NO, DynamicHook_TeamFull);
    DHookDisableDetour(g_teamStacked, POST_NO, DynamicHook_TeamStacked);

    delete g_joinTeam;
    delete g_teamFull;
    delete g_teamStacked;
}

Handle DynamicHook_FromConfig(Handle gameConfig, const char[] functionName) {
    Handle setup = DHookCreateFromConf(gameConfig, functionName);

    if (setup == null) {
        SetFailState("Unable to hook '%s' function", functionName);
    }

    return setup;
}

public MRESReturn DynamicHook_JoinTeam(int pThis) {
    g_joinTeamClient = pThis;

    return MRES_Ignored;
}

public MRESReturn DynamicHook_TeamFull(DHookReturn hReturn, DHookParam hParams) {
    int team = DHookGetParam(hParams, 1);

    if (UseCase_IsTeamFull(g_joinTeamClient, team)) {
        return MRES_Ignored;
    }

    DHookSetReturn(hReturn, false);

    return MRES_Supercede;
}

public MRESReturn DynamicHook_TeamStacked(DHookReturn hReturn, DHookParam hParams) {
    int newTeam = DHookGetParam(hParams, 1);
    int currentTeam = DHookGetParam(hParams, 2);

    if (UseCase_IsTeamStacked(g_joinTeamClient, newTeam, currentTeam)) {
        return MRES_Ignored;
    }

    DHookSetReturn(hReturn, false);

    return MRES_Supercede;
}
