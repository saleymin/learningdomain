function splitByComma(x)
	split(x,',');
end

function appendResultToFile(M::MatrixProperty, fileName::AbstractString)
  outfile = open(fileName, "a")

  print(outfile, "$(M.UFindex),")
  print(outfile, "\"$(M.groupName)\",")
  print(outfile, "\"$(M.name)\",")

  print(outfile, "$(M.numberOfRows),")
  print(outfile, "$(M.numberOfColumns),")

  print(outfile, "$(M.isSymmectric),")
  print(outfile, "$(M.numberOfConnectedComponent),")
  print(outfile, "$(M.numberOfBlockFromDmPerm),")
  print(outfile, "$(M.avgNNZPerRow / M.numberOfColumns),")
  print(outfile, "$(M.avgNNZPerRow),")
  print(outfile, "$(M.stdNNZPerRow),")
  print(outfile, "$(M.varNNZPerRow),")

  mag::Float64 = abs(M.maxEig)[1];

  print(outfile, "$(mag),")
  
  isLessThanZero =  real(M.maxEig) .< 0;
  print(outfile, "$( isLessThanZero[1] ),")

  print(outfile, "$(M.isDiagonallyDominant),")
  print(outfile, "$(M.isBlockDiagonal),")
  print(outfile, "$(M.isDiagonal),")

  #print(outfile, "\"$(M.mm.representation)\",")
  print(outfile, "\"$(M.mm.field)\",")
  print(outfile, "\"$(M.mm.symmetric)\",")

  if(M.mm.domain == "subsequent computational fluid dynamics problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "eigenvalue/model reduction problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "model reduction problem" ) print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "undirected weighted random graph" ) print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "theoretical/quantum chemistry problem" ) print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "directed weighted graph") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "electromagnetics problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "power network problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "directed graph") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "undirected weighted graph" ) print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "circuit simulation problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "undirected graph") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "economic problem" ) print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "chemical process simulation problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "optimization problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "2D/3D problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "computational fluid dynamics problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "subsequent circuit simulation problem") print(outfile, "1,") else print(outfile,"0,") end;
  if(M.mm.domain == "structural problem") print(outfile, "1,") else print(outfile,"0,") end;

  print(outfile, "\"$(M.mm.domain)\"")
  println(outfile)
  close(outfile)
end
