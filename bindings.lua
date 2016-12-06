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
  ,pb = runAction(GoProjectBeginning)
  ,pe = runAction(GoProjectEnd)
  ,['<space>p'] = runAction(Play)
}
