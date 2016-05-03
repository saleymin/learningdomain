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
	matrixGroup = lines2[lineCnt][1];
	matrixName = lines2[lineCnt][2];
	url = "http://www.cise.ufl.edu/research/sparse/MM/" * matrixGroup * "/" * matrixName * ".tar.gz";
	
	groupDirectory = "/home/suleyman/phd/matrices/" * matrixGroup ;
        tarFile =  groupDirectory * "/" * matrixName * ".tar.gz";
        matrixDir =  groupDirectory * "/" * matrixName * "/";
	lineCnt = lineCnt + 1;

	if( isdir( matrixDir )  )
		continue;
	end
	
	if( !isdir(groupDirectory))
		mkdir(groupDirectory);
	end

	println(url);
	println("$tarFile")
	download(url, tarFile);
	
 	run(`tar -xvf  $tarFile -C $groupDirectory`);
	#run(`rm  $tarFile`);
end

