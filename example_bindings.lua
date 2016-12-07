return {
  ['.'] = Core.repeatLastAction

  ,['<space>a'] = runAction(ShowActionList)
  ,mg = Marker.Go
  ,ma = Marker.Add
  ,md = Marker.Delete
  ,mn = runAction(NextMarker)
  ,mN = runAction(PrevMarker)
  ,gg = runAction(GoProjectBeginning)
  ,G = runAction(GoProjectEnd)
  ,k = noStore(runAction(PrevTrack, SelectItemsInTrack))
  ,j = noStore(runAction(NextTrack, SelectItemsInTrack))
  ,K = noStore(runAction(PrevTrackKeepSelection))
  ,J = noStore(runAction(NextTrackKeepSelection))
  ,nm = noStore(runAction(NewMidiItem))
  
  ,a = noStore(runAction(PrevMeasure))
  ,s = noStore(runAction(NextMeasure))
  ,A = rep(4, runAction(PrevMeasure))
  ,S = rep(4, runAction(NextMeasure))

  ,q = runAction(ZoomHorizOut)
  ,w = runAction(ZoomHorizIn)
  ,Q = runAction(ZoomVertOut)
  ,W = runAction(ZoomVertIn)
  ,pz = runAction(ZoomProject)

  ,z = runAction(SetLoopStart)
  ,x = runAction(SetLoopEnd)

  ,td = withUndo(runAction(RemoveTrack, PrevTrack, NextTrack))
  ,tn = runAction(AddTrack)

  ,l = runAction(NextItem)
  ,h = runAction(PrevItem)

  ,c = runAction(ExpandSelectedTrackCollapseOthers)
  ,C = runAction(CollapseAllTracks)
  
  ,r = runAction(ClearAllRecordArm, RecordArmCurrent)
  ,R = runAction(RecordArmCurrent)
  ,['<space>r'] = runAction(ClearAllRecordArm)
  ,['<space>R'] = runAction(SWS_RenameCurrentTrack)

  ,['<space>e'] = runAction(OpenMidiEditor)

  ,['<space>q'] = runAction(ToggleFloatingWindows)

  ,m = runAction(ToggleTrackMute)
  ,M = runAction(UnmuteAllTracks)

  ,fx = runAction(ViewFxChainCurrentTrack)
  ,fi = runAction(ViewFxChainInputCurrentTrack)
  ,fm = runAction(ViewFxChainMaster)
  ,ff = runAction(SM_FloatFirstFxCurrentTrack)

  ,u = runAction(Undo)
  ,U = runAction(Redo)

  ,['<space>p'] = runAction(Play)
}
