
--[[
Special keys:
  <space>
  <ctrl>
  <alt>
  <mod> (windows key)
--]]

globalBindings = {
  ['<cr>'] = runAction(Play)
  ,['<bs>'] = runAction(ToggleRecording)
  ,['<ctrl>a'] = runAction(ShowActionList)
  ,u = runAction(Undo)
  ,U = runAction(Redo)
}

mainBindings = {
  ['.'] = Core.repeatLastAction

  ,mg = Marker.Go
  ,ma = Marker.Add
  ,md = Marker.Delete
  ,mn = runAction(NextMarker)
  ,mN = runAction(PrevMarker)
  ,gg = runAction(GoProjectBeginning)
  ,G = runAction(GoProjectEnd)
  ,['<space>n'] = runAction(NewMidiItem, PrevItem)
  
  ,w = noStore(runAction(PrevTrack, SelectItemsInTrack))
  ,s = noStore(runAction(NextTrack, SelectItemsInTrack))
  ,['<ctrl>w'] = noStore(runAction(PrevTrackKeepSelection))
  ,['<ctrl>s'] = noStore(runAction(NextTrackKeepSelection))
  ,['<alt>w'] = noStore(runAction(PrevFolder))
  ,['<alt>s'] = noStore(runAction(NextFolder))


  ,q = noStore(runAction(PrevMeasure))
  ,['<alt>a'] = noStore(times(4, runAction(PrevMeasure)))
  ,e = noStore(runAction(NextMeasure))
  ,['<alt>d'] = noStore(times(4, runAction(NextMeasure)))

  ,['<alt>q'] = noStore(runAction(BackOneBeat))
  ,['<alt>e'] = noStore(runAction(ForwardOneBeat))

  ,iy = runAction(CopyItem)
  ,ip = runAction(PasteItem)
  ,is = runAction(SplitItem, PrevItem, NextItem)
  ,id = runAction(CopyItem, DeleteItem)
  ,ix = runAction(CutItem)
  ,il = runAction(SetLoopPointsToItem)
  -- ,ig = runAction(GrowItemRight)
  -- ,iG = runAction(GrowItemLeft)
  -- ,is = runAction(ShrinkItemRight)
  -- ,iS = runAction(ShrinkItemLeft)
  ,iZ = runAction(MoveItemLeftToEditCursor)
  ,iX = runAction(MoveItemRightToEditCursor)
  ,iz = runAction(TrimItemLeftToEditCursor)
  ,ix = runAction(TrimItemRightToEditCursor)

  ,['\\'] = runAction(DelteActiveTake)
  ,['['] = noStore(runAction(PrevTake))
  ,[']'] = noStore(runAction(NextTake))
  ,['|'] = runAction(CropToActiveTake)

  ,['L'] = runAction(ToggleLoop)
  ,['<space>m'] = runAction(ToggleMetronome)
  ,['<ctrl>m'] = runAction(ToggleViewMixer)


  ,Q = noStore(runAction(ZoomHorizOut))
  ,E = noStore(runAction(ZoomHorizIn))
  -- ,D = runAction(ZoomVertOut)
  -- ,E = runAction(ZoomVertIn)
  ,['<space>z'] = runAction(ZoomProject)
  ,['<ctrl>t'] = runAction(IncreaseBPM)
  ,['<ctrl>T'] = runAction(DecreaseBPM)


  ,['`'] = runAction(MaximizeTrack)

  ,['-'] = runAction(SetLoopStart)
  ,['='] = runAction(SetLoopEnd)

  ,td = runAction(CopyTrack, RemoveTrack, PrevTrack, NextTrack)
  ,tn = runAction(AddTrack)
  ,ty = runAction(CopyTrack)
  ,tp = runAction(PasteTrack)
  ,tP = runAction(PrevTrack, PasteTrack)
  ,tm = runAction(SetTrackMidiAllChannels)
  ,tz = runAction(CopyTrack, PasteTrack)
  ,tZ = runAction(CopyTrack, PrevTrack, PasteTrack)
  ,tl = runAction(IncreaseTrackHeight)
  ,tL = runAction(DecreaseTrackHeight)
  ,tS = runAction(SelectAllTracks)
  ,['<space>g'] = runAction(SelectFirstTrack, NextTrack, PrevTrack)
  ,['<space>p'] = runAction(SelectParentFolder)

  ,['<space>-'] = runAction(GoToLoopStart)
  ,['<space>='] = runAction(GoToLoopEnd)

  ,o = chain(Group.Select, runAction(ScrollToSelectedTrack))
  ,tc = runAction(ClearTrackSelection)
  ,['<space>f'] = runAction(ScrollToSelectedTrack)
  ,['<space><space>'] = runAction(ReaConsole_SelectTrack)
  -- ,trim = runActionWithCount(SetTrackInput_Mono)
  -- ,tris = runActionWithCount(SetTrackInput_Stereo)
  ,tf = runAction(CycleTrackFolderState)

  ,k = runAction(NextItem)
  ,j = runAction(PrevItem)

  ,l = SetLoop

  ,['§'] = runAction(ExpandSelectedTrackCollapseOthers)
  ,['<space>§'] = runAction(CollapseAllTracks)
  
  ,r = runAction(ClearAllRecordArm, RecordArmCurrent)
  ,R = runAction(RecordArmCurrent)
  ,['<space>r'] = runAction(ClearAllRecordArm)
  ,['<space>R'] = runAction(SWS_RenameCurrentTrack)

  ,['<space>e'] = runAction(OpenMidiEditor)

  ,['<space>q'] = runAction(ToggleFloatingWindows)

  ,m = runAction(ToggleTrackMute)
  ,M = runAction(UnmuteAllTracks)

  ,fx = runAction(ViewFxChainCurrentTrack)
  ,fX = runAction(ClearFxChainCurrentTrack)
  ,fi = runAction(ViewFxChainInputCurrentTrack)
  ,fI = runAction(ClearFxChainInputCurrentTrack)
  ,fm = runAction(ViewFxChainMaster)
  ,ff = runAction(ClearAllRecordArm, RecordArmCurrent, SM_FloatFirstFxCurrentTrack)


  ,fs = runAction(SelectFxCurrentTrack_1)

  ,['<space><cr>'] = runAction(SaveProject)
  ,['<space>c'] = runAction(ReaConsole)
  
  ,['<space>t'] = runAction(ShowTrackManager)

  ,['<num1>'] = runAction(TrackView.Load_1)
  ,['<num2>'] = runAction(TrackView.Load_2)
  ,['<num3>'] = runAction(TrackView.Load_3)
  ,['<num4>'] = runAction(TrackView.Load_4)
  ,['<num5>'] = runAction(TrackView.Load_5)
  ,['<num6>'] = runAction(TrackView.Load_6)
  ,['<num7>'] = runAction(TrackView.Load_7)
  ,['<num8>'] = runAction(TrackView.Load_8)
  ,['<num9>'] = runAction(TrackView.Load_9)
  ,['<num0>'] = runAction(TrackView.Load_10)

  ,['<alt><num1>'] = runAction(WindowSet.Load_1)
  ,['<alt><num2>'] = runAction(WindowSet.Load_2)
  ,['<alt><num3>'] = runAction(WindowSet.Load_3)
  ,['<alt><num4>'] = runAction(WindowSet.Load_4)
  ,['<alt><num5>'] = runAction(WindowSet.Load_5)
  ,['<alt><num6>'] = runAction(WindowSet.Load_6)
  ,['<alt><num7>'] = runAction(WindowSet.Load_7)
  ,['<alt><num8>'] = runAction(WindowSet.Load_8)
  ,['<alt><num9>'] = runAction(WindowSet.Load_9)
  ,['<alt><num0>'] = runAction(WindowSet.Load_10)


}

midiBindings = {
  -- q = MidiEditor.runAction(MidiEditor.CloseWindow)
  ['§'] = MidiEditor.runAction(MidiEditor.Quantize)
  ,n = MidiEditor.runAction(MidiEditor.InsertNote)
  ,['<alt>e'] = MidiEditor.runAction(MidiEditor.SelectNextNote)
  ,['<alt>q'] = MidiEditor.runAction(MidiEditor.SelectPrevNote)
  ,['e'] = MidiEditor.runAction(MidiEditor.SelectNextNote_SamePitch)
  ,['q'] = MidiEditor.runAction(MidiEditor.SelectPrevNote_SamePitch)
  ,w = MidiEditor.runAction(MidiEditor.PitchCursorUp)
  ,s = MidiEditor.runAction(MidiEditor.PitchCursorDown)
  ,['<alt>w'] = MidiEditor.runAction(MidiEditor.PitchCursorUp_Octave)
  ,['<alt>s'] = MidiEditor.runAction(MidiEditor.PitchCursorDown_Octave)
  ,gg = MidiEditor.runAction(MidiEditor.GoToStart)
  ,G = MidiEditor.runAction(MidiEditor.GoToEnd)
  ,d = MidiEditor.runAction(MidiEditor.EditCursorRight)
  ,a = MidiEditor.runAction(MidiEditor.EditCursorLeft)
  -- ,['<alt>e'] = MidiEditor.runAction(MidiEditor.EditCursorRight_Measure)
  -- ,['<alt>q'] = MidiEditor.runAction(MidiEditor.EditCursorLeft_Measure)
  ,['='] = MidiEditor.runAction(MidiEditor.DoubleGridSize)
  ,['+'] = MidiEditor.runAction(MidiEditor.HalfGridSize)
  ,['<alt>a'] = MidiEditor.runAction(MidiEditor.AddNearestNoteToSelection)
  ,c = MidiEditor.runAction(MidiEditor.ClearNoteSelection)
  ,['['] = MidiEditor.runAction(MidiEditor.MoveNoteUp_Semitone)
  ,[']'] = MidiEditor.runAction(MidiEditor.MoveNoteDown_Semitone)
  ,['{'] = MidiEditor.runAction(MidiEditor.MoveNoteUp_Octave)
  ,['}'] = MidiEditor.runAction(MidiEditor.MoveNoteDown_Octave)
  ,v = MidiEditor.runAction(MidiEditor.SelectAllNotesAtPitchCursor)
  ,['x'] = MidiEditor.runAction(MidiEditor.MoveNoteRight)
  ,['z'] = MidiEditor.runAction(MidiEditor.MoveNoteLeft)
  ,['<alt>d'] = MidiEditor.runAction(MidiEditor.DeleteNote)
  ,b = MidiEditor.runAction(MidiEditor.EditCursorToSelectedEvent)
  ,['<alt>x'] = MidiEditor.runAction(MidiEditor.ZoomIn_Horiz)
  ,['<alt>z'] = MidiEditor.runAction(MidiEditor.ZoomOut_Horiz)
  ,['X'] = MidiEditor.runAction(MidiEditor.ZoomIn_Vert)
  ,['Z'] = MidiEditor.runAction(MidiEditor.ZoomOut_Vert)

  ,['<num1>'] = MidiEditor.runAction(MidiEditor.SetNoteLength_128)
  ,['<num2>'] = MidiEditor.runAction(MidiEditor.SetNoteLength_64)
  ,['<num3>'] = MidiEditor.runAction(MidiEditor.SetNoteLength_32)
  ,['<num4>'] = MidiEditor.runAction(MidiEditor.SetNoteLength_16)
  ,['<num5>'] = MidiEditor.runAction(MidiEditor.SetNoteLength_8)
  ,['<num6>'] = MidiEditor.runAction(MidiEditor.SetNoteLength_4)
  ,['<num7>'] = MidiEditor.runAction(MidiEditor.SetNoteLength_2)
  ,['<num8>'] = MidiEditor.runAction(MidiEditor.SetNoteLength_1)
}


return {
  global = globalBindings
  ,main = mainBindings
  ,midi = midiBindings
}

