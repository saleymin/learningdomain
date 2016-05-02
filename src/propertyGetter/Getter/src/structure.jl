
function  findNNZPerRow(M::MatrixProperty)
  M1 = spones(M.mm.matrix);
  M.nnzPerRow = sum(M1,2);

  M.avgNNZPerRow = mean(M.nnzPerRow);
  M.stdNNZPerRow = std(M.nnzPerRow);
  M.varNNZPerRow = var(M.nnzPerRow);

  M.nnzPerRow
end
