function scriptPath()
  local info = debug.getinfo(1,'S');
  return info.source:match[[^@?(.*[\/])[^\/]-$]]
end

local stateDir = scriptPath() .. "/state"
local queryFile = stateDir .. "/query"
local timeFile = stateDir .. "/last_time"
local lastActionFile = stateDir .. "/last_action"

function withFile(path, mode, fun)
  local f = io.open(path, mode)
  local ret
  if f then
    ret = fun(f)
    f:close()
  end
  return ret
end

function setState(file, data, mode)
  mode = mode or "w"
  withFile(file, mode, function(f)
    f:write(data)
  end)
end

function readFile(file)
  return withFile(file, 'r', function(f)
    if f then return 
      f:read('*a')
      else
        return nil
      end
  end)
end


function clearQuery()
  setState(queryFile, '')
end

function updateQuery(ch)
  setState(queryFile, ch, 'a')
end

function getQuery()
  return readFile(queryFile)
end

function updateLastTime(t)
  setState(timeFile, t)
end

function getLastTime(t)
  return readFile(timeFile)
end

function setLastAction(a)
  setState(lastActionFile, a)
end

function getLastAction()
  return readFile(lastActionFile)
end

