function include(path)
  local info = debug.getinfo(1,'S');
  script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
  return dofile(script_path .. path .. '.lua')
end


local timeOut = 2

local stateFile="/tmp/reaper_mapper_state"
local timeFile="/tmp/reaper_mapper_last_time"


local log = function(msg) reaper.ShowConsoleMsg(msg .. '\n') end
local clearLog = reaper.ClearConsole



function withFile(path, mode, fun)
  local f = io.open(path, mode)
  local ret
  if f then
    ret = fun(f)
    f:close()
  end
  return ret
end

function clearState()
  withFile(stateFile, 'w', function(f)
    f:write('')
  end)
end

function updateState(ch)
  withFile(stateFile, 'a', function(f)
    f:write(ch)
  end)
end

function getState()
  return withFile(stateFile, 'r', function(f)
    return f:read()
  end)
end

function tryTriggerAction(actions, curInput, count)
  actionFun = actions[curInput]
  if actionFun then
    actionFun(count)
    return true
  else
    return false
  end
end

function updateLastTime(t)
  withFile(timeFile, 'w', function(f)
    f:write(t)
  end)
end

function getLastTime(t)
  return withFile(timeFile, 'r', function(f)
    return f:read()
  end)
end

function timeoutState()
  local curTime = os.time()
  local lastTime = getLastTime() or 0
  updateLastTime(curTime)
  if curTime - lastTime >= timeOut then
    clearState()
  end
end


function longestTableKeyLen(t)
  local longestLen = 0
  for k,_ in pairs(t) do
    local l = string.len(k)
    if l > longestLen then
      longestLen = l
    end
  end
  return longestLen
end

-- Replaces all instances of special keys, e.g <space>, with a single character
function shortenSpecial(str)
  return string.gsub(str, '<.->', '_')
end

function shortenKeys(t)
  return mapTableKeys(t, function(k)
    return shortenSpecial(k)
  end)
end

function stripNumbers(str)
  return string.gsub(str, '%d', '')
end

function getCount(str)
  local count = 0
  for d in str:gmatch '%d' do
    count = count*10 + tonumber(d)
  end
  return count
end



function tooLong(actions, query)
  return longestTableKeyLen(shortenKeys(actions)) <= string.len(shortenSpecial(query))
end

function doInput(ch)
  timeoutState()
  local st = getState() or ''
  local actions = include('bindings')
  local originalQuery = st .. ch
  local curCount = getCount(shortenSpecial(originalQuery))
  local query =  stripNumbers(originalQuery)
  -- log(query .. " | " .. ch)
  if ch == "<esc>" or tryTriggerAction(actions, query, curCount) or tooLong(actions, query) then
    -- log 'clearState'
    clearState()
  else
    updateState(ch)
  end
end



function mapTableKeys(t, f)
  local out = {}
  for k, v in pairs(t) do
    local newK = f(k, v)
    out[newK] = v
  end

  return out
end

--[[


function filterTable(t, filterIter)
  local out = {}
  for k, v in pairs(t) do
    if filterIter(v, k, t) then out[k] = v end
  end
  return out
end

function tableLen(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end

function firstTableValue(t)
  local retK, retV
  for k,v in pairs(t) do
    retK, retV = k,v
  end
  return retK, retV
end

function strAt(str, ind)
  return string.sub(str, ind, ind)
end

function filterActions(acts, char)
  local newActs = filterTable(acts, function(v, k)
    return strAt(k, 1) == char
  end)

  return mapTableKeys(newActs, function(k)
    return string.sub(k, 2, -1)
  end)
end

--]]
