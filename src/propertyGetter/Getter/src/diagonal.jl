
function isDiagonallyDominant(M::MatrixProperty)
  if(M.isSquare)
     M.isDiagonallyDominant = all( 2 * sum(abs(diag(M.mm.matrix)),2) - sum(abs(M.mm.matrix),2) .>0)
  else
     M.isDiagonallyDominant = false;
  end
  M.isDiagonallyDominant;
end

function isDiagonal(M::MatrixProperty)
  if(M.isSquare)
      M.isDiagonal = M.numberOfConnectedComponent == M.numberOfRows;
  else
      M.isDiagonal = false;
  end
  M.isDiagonal
end

function isBlockDiagonal(M::MatrixProperty)
  if(M.isSquare)
    M.isBlockDiagonal = M.numberOfConnectedComponent > 1;
  else
    M.isBlockDiagonal = false;
  end
  M.isBlockDiagonal
end
