static ConVar g_alliesLimit = null;
static ConVar g_axisLimit = null;
static ConVar g_immunityFlags = null;

void Variable_Create() {
    g_alliesLimit = CreateConVar("sm_jointeamcontrol_limit_allies", "-1", "Maximum number (no limit: -1) of players in the Allies team");
    g_axisLimit = CreateConVar("sm_jointeamcontrol_limit_axis", "-1", "Maximum number (no limit: -1) of players in the Axis team");
    g_immunityFlags = CreateConVar("sm_jointeamcontrol_immunity_flags", "b", "Player immunity flags");
}

int Variable_AlliesLimit() {
    return g_alliesLimit.IntValue;
}

int Variable_AxisLimit() {
    return g_axisLimit.IntValue;
}

int Variable_ImmunityFlags() {
    char flags[AdminFlags_TOTAL + 1];

    g_immunityFlags.GetString(flags, sizeof(flags));

    return ReadFlagString(flags);
}
