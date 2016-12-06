function include(path)
  local info = debug.getinfo(1,'S');
  script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
  return dofile(script_path .. path .. '.lua')
end

include('actions')

return {
  mg = Marker.Go
  ,ma = Marker.Add
  ,md = Marker.Delete
  ,mn = runAction(NextMarker)
  ,mN = runAction(PrevMarker)
  ,pp = runAction(GoProjectBeginning)
  ,pP = runAction(GoProjectEnd)
  ,A = runAction(ShowActionList)
  ,k = runAction(NextMeasure)
  ,j = runAction(PrevMeasure)
  ,K = rep(4, runAction(NextMeasure))
  ,J = rep(4, runAction(PrevMeasure))
  ,h = runAction(PrevTrack)
  ,l = runAction(NextTrack)
  ,H = runAction(PrevTrackKeepSelection)
  ,L = runAction(NextTrackKeepSelection)
  ,nm = runAction(NewMidiItem)
  
  ,td = runAction(RemoveTrack)
  ,tn = runAction(AddTrack)

  ,['in'] = runAction(NextItem)
  ,iN = runAction(PrevItem)
  ,['<space>p'] = runAction(Play)
}
