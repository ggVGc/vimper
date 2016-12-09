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
ClearFxChainCurrentTrack = externalAction('_S&M_CLRFXCHAIN3')
ClearFxChainInputCurrentTrack = externalAction('_S&M_CLR_INFXCHAIN')
BackOneBeat = 41045
ForwardOneBeat = 41044
SplitItem = 40757
DeleteItem = 40006
DelteActiveTake = 40129
NextTake = 40125
PrevTake = 40126
ToggleLoop = 1068
ToggleMetronome = 40364
ToggleViewMixer = 40078
ToggleRecording = 1013
CopyTrack = 40210
PasteTrack = 40058
CopyItem = 40698
PasteItem = 40058
CutItem = 40699
GrowItemLeft = 40225
GrowItemRight = 40228
ShrinkItemLeft = 40226
ShrinkItemRight = 40228
MoveItemLeftToEditCursor = 41306
MoveItemRightToEditCursor = 41307
TrimItemLeftToEditCursor = 41305
TrimItemRightToEditCursor = 41311
SetLoopPointsToItem = 41039
SM_FloatFirstFxCurrentTrack= externalAction('_S&M_FLOATFX1')
SWS_RenameCurrentTrack = externalAction('_XENAKIOS_RENAMETRAXDLG')
SelectFxCurrentTrack_1 = externalAction('_S&M_SELFX1')
SelectFxCurrentTrack_2 = externalAction('_S&M_SELFX2')
SelectFxCurrentTrack_3 = externalAction('_S&M_SELFX3')
SelectFxCurrentTrack_4 = externalAction('_S&M_SELFX4')
SelectFxCurrentTrack_5 = externalAction('_S&M_SELFX5')
SelectFxCurrentTrack_6 = externalAction('_S&M_SELFX6')
SelectFxCurrentTrack_7 = externalAction('_S&M_SELFX7')
SelectFxCurrentTrack_8 = externalAction('_S&M_SELFX8')
CycleTrackFolderState = 1041
SetTrackMidiAllChannels = externalAction('_S&M_MIDI_INPUT_ALL_CH')
SetTrackMidiChannel_1 = externalAction('_S&M_MIDI_INPUT_CH1')
SetTrackMidiChannel_2 = externalAction('_S&M_MIDI_INPUT_CH2')
SetTrackMidiChannel_3 = externalAction('_S&M_MIDI_INPUT_CH3')
SetTrackMidiChannel_4 = externalAction('_S&M_MIDI_INPUT_CH4')
SetTrackMidiChannel_5 = externalAction('_S&M_MIDI_INPUT_CH5')
SetTrackMidiChannel_6 = externalAction('_S&M_MIDI_INPUT_CH6')
SetTrackMidiChannel_7 = externalAction('_S&M_MIDI_INPUT_CH7')
SetTrackMidiChannel_8 = externalAction('_S&M_MIDI_INPUT_CH8')
SetTrackMidiChannel_9 = externalAction('_S&M_MIDI_INPUT_CH9')
SetTrackMidiChannel_10 = externalAction('_S&M_MIDI_INPUT_CH10')
SetTrackMidiChannel_11 = externalAction('_S&M_MIDI_INPUT_CH11')
SetTrackMidiChannel_12 = externalAction('_S&M_MIDI_INPUT_CH12')
SetTrackMidiChannel_13 = externalAction('_S&M_MIDI_INPUT_CH13')
SetTrackMidiChannel_14 = externalAction('_S&M_MIDI_INPUT_CH14')
SetTrackMidiChannel_15 = externalAction('_S&M_MIDI_INPUT_CH15')
SetTrackMidiChannel_16 = externalAction('_S&M_MIDI_INPUT_CH16')
SetTrackRecordMode_Input = 40496
SetTrackRecordMode_MidiOutput = 40500
SetTrackRecordMode_MidiOverdub= 40503
SetTrackRecordMode_MidiTouchReplace = 40852
SetTrackRecordMode_MidiReplace = 40504
IncreaseBPM = 41129
DecreaseBPM = 41130
-- SetTrackInput_Mono =    

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

function _doRunAction(count, args)
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
end


function runActionWithCount(count, ...)
  local args = table.pack(...)
  return function()
    return _doRunAction(count, args)
  end
end



function runAction(...)
  local args = table.pack(...)
  return defCount(1, function(count)
    _doRunAction(count, args)
  end)
end


function noStore(f)
  return function(count)
    f(count)
    return DO_NOT_STORE_LAST
  end
end


SetLoop = defCount(1, function(count)
  runAction(SetLoopStart)(1)
  runAction(ForwardOneBeat)(4*count)
  runAction(SetLoopEnd)(1)
  runAction(BackOneBeat)(4*count)
end)


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


