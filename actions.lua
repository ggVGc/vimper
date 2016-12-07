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
ClearAllRecordArm = 40491
RecordArmCurrent = 9
Undo = 40029
Redo = 40030
OpenMidiEditor = 40153

SWS_RenameCurrentTrack = externalAction('_XENAKIOS_RENAMETRAXDLG')


function rep(repeatCount, fun)
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
  return defCount(1, function(count)
    for i=0, count-1 do
      -- reaper.ShowConsoleMsg('running action: '..id.."\n")
      for _,id in ipairs(args) do
        if type(id) == 'function' then
          id = id()
        end
        reaper.Main_OnCommand(id, 0)
      end
    end
  end)
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


