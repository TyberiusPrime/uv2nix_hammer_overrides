_: old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  { postPatch = (old.postPatch or "") + "touch requirements.txt"; }
