function dmperm(M::MatrixProperty)

    x = M.mm.matrix.nzval;
    i = M.mm.matrix.rowval;
    p = M.mm.matrix.colptr;

    i = decrement(i);
    p = decrement(p);

    m = M.mm.matrix.m;
    n = M.mm.matrix.n;

    nnz = length(x);
    ptrp = pointer(p,1); # Instead define a convert method and pass the variables directly to the ccall.
    ptri = pointer(i,1);
    ptrx = pointer(x,1);
    mat = cs(nnz,m,n, ptrp, ptri, ptrx ,-1 )
	ptr = pointer_from_objref(mat);

	dmPermPtr = ccall( (:cs_dmperm,  :libcsparse ) , Ptr{csd}, ( Ptr{cs}, Cptrdiff_t ), ptr, 0 )
	dmpermResult =  unsafe_load(dmPermPtr)

	M.numberOfBlockFromDmPerm = dmpermResult.nb;
end
