
--[[
Special keys:
  <space>
  <ctrl>
  <alt>
  <mod> (windows key)
--]]
return {
  ['.'] = Core.repeatLastAction

  ,['<ctrl>a'] = runAction(ShowActionList)
  ,mg = Marker.Go
  ,ma = Marker.Add
  ,md = Marker.Delete
  ,mn = runAction(NextMarker)
  ,mN = runAction(PrevMarker)
  ,gg = runAction(GoProjectBeginning)
  ,G = runAction(GoProjectEnd)
  ,nm = runAction(NewMidiItem, PrevItem)
  
  ,w = noStore(runAction(PrevTrack, SelectItemsInTrack))
  ,s = noStore(runAction(NextTrack, SelectItemsInTrack))
  ,['<alt>w'] = noStore(runAction(PrevTrackKeepSelection))
  ,['<alt>s'] = noStore(runAction(NextTrackKeepSelection))

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
  ,iZ= runAction(MoveItemLeftToEditCursor)
  ,iX = runAction(MoveItemRightToEditCursor)
  ,iz = runAction(TrimItemLeftToEditCursor)
  ,ix = runAction(TrimItemRightToEditCursor)

  ,td = runAction(DelteActiveTake)
  ,['<'] = noStore(runAction(PrevTake))
  ,['>'] = noStore(runAction(NextTake))

  ,['L'] = runAction(ToggleLoop)
  ,['<space>M'] = runAction(ToggleMetronome)
  ,['<ctrl>m'] = runAction(ToggleViewMixer)
  ,['<space>r'] = runAction(ToggleRecording)

  ,Q = noStore(runAction(ZoomHorizOut))
  ,E = noStore(runAction(ZoomHorizIn))
  -- ,D = runAction(ZoomVertOut)
  -- ,E = runAction(ZoomVertIn)
  ,['<space>z'] = runAction(ZoomProject)
  ,['<ctrl>t'] = runAction(IncreaseBPM)
  ,['<ctrl>T'] = runAction(DecreaseBPM)

  ,z = runAction(SetLoopStart)
  ,x = runAction(SetLoopEnd)

  ,trd = runAction(CopyTrack, RemoveTrack, PrevTrack, NextTrack)
  ,trn = runAction(AddTrack)
  ,try = runAction(CopyTrack)
  ,trp = runAction(PasteTrack)
  ,trm = runAction(SetTrackMidiAllChannels)
  -- ,trim = runActionWithCount(SetTrackInput_Mono)
  -- ,tris = runActionWithCount(SetTrackInput_Stereo)
  ,['<space>f'] = runAction(CycleTrackFolderState)

  ,['<alt>d'] = runAction(NextItem)
  ,['<alt>a'] = runAction(PrevItem)

  ,['l'] = SetLoop

  ,c = runAction(ExpandSelectedTrackCollapseOthers)
  ,C = runAction(CollapseAllTracks)
  
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
  ,ff = runAction(SM_FloatFirstFxCurrentTrack)

  ,u = runAction(Undo)
  ,U = runAction(Redo)

  ,fs = runAction(SelectFxCurrentTrack_1)

  ,p = runAction(Play)
}
