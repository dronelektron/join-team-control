UseCaseResult UseCase_TeamFull(int client, int team, bool &isTeamFull) {
    if (team < TEAM_ALLIES) {
        return UseCaseResult_Ignored;
    }

    if (UseCase_IsClientHasImmunity(client)) {
        isTeamFull = false;

        return UseCaseResult_Handled;
    }

    int clientsCount = GetTeamClientCount(team);
    int clientsLimit = team == TEAM_ALLIES ? Variable_AlliesLimit() : Variable_AxisLimit();

    isTeamFull = clientsCount >= clientsLimit;

    return UseCaseResult_Handled;
}

UseCaseResult UseCase_TeamStacked(int client, bool &isTeamStacked) {
    if (UseCase_IsClientHasImmunity(client)) {
        isTeamStacked = false;

        return UseCaseResult_Handled;
    }

    return UseCaseResult_Ignored;
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
