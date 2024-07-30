-- Define global variables
local ENJOY_VAR_a = nil;
local ENJOY_VAR_b = false;

-- Function to start the game
function startGame(ENJOY_VAR_c, ENJOY_VAR_d, ENJOY_VAR_e, ENJOY_VAR_f)
    -- Check if game is already running, if so, return
    if ENJOY_VAR_b then
        return
    end
    
    -- Set game as running
    ENJOY_VAR_b = true;
    ENJOY_VAR_a = nil;
    
    -- Send a NUI message to start the game
    SendNUIMessage({
        action = 1,
        m = ENJOY_VAR_c,
        s = ENJOY_VAR_d,
        n = ENJOY_VAR_e,
        d = ENJOY_VAR_f
    })
    
    -- Set NUI focus and wait for completion
    SetNuiFocus(true, false)
    while ENJOY_VAR_a == nil do
        Wait(100)
    end
    
    -- Unset NUI focus and get the result
    SetNuiFocus(false, false)
    local ENJOY_VAR_g = ENJOY_VAR_a;
    ENJOY_VAR_a = nil;
    
    -- Set game as not running and return the result
    ENJOY_VAR_b = false;
    return ENJOY_VAR_g
end

-- Callback function when game is completed
RegisterNUICallback('completed', function(ENJOY_VAR_h, ENJOY_VAR_i)
    ENJOY_VAR_a = ENJOY_VAR_h.result;
    ENJOY_VAR_i(true)
end)

-- Command to start the test minigame
RegisterCommand("test-minigame", function(ENJOY_VAR_j, ENJOY_VAR_k)
    print(startGame(tonumber(ENJOY_VAR_k[1]), tonumber(ENJOY_VAR_k[2]), tonumber(ENJOY_VAR_k[3]), tonumber(ENJOY_VAR_k[4])))
end)

-- Export startGame function
exports("startGame", startGame)
