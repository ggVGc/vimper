function include(path)
  local info = debug.getinfo(1,'S');
  script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
  return dofile(script_path .. path .. '.lua')
end

include('actions')

return {
  ['<space>a'] = runAction(ShowActionList)
  ,mg = Marker.Go
  ,ma = Marker.Add
  ,md = Marker.Delete
  ,mn = runAction(NextMarker)
  ,mN = runAction(PrevMarker)
  ,gg = runAction(GoProjectBeginning)
  ,G = runAction(GoProjectEnd)
  ,k = runAction(PrevTrack, SelectItemsInTrack)
  ,j = runAction(NextTrack, SelectItemsInTrack)
  ,K = runAction(PrevTrackKeepSelection)
  ,J = runAction(NextTrackKeepSelection)
  ,nm = runAction(NewMidiItem)
  
  ,a = runAction(PrevMeasure)
  ,s = runAction(NextMeasure)
  ,A = rep(4, runAction(PrevMeasure))
  ,S = rep(4, runAction(NextMeasure))

  ,q = runAction(ZoomHorizOut)
  ,w = runAction(ZoomHorizIn)
  ,Q = runAction(ZoomVertOut)
  ,W = runAction(ZoomVertIn)
  ,pz = runAction(ZoomProject)

  ,z = runAction(SetLoopStart)
  ,x = runAction(SetLoopEnd)

  ,td = runAction(RemoveTrack)
  ,tn = runAction(AddTrack)


  ,l= runAction(NextItem)
  ,h = runAction(PrevItem)
  ,['<space>p'] = runAction(Play)
}
