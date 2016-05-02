function  getProperties( lineCnt::Int, matrixGroup::AbstractString, matrixName::AbstractString )
	fileName = "$rootDirectory/properties$(myid()).csv"
	println("forked  $(lineCnt)  ")
 	try
		M = Getter.MatrixProperty(rootDirectory, matrixGroup, matrixName,lineCnt);



			if(M.numberOfRows != M.numberOfColumns)
				println("id: $( myid()  ) $(lineCnt) xxx file: $(matrixGroup)/$(matrixName) m:$(M.numberOfRows) n:$(M.numberOfColumns)");
				return;
			end
			#if(M.numberOfRows > 400000)
			if(M.numberOfRows > 50000)
				println("id: $( myid()  ) $(lineCnt) yyy file: $(matrixGroup)/$(matrixName) m:$(M.numberOfRows) n:$(M.numberOfColumns)");
				return;
			end
			println("started id: $( myid()  ) $(lineCnt) file: $(matrixGroup)/$(matrixName) m:$(M.numberOfRows) n:$(M.numberOfColumns)");
			findNNZPerRow(M)

			findNumberOfStronglyConnectedComponents(M);
			dmperm(M);

			try
				if(M.isSquare)
				  findMaxEig(M);
				 end
			catch ex
				M.maxEig = 0;
				println("  eig finding error matrix :$(lineCnt)  $(ex)  ")
			end

			isDiagonallyDominant(M)
			isBlockDiagonal(M)
			isDiagonal(M)

			appendResultToFile(M, fileName);
			println("finished id: $( myid()  ) $(lineCnt) file: $(matrixGroup)/$(matrixName) m:$(M.numberOfRows) n:$(M.numberOfColumns)");
			catch ex;
				println("unexpected error matrix: $(lineCnt)  id: $(myid()) $ex file: $(matrixGroup)/$(matrixName)  ");
			return ;
   end
end
