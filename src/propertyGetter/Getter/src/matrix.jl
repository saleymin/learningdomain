#Pkg.add("MatrixMarket")
#using MatrixMarket

type MatrixProperty
  groupName :: AbstractString;
  name :: AbstractString;
  UFindex :: Int32;
  fileName :: AbstractString;

  mm::mmStructure;
  numberOfRows :: Int64;
  numberOfColumns :: Int64;

  nnzPerRow :: Array;
  avgNNZPerRow::Float64;
  stdNNZPerRow::Float64;
  varNNZPerRow::Float64;

  maxEig;

  isDiagonallyDominant::Bool;
  isBlockDiagonal::Bool;
  isDiagonal::Bool;

  isSymmectric::Bool;
  isSquare::Bool;
  numberOfConnectedComponent :: Int64;
  numberOfConnectedComponent2 :: Int64;
  numberOfBlockFromDmPerm :: Int64;

  #meanOfColumnValuesPerRowIncludingZeros :: Array;
  #varOfColumnValuesPerRowIncludingZeros :: Array;
  #stdOfColumnValuesPerRowIncludingZeros :: Array;

  #meanOfColumnValuesPerRow :: Array;
  #varOfColumnValuesPerRow :: Array;
  #stdOfColumnValuesPerRow :: Array;

  #makes immutable
  function  MatrixProperty(rootDirectory :: AbstractString, matrixGroup :: AbstractString, matrixName :: AbstractString, UFindex :: Int  )
    fileDirectory =  "$rootDirectory/$matrixGroup/$matrixName";
    fileName =  "$fileDirectory/$matrixName.mtx"
     if( !isfile( fileName ))
         error("File Not found: $fileName");
     end

     mm =  mmread(fileName);
     (numberOfRows, numberOfColumns) = size(mm.matrix);
#=
     # @time  meanOfColumnValuesPerRowIncludingZeros =  mean(mm.matrix,2);
     # @time varOfColumnValuesPerRowIncludingZeros =  var(mm.matrix,2);
     # @time stdOfColumnValuesPerRowIncludingZeros =  std(mm.matrix,2);

      #meanOfColumnValuesPerRow =  zeros( size(meanOfColumnValuesPerRowIncludingZeros) );
      #@time varOfColumnValuesPerRow =  var(mm.matrix,2);
      #@time stdOfColumnValuesPerRow =  std(mm.matrix,2);
=#
      T = new( matrixGroup, matrixName, UFindex, fileName, mm, numberOfRows, numberOfColumns)
      T
  end
end





