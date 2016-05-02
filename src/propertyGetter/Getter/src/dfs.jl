importall Base.SparseMatrix
import Base.SparseMatrix: increment, increment!, decrement, decrement!, nnz

immutable cs
    nzmax::Cptrdiff_t
    m::Cptrdiff_t       #/* number of rows */
    n::Cptrdiff_t       #/* number of columns */
    p::Ptr{Cptrdiff_t}     #   /* column pointers (size n+1) or col indices (size nzmax) */
    i::Ptr{Cptrdiff_t}     #   /* row indices, size nzmax */
    x::Ptr{Cdouble}   #  /* numerical values, size nzmax */
    nz::Cptrdiff_t        ## of entries in triplet matrix, -1 for compressed-col */
end

immutable csd 
    p::Ptr{Cptrdiff_t}
    q::Ptr{Cptrdiff_t}
    r::Ptr{Cptrdiff_t}
    s::Ptr{Cptrdiff_t}
    nb::Cptrdiff_t
    rr::Ptr{Cptrdiff_t}
    cc::Ptr{Cptrdiff_t}
end

function  findNumberOfStronglyConnectedComponents(M::MatrixProperty)
  M.isSymmectric = issym(M.mm.matrix);
  M.isSquare = isequal(M.numberOfRows, M.numberOfColumns );

    M.numberOfConnectedComponent = 0;
    return M.numberOfConnectedComponent

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
    sccPtr = ccall( (:cs_scc,  :libcsparse ) , Ptr{csd}, ( Ptr{cs}, ), ptr )
    scc =  unsafe_load(sccPtr)
    M.numberOfConnectedComponent = scc.nb;
    return M.numberOfConnectedComponent
end
