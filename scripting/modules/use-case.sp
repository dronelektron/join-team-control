bool UseCase_IsTeamFull(int client, int team) {
    if (team < TEAM_ALLIES) {
        return false;
    }

    if (UseCase_IsClientHasImmunity(client)) {
        return false;
    }

    int limit = team == TEAM_ALLIES ? Variable_AlliesLimit() : Variable_AxisLimit();

    if (limit == NO_LIMIT) {
        return false;
    }

    int count = GetTeamClientCount(team);

    return count >= limit;
}

bool UseCase_IsTeamStacked(int client, int newTeam, int currentTeam) {
    if (newTeam == currentTeam || UseCase_IsClientHasImmunity(client)) {
        return false;
    }

    return true;
}

bool UseCase_IsClientHasImmunity(int client) {
    AdminId adminId = GetUserAdmin(client);

    if (adminId == INVALID_ADMIN_ID) {
        return false;
    }

    int adminFlags = GetAdminFlags(adminId, Access_Effective);
    int immunityFlags = Variable_ImmunityFlags();

    return (adminFlags & immunityFlags) > 0;
}
