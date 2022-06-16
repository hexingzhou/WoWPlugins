if WeakAuras.dynamic_texts.p and WeakAuras.dynamic_texts.p.func then
  WeakAuras.dynamic_texts.p.func = function(state, region)
    if not state then return "" end
    if state.progressType == "static" then
      return state.value or ""
    end
    if state.progressType == "timed" then
      if not state.expirationTime or not state.duration then
        return ""
      end
      local remaining = state.expirationTime - GetTime();
      local duration = state.duration

      local remainingStr = ""
      if remaining == math.huge then
        remainingStr = " "
      elseif remaining > 60 then
        remainingStr = string.format("%i", math.floor(remaining / 60))
        remainingStr = remainingStr.."m"
      elseif remaining > 0 then
        local progressPrecision = region.progressPrecision and math.abs(region.progressPrecision) or 1
        if progressPrecision == 4 and remaining <= 3 then
          remainingStr = remainingStr..string.format("%.1f", remaining)
        elseif progressPrecision == 5 and remaining <= 3 then
          remainingStr = remainingStr..string.format("%.2f", remaining)
        elseif (progressPrecision == 4 or progressPrecision == 5) and remaining > 3 then
          remainingStr = remainingStr..string.format("%d", remaining)
        else
          remainingStr = remainingStr..string.format("%.".. progressPrecision .."f", remaining)
        end
      else
        remainingStr = " "
      end
      return remainingStr
    end
  end
end
