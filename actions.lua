function externalAction(id)
  return function()
    return  reaper.NamedCommandLookup(id)
  end
end



PrevMarker = 40172
NextMarker = 40173
GoProjectBeginning = 40042
GoProjectEnd = 40043
Play = 40044
ShowActionList = 40605
NextMeasure = 41040
PrevMeasure = 41041
NextItem = 40417
PrevItem = 40416
NextTrack = 40285
PrevTrack = 40286
NextTrackKeepSelection = 40287
PrevTrackKeepSelection = 40288
NewMidiItem = 40214
RemoveTrack = 40005
AddTrack = 40001
SetLoopStart = 40222
SetLoopEnd = 40223
ZoomHorizIn = 1012
ZoomHorizOut = 1011
ZoomVertIn = 40111
ZoomVertOut =  40112
ZoomProject = 40295
SelectItemsInTrack = 40421
ExpandSelectedTrackCollapseOthers = 40723
CollapseAllTracks = 40727
ClearAllRecordArm = 40491
RecordArmCurrent = 9
Undo = 40029
Redo = 40030
OpenMidiEditor = 40153
ToggleFloatingWindows = 41074
ToggleTrackMute = 6
UnmuteAllTracks = 40339
ViewFxChainCurrentTrack = 40291
ViewFxChainMaster = 40846
ViewFxChainInputCurrentTrack = 40844

SM_FloatFirstFxCurrentTrack= externalAction('_S&M_FLOATFX1')
SWS_RenameCurrentTrack = externalAction('_XENAKIOS_RENAMETRAXDLG')


function times(repeatCount, fun)
  return defCount(1, function(count)
    for i=0, repeatCount-1 do
      fun(count)
    end
  end)
end


function requireCount(fun)
  return function(count)
    if count > 0 then
      fun(count)
    end
  end
end

function defCount(default, fun)
  return function(count)
    fun(count > 0 and count or default)
  end
end


function runAction(...)
  local args = table.pack(...)
  local f = defCount(1, function(count)
    reaper.Undo_BeginBlock()
    for i=0, count-1 do
      -- reaper.ShowConsoleMsg('running action: '..id.."\n")
      for _,id in ipairs(args) do
        if type(id) == 'function' then
          id = id()
        end
        reaper.Main_OnCommand(id, 0)
      end
    end
    reaper.Undo_EndBlock('vimper: runAction', 0)
  end)
  return f
end



function noStore(f)
  return function(count)
    f(count)
    return DO_NOT_STORE_LAST
  end
end


Marker = { }

Marker.Go = defCount(1, function(count)
  reaper.GoToMarker(0, count, false)
end)

Marker.Add = defCount(1, function(count)
  reaper.AddProjectMarker(0, false, reaper.GetCursorPosition(), 0, "", -1)
end)

Marker.Delete = requireCount(function(count)
  reaper.DeleteProjectMarker(0, count, false)
end)



function scriptPath()
  local info = debug.getinfo(1,'S');
  return info.source:match[[^@?(.*[\/])[^\/]-$]]
end

function include(path)
  return dofile(scriptPath() .. path .. '.lua')
end


include('state_io')
include('action_codes')

Core = {}
function Core.repeatLastAction()
  clearQuery()
  doInput(getLastAction())
  return DO_NOT_STORE_LAST
end


