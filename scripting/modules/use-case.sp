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
    int userFlags = GetUserFlagBits(client);
    int immunityFlags = Variable_ImmunityFlags();

    return (userFlags & immunityFlags) > 0;
}
