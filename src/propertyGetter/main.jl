workspace()
push!(LOAD_PATH, "Getter/src")

using Getter

infile = open("$(Getter.rootDirectory)/matrixlist.csv", "r");

lines2 = map(Getter.splitByComma, readlines(infile));

println("lines2: $(length(lines2))")

@everywhere startLine = 1   
@everywhere maxLineCount = 2650 #length(lines2)

refArray =  Vector{RemoteRef}( maxLineCount) 

for lineCnt = startLine  : maxLineCount
  matrixGroup = lines2[lineCnt][1];
  matrixName = lines2[lineCnt][2];
	
  s = @spawn  @elapsed Getter.getProperties(lineCnt, matrixGroup, matrixName);
  #println( " farked  $( lineCnt ) "); 
 
  refArray[ lineCnt] = s;
  lineCnt = lineCnt + 1;

  if( lineCnt % 60 == 0)
    	fetch( s )  
  end
end

println(" kalan matrixler hesaplaniyor ")
for lineCnt = startLine  : maxLineCount
	fetch( refArray[lineCnt]   )  
end

println("done!");
