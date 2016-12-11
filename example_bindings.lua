
--[[
Special keys:
  <space>
  <ctrl>
  <alt>
  <mod> (windows key)
--]]
mainBindings = {
  ['.'] = Core.repeatLastAction

  ,['<ctrl>a'] = runAction(ShowActionList)
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


  ,a = noStore(runAction(PrevMeasure))
  ,['<alt>a'] = noStore(times(4, runAction(PrevMeasure)))
  ,d = noStore(runAction(NextMeasure))
  ,['<alt>d'] = noStore(times(4, runAction(NextMeasure)))

  ,q = noStore(runAction(BackOneBeat))
  ,e = noStore(runAction(ForwardOneBeat))

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
  ,ic = runAction(CropToActiveTake)

  ,dd = runAction(DelteActiveTake)
  ,['<'] = noStore(runAction(PrevTake))
  ,['>'] = noStore(runAction(NextTake))

  ,['L'] = runAction(ToggleLoop)
  ,['<space>m'] = runAction(ToggleMetronome)
  ,['<ctrl>m'] = runAction(ToggleViewMixer)
  ,['<bs>'] = runAction(ToggleRecording)


  ,Q = noStore(runAction(ZoomHorizOut))
  ,E = noStore(runAction(ZoomHorizIn))
  -- ,D = runAction(ZoomVertOut)
  -- ,E = runAction(ZoomVertIn)
  ,['<space>z'] = runAction(ZoomProject)
  ,['<ctrl>t'] = runAction(IncreaseBPM)
  ,['<ctrl>T'] = runAction(DecreaseBPM)

  ,z = runAction(SetLoopStart)
  ,x = runAction(SetLoopEnd)

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
  ,['<alt>g<alt>g'] = runAction(SelectFirstTrack, NextTrack, PrevTrack)
  ,['<space>p'] = runAction(SelectParentFolder)

  ,o = chain(Group.Select, runAction(ScrollToSelectedTrack))
  ,tc = runAction(ClearTrackSelection)
  ,['<space>f'] = runAction(ScrollToSelectedTrack)
  ,['<space><space>'] = runAction(ReaConsole_SelectTrack)
  -- ,trim = runActionWithCount(SetTrackInput_Mono)
  -- ,tris = runActionWithCount(SetTrackInput_Stereo)
  ,tf = runAction(CycleTrackFolderState)

  ,['<alt>d'] = runAction(NextItem)
  ,['<alt>a'] = runAction(PrevItem)

  ,l = SetLoop

  ,['§'] = runAction(ExpandSelectedTrackCollapseOthers)
  ,['<alt>§'] = runAction(CollapseAllTracks)
  
  ,r = runAction(ClearAllRecordArm, RecordArmCurrent)
  ,R = runAction(RecordArmCurrent)
  ,['<alt>r'] = runAction(ClearAllRecordArm)
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

  ,u = runAction(Undo)
  ,U = runAction(Redo)

  ,fs = runAction(SelectFxCurrentTrack_1)

  ,['<cr>'] = runAction(Play)

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
  q = MidiEditor.runAction(MidiEditor.CloseWindow)
  ,['§'] = MidiEditor.runAction(MidiEditor.Quantize)
}


return {
  main = mainBindings
  ,midi = midiBindings
}

