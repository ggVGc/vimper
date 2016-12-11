
-- local log = function(msg) reaper.ShowConsoleMsg(msg .. '\n') end
local log = function(msg) end

local msg = function(msg) reaper.ShowConsoleMsg("[Vimper] ".. msg .. '\n') end

local clearLog = reaper.ClearConsole

local bindingsPath = reaper.GetResourcePath() .. '/vimper_bindings.lua'
local timeOut = 2

function scriptPath()
  local info = debug.getinfo(1,'S');
  return info.source:match[[^@?(.*[\/])[^\/]-$]]
end

function include(path)
  return dofile(scriptPath() .. path .. '.lua')
end


include('state_io')
include('action_codes')

function mergeInclude(...)
  local tmp = scriptPath() .. "tmp_actions"
  local args = table.pack(...)
  local fail = false
  withFile(tmp, 'w', function(f)
    for _,v in ipairs(args) do
      local content = readFile(v)
      if content == nil then
          msg("File missing: " .. v)
          fail = true
        else
          f:write(content)
      end
    end
  end)
  if fail then
    return {}
  else
    return dofile(tmp)
  end
end


function tryTriggerAction(actions, curInput, count)
  actionFun = actions[curInput]
  if actionFun then
    local ret = actionFun(count)
    return ret or true
  else
    return false
  end
end


function timeoutState()
  local curTime = os.time()
  local lastTime = getLastTime() or 0
  updateLastTime(curTime)
  if curTime - lastTime >= timeOut then
    clearQuery()
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


function mapTableKeys(t, f)
  local out = {}
  for k, v in pairs(t) do
    local newK = f(k, v)
    out[newK] = v
  end

  return out
end


function shortenKeys(t)
  return mapTableKeys(t, function(k)
    return shortenSpecial(k)
  end)
end


function stripNumbers(str)
  -- return string.gsub(str, '%d', '')
  return str:gsub("[0-9]*(.-)$", "%1")
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


function doInput(ch, context)
  timeoutState()
  local st = getQuery() or ''
  local allActions = mergeInclude(scriptPath()..'actions.lua', bindingsPath)
  local actions = allActions.global
  for k,v in pairs(allActions[context]) do actions[k] = v end

  local originalQuery = st .. ch
  local curCount = getCount(shortenSpecial(originalQuery))
  local query =  stripNumbers(originalQuery)
  log(query .. " | " .. ch)
  local actionRet = tryTriggerAction(actions, query, curCount)
  log(context)
  if actionRet and actionRet ~= DO_NOT_STORE_LAST then
    setLastAction(originalQuery)
    setLastContext(context)
  end

  if ch == "<esc>" or actionRet or tooLong(actions, query) then
    log 'clearQuery'
    clearQuery()
  else
    updateQuery(ch)
  end
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
