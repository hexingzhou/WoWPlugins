--[[
- Events: STATUS, PLAYER_ENTERING_WORLD, PLAYER_REGEN_ENABLED, PLAYER_REGEN_DISABLED, PLAYER_TARGET_CHANGED, PLAYER_ALIVE, PLAYER_DEAD, PLAYER_UNGHOST, BARBER_SHOP_OPEN, BARBER_SHOP_CLOSE, PLAYER_MOUNT_DISPLAY_CHANGED, UPDATE_BONUS_ACTIONBAR, UPDATE_VEHICLE_ACTIONBAR, UPDATE_OVERRIDE_ACTIONBAR, HWA_UPDATE, HWA_ALPHA
--]]
function(states, event, ...)
    local env = aura_env or {}
    
    if not env.parentFrame and env.parent then
        env.parentFrame = WeakAuras.GetRegion(env.parent)
    end

    local frame = env.parentFrame

    if frame then
        local config = env.config and env.config.alpha or {}
        local alpha = config.global or 100

        if WeakAuras.IsOptionsOpen() then
            frame:SetAlpha(1)
        elseif "BARBER_SHOP_OPEN" == event then
            frame:SetAlpha(0)
        elseif "HWA_ALPHA" == event then
            if not UnitAffectingCombat("player") then
                alpha = min(alpha, config.out_of_combat or 35)
            end

            local class = UnitClassBase("player")
            local isMounted = IsMounted() or ("DRUID" == class and tContains({ 3, 4, 27, 29 }, GetShapeshiftFormID()))
            local isSkyriding = WeakAuras.IsRetail() and isMounted and select(2, C_PlayerInfo.GetGlidingInfo())
            local isPetBattle = C_PetBattles.IsInBattle()
            local isVehicle = UnitInVehicle("player") or UnitOnTaxi("player")
            local isVehicleUI = UnitHasVehicleUI("player") or HasOverrideActionBar() or HasVehicleActionBar()

            if isSkyriding or (isMounted and not config.skyriding_only) then
                alpha = min(alpha, config.mounted or 0)
            elseif isPetBattle then
                alpha = min(alpha, config.in_pet_battle or 0)
            elseif isVehicle or isVehicleUI then
                alpha = min(alpha, config.in_vehicle or 0)
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
    end
end
