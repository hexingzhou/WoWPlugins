-- Events: PLAYER_ENTERING_WORLD, PLAYER_REGEN_ENABLED, PLAYER_REGEN_DISABLED, PLAYER_TARGET_CHANGED, PLAYER_ALIVE, PLAYER_DEAD, PLAYER_UNGHOST, BARBER_SHOP_OPEN, BARBER_SHOP_CLOSE, OPTIONS, PLAYER_MOUNT_DISPLAY_CHANGED, UPDATE_BONUS_ACTIONBAR, HWA_UPDATE_SHAPESHIFT_FORM, STATUS, HWA_INIT, HWA_ALPHA

function(event, ...)
    if not aura_env.parentFrame and aura_env.parent then
        aura_env.parentFrame = WeakAuras.GetRegion(aura_env.parent)
    end

    local frame = aura_env.parentFrame

    if frame then
        local config = aura_env.config and aura_env.config.alpha or {}
        local alpha = config.global or 100

        if "STATUS" == event or WeakAuras.IsOptionsOpen() then
            frame:SetAlpha(1)
        elseif "BARBER_SHOP_OPEN" == event then
            frame:SetAlpha(0)
        elseif "HWA_ALPHA" == event then
            local class = UnitClassBase("player")
            local isMounted = IsMounted() or ("DRUID" == class and tContains({3, 4, 27, 29}, GetShapeshiftFormID()))
            local isSkyriding = WeakAuras.IsRetail() and isMounted and select(2, C_PlayerInfo.GetGlidingInfo())

            if not UnitAffectingCombat("player") then
                alpha = min(alpha, config.out_of_combat or 35)
            end

            if (isSkyriding or (isMounted and (not config.skyriding_only or (HasBonusActionBar() and (11 == GetBonusBarIndex() or ("EVOKER" == class and 7 == GetBonusBarIndex())))))) then
                alpha = min(alpha, config.mounted or 0)
            else
                if UnitExists("target") then
                    local isEnemy = UnitCanAttack("player", "target") or UnitIsEnemy("player", "target")
                    if (not isEnemy and config.ignore_friendly) or (isEnemy and config.ignore_enemy) then
                        alpha = config.global or 100
                    end
                end
            end

            frame:SetAlpha(alpha / 100)
        else
            C_Timer.After(0.05, function()
                WeakAuras.ScanEvents("HWA_ALPHA")
            end)
        end

        return true
    end
end
