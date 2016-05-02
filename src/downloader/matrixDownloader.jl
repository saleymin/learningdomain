infile = open("/home/suleyman/phd/matrices/matrixlist.csv", "r")
lines = readlines(infile)
function splitByComma(x)
	split(x,',');
end
println("satir: $(length(lines))");
lines2 = map(splitByComma, lines);

lineCnt = 1;
matrixGroup = "";
matrixName = "";
url = "";
localFile = "";
directoryName = "";
while lineCnt <= length(lines)
	println("lines2[lineCnt]: $(lines2[lineCnt])")
	matrixGroup = lines2[lineCnt][1];
	println("matrixGroup: $(matrixGroup)")
	matrixName = lines2[lineCnt][2];
	println("matrixName $(matrixName)")
	url = "http://www.cise.ufl.edu/research/sparse/MM/" * matrixGroup * "/" * matrixName * ".tar.gz";
	matrixName = lines2[lineCnt][2];
	directoryName = "/home/suleyman/phd/matrices/" * matrixGroup ;
    localFile =  directoryName * "/" * matrixName * ".tar.gz";
	lineCnt = lineCnt + 1;

	if( isfile( "$directoryName/$matrixName.mtx"))
		continue;
	end

	if( !isdir(directoryName))
		mkdir(directoryName);
	end
	println(url)


	download(url, localFile);
 	run(`tar -xvf  $localFile  -C $directoryName`);
	#run(`mv  $directoryName/$matrixName/*.mtx $directoryName/`);
	#run(`rm -R  $directoryName/$matrixName`);
	run(`rm  $localFile`);
end

